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
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func loadState() {
        initDateLbl.text = AppDateFormatter.shared.string(from: Date(), dateFormat: .MMMddyyyy).uppercased()
        availDateLbl.text = AppDateFormatter.shared.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date(), dateFormat: .MMMddyyyy).uppercased()
        amountLbl.text = amount.price
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        switch mode {
            case .deposit:
                titleLbl.text = "Deposit Overview"
                GainyAnalytics.logEvent("dw_deposit_overview_s")
                closeMessage = "Are you sure want to stop deposit?"
            case .withdraw:
                titleLbl.text = "Withdraw Overview"
                GainyAnalytics.logEvent("dw_deposit_withdraw_s")
                closeMessage = "Are you sure want to stop withdraw?"
        }
        
        showNetworkLoader()
        Task {
            let accountNumber = await userProfile.getProfileStatus()
            await MainActor.run {
                kycNumberLbl.text = accountNumber?.accountNo
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
            Task {
                do {
                    let res = try await dwAPI.depositFunds(amount:amount, fundingAccountId: fundingAccount.id)
                    await MainActor.run {
                        coordinator?.showDepositDone(amount:  amount, tradingFlowId: res.tradingMoneyFlowId)
                    }
                    GainyAnalytics.logEvent("dw_deposit_overview_e", params: ["amount" : amount])
                } catch {
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
            Task {
                do {
                    let res = try await dwAPI.withdrawFunds(amount: amount, fundingAccountId: fundingAccount.id)
                    await MainActor.run {
                        coordinator?.showWithdrawDone(amount:  amount, tradingFlowId: res.tradingMoneyFlowId)
                        GainyAnalytics.logEvent("dw_withdraw_overview_e", params: ["amount" : amount])
                    }
                } catch {
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
    }
}
