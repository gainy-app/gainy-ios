//
//  DWDepositInputReviewViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import UIKit
import GainyCommon

final class DWDepositInputReviewViewController: DWBaseViewController {
    
    
    var amount: Double = 0.0
    var mode: DWDepositMode = .deposit
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Transfer", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Transfer", color: UIColor.white, state: .disabled)
        }
    }
    @IBOutlet private weak var readMoreBtn: GainyButton!{
        didSet {
            readMoreBtn.configureWithTitle(title: "Read more about Commissions structure", color: UIColor.init(hexString: "#0062FF")!, state: .normal)
            readMoreBtn.configureWithTitle(title: "Read more about Commissions structure", color: UIColor.init(hexString: "#0062FF")!, state: .disabled)
            readMoreBtn.configureWithBackgroundColor(color: .white)
            readMoreBtn.configureWithDisabledBackgroundColor(color: .white)
            readMoreBtn.configureWithHighligtedBackgroundColor(color: .white)
            readMoreBtn.configureWithFont(font: .proDisplayRegular(14))
        }
    }
    @IBOutlet private var labels: [UILabel]! {
        didSet {
            labels.forEach({$0.font = .proDisplaySemibold(16)})
        }
    }
    @IBOutlet private weak var initDateLbl: UILabel!
    @IBOutlet private weak var availDateLbl: UILabel!
    @IBOutlet private weak var statusLbl: UILabel!
    @IBOutlet private weak var amountLbl: UILabel!
    @IBOutlet private weak var accountLbl: UILabel!
    @IBOutlet private weak var kycNumberLbl: UILabel!
    
    @IBOutlet private weak var bottomLbl: UILabel! {
        didSet {
            bottomLbl.font = .proDisplayRegular(14)
            bottomLbl.setLineHeight(lineHeight: 20, textAlignment: .center, color: bottomLbl.textColor)
        }
    }
    @IBOutlet private weak var commissionView: UIStackView!
      
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readMoreBtn.configureWithFont(font: .proDisplayRegular(14))
        self.gainyNavigationBar.configureWithItems(items: [.close, .back])
        self.gainyNavigationBar.backActionHandler = {[weak self] sender in
            self?.coordinator?.pop()
        }
        loadState()
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private var kycStatus: GainyKYCStatus?
    private func loadState() {
        initDateLbl.text = AppDateFormatter.shared.string(from: Date(), dateFormat: .MMMddyyyy).uppercased()
        availDateLbl.text = AppDateFormatter.shared.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(), dateFormat: .MMMddyyyy).uppercased()
        amountLbl.text = amount.priceRaw
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        switch mode {
            case .deposit:
                titleLbl.text = "Deposit Overview"
            GainyAnalytics.logEventAMP("deposit_overview_s", params: ["amount" : amount])
                closeMessage = "Are you sure want to stop deposit?"
            commissionView.isHidden = false
            case .withdraw:
                titleLbl.text = "Withdraw Overview"
                GainyAnalytics.logEventAMP("withdraw_overview_s")
                closeMessage = "Are you sure want to stop withdraw?"
            commissionView.isHidden = true
        }
        
        showNetworkLoader()
        Task {
            self.kycStatus = await userProfile.getProfileStatus()
            await MainActor.run {
                kycNumberLbl.text = self.kycStatus?.accountNo
                hideLoader()
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func transferAction(_ sender: UIButton) {
        guard let fundingAccount = userProfile.selectedFundingAccount else {
            showAlert(message: "No account was selected. Please get back to the previous step.")
            return
        }
        
        switch mode {
        case .deposit:
            sender.isEnabled = false
            showNetworkLoader()
            GainyAnalytics.logEventAMP("deposit_overview_e", params: ["amount" : amount])
            Task {
                do {
                    let res = try await dwAPI.depositFunds(amount:amount, fundingAccountId: fundingAccount.id)
                    await MainActor.run {
                        if kycStatus?.depositedFunds ?? false {
                            coordinator?.showOrderSpaceDone(amount: amount, collectionId: 0, name : "", mode: .deposit, type: .ttf)
                        } else {
                            coordinator?.showOrderSpaceDone(amount: amount, collectionId: 0, name : "", mode: .firstDeposit, type: .ttf)
                        }
                        userProfile.resetKycStatus()
                    }
                    NotificationCenter.default.post(name: Notification.Name.init("dwBalanceUpdatedNotification"), object: nil)
                    GainyAnalytics.logEventAMP("deposit_done", params: ["amount" : amount])
                } catch {
                    GainyAnalytics.logEventAMP("deposit_transfer_error", params: ["error" : error.localizedDescription])
                    await MainActor.run {
                        showAlert(message: "\(error.localizedDescription)")
                        hideLoader()
                    }
                }
                await MainActor.run {
                    sender.isEnabled = true
                    hideLoader()
                }
            }
            break
        case .withdraw:
                sender.isEnabled = false
                showNetworkLoader()
                GainyAnalytics.logEventAMP("withdraw_overview_e", params: ["amount" : amount])
                Task {
                    do {
                        let res = try await dwAPI.withdrawFunds(amount: amount, fundingAccountId: fundingAccount.id)
                        await MainActor.run {
                            coordinator?.showOrderSpaceDone(amount: amount, collectionId: 0, name : "", mode: .withdraw, type: .ttf)
                            NotificationCenter.default.post(name: Notification.Name.init("dwBalanceUpdatedNotification"), object: nil)
                            GainyAnalytics.logEventAMP("withdraw_done", params: ["amount" : amount])
                            userProfile.resetKycStatus()
                        }
                    } catch {
                        GainyAnalytics.logEventAMP("withdraw_transfer_error", params: ["error" : error.localizedDescription])
                        await MainActor.run {
                            showAlert(message: "\(error.localizedDescription)")
                            hideLoader()
                        }
                    }
                    await MainActor.run {
                        sender.isEnabled = true
                        hideLoader()
                    }
                }
                break
        }
        
        NotificationCenter.default.post(name: Notification.Name.init("dwBalanceUpdatedNotification"), object: nil)
        userProfile.resetKycStatus()
    }
    
    @IBAction func comissionsAction(_ sender: UIButton) {
        coordinator?.showDepositCommissionView {
            
        }
    }
}
