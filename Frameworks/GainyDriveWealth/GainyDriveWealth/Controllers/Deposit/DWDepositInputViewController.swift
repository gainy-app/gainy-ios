//
//  DepositInputViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import GainyCommon

enum DWDepositMode {
    case deposit, withdraw
}

final class DWDepositInputViewController: DWBaseViewController {
    
    var mode: DWDepositMode = .deposit
    
    private var amount = Amount()
    
    //MARK: - Outlets
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    
    @IBOutlet private weak var subTitleLbl: UILabel! {
        didSet {
            subTitleLbl.font = UIFont.proDisplaySemibold(16)
        }
    }
    
    @IBOutlet private weak var amountFlv: UITextField! {
        didSet {
            amountFlv.font = .proDisplayBold(48)
            amountFlv.isEnabled = false
        }
    }
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
        }
    }
    @IBOutlet weak var accountBtn: DWAccountButton! {
        didSet {
            accountBtn.mode = .info(title: userProfile.selectedFundingAccount?.name ?? "")
        }
    }
    @IBOutlet weak var addAccountBtn: DWAccountButton!{
        didSet {
            addAccountBtn.mode = .add
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Review", color: UIColor.white, state: .normal)
            
            validateAmount()
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfile.fundingAccountsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] accounts in
                self?.updateSelectedAccount(accounts)
            }.store(in: &cancellables)
    }
    
    private func updateSelectedAccount(_ accounts: [GainyFundingAccount]) {
        if accounts.isEmpty {
            addAccountBtn.mode = .add
            accountBtn.isHidden = true
        } else {
            if accounts.count < 2 {
                accountBtn.isHidden = false
            } else {
                addAccountBtn.mode = .dropdown
            }
            accountBtn.isHidden = false
            accountBtn.mode = .info(title: userProfile.selectedFundingAccount?.name ?? "")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareView()
    }
    
    private func prepareView() {
        //If no Plaid - connect right away
        guard userProfile.selectedFundingAccount != nil else {
            coordinator?.startFundingAccountLink(profileID: self.dwAPI.userProfile.profileID ?? 0, from: self)
            GainyAnalytics.logEvent("dw_funding_connest_s")
            return
        }
        
        loadState()
        updateSelectedAccount(userProfile.currentFundingAccounts)
    }
    
    /// Current KYC Data
    private var kycStatus: GainyKYCStatus?
    
    /// Load current data for state
    private func loadState() {
        switch mode {
        case .deposit:
            titleLbl.text = "How much do you want to transfer to Gainy?"
            subTitleLbl.text = "Minimum required $10"
            GainyAnalytics.logEvent("dw_deposit_s")
            closeMessage = "Are you sure want to stop deposit?"
            showNetworkLoader()
            Task {
                self.kycStatus = await userProfile.getProfileStatus()
                let fundings2 = await userProfile.getFundingAccountsWithBalanceReload()
                await MainActor.run {
                    self.updateSelectedAccount(self.userProfile.currentFundingAccounts)
                    if self.kycStatus?.depositedFunds ?? false {
                        nextBtn.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
                        minInvestAmount = 0.0
                    } else {
                        nextBtn.configureWithTitle(title: "Minimum required $500", color: UIColor.white, state: .disabled)
                        minInvestAmount = 500
                    }
                    self.hideLoader()
                }
            }
        case .withdraw:
            nextBtn.configureWithTitle(title: "", color: UIColor.white, state: .disabled)
            titleLbl.text = "How much do you want to withdraw?"
            subTitleLbl.text = "Minimum required $10"
            GainyAnalytics.logEvent("dw_withdraw_s")
            closeMessage = "Are you sure want to stop withdraw?"
        }
    }
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        if let amount = amount.val {
            guard amount >= minInvestAmount else {
                showAlert(message: "Amount must be greater than or equal to $\(minInvestAmount)")
                return
            }
            guard (userProfile.selectedFundingAccount) != nil else {
                showAlert(message: "No account was selected. Please select or add one.")
                return
            }
            switch mode {
            case .deposit:
                coordinator?.showDepositOverview(amount:  amount)
                GainyAnalytics.logEvent("dw_deposit_e", params: ["amount" : amount])
                break
            case .withdraw:
                guard (userProfile.selectedFundingAccount?.balance ?? 0.0) >= Float(amount) else {
                    showAlert(message: "Not enough balance to withdraw")
                    return
                }
                coordinator?.showWithdrawOverview(amount:  amount)
                GainyAnalytics.logEvent("dw_withdraw_e", params: ["amount" : amount])
                break
            }
        } else {
            showAlert(message: "Amount is not valid")
        }
    }
    
    @IBAction func addAccountDidTap(_ sender: UIButton) {
        if userProfile.currentFundingAccounts.isEmpty {
            coordinator?.startFundingAccountLink(profileID: userProfile.profileID ?? 0, from: self)
        } else {
            coordinator?.showSelectAccountView() { [weak self] in
                guard let self else { return }
                self.updateSelectedAccount(self.userProfile.currentFundingAccounts)
            }
        }
    }
}

extension DWDepositInputViewController: GainyPadViewDelegate {
    func deleteDigit(view: GainyPadView) {
        guard amountFlv.text!.count > 1 else {return}
        amount.deleteDigit()
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        amount.addDigit(digit: digit)
        validateAmount()
    }
    
    func validateAmount() {
        nextBtn.isEnabled = amount.val != nil
        amountFlv.text = amount.valStr
    }
}

