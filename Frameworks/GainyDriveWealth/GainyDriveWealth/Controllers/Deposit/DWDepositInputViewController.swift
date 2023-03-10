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
        loadState()
        updateSelectedAccount(userProfile.currentFundingAccounts)
        
        //If no Plaid - connect right away
        if userProfile.selectedFundingAccount == nil {
            coordinator?.startFundingAccountLink(profileID: self.dwAPI.userProfile.profileID ?? 0, from: self)
            GainyAnalytics.logEvent("dw_funding_connest_s")
            return
        }
    }
    
    /// Current KYC Data
    private var kycStatus: GainyKYCStatus?
    
    /// Load current data for state
    private func loadState() {
        showNetworkLoader()
        
        switch mode {
        case .deposit:
            titleLbl.text = "How much do you want to transfer to Gainy?"
            subTitleLbl.text = ""
            GainyAnalytics.logEvent("deposit_s")
            closeMessage = "Are you sure want to stop deposit?"
            nextBtn.configureWithTitle(title: "Deposit", color: UIColor.white, state: .disabled)
            Task {
                self.kycStatus = await userProfile.getProfileStatus()
                let fundings2 = await userProfile.getFundingAccountsWithBalanceReload()
                await MainActor.run {
                    self.updateSelectedAccount(self.userProfile.currentFundingAccounts)
                    if self.kycStatus?.depositedFunds ?? false {
                        nextBtn.configureWithTitle(title: "Enter value", color: UIColor.white, state: .disabled)
                        minInvestAmount = 0.0
                    } else {
                        nextBtn.configureWithTitle(title: "Minimum required \((self.coordinator?.remoteConfig.minInvestAmount ?? 0.0).price)", color: UIColor.white, state: .disabled)
                        minInvestAmount = (self.coordinator?.remoteConfig.minInvestAmount ?? 0.0)
                    }
                    self.hideLoader()
                }
            }
        case .withdraw:
            nextBtn.configureWithTitle(title: "Enter value", color: UIColor.white, state: .disabled)
            titleLbl.text = "How much do you want to withdraw?"
            GainyAnalytics.logEventAMP("dw_withdraw_s")
            closeMessage = "Are you sure want to stop withdraw?"
            nextBtn.configureWithTitle(title: "Withdraw", color: UIColor.white, state: .disabled)
            Task {
                self.kycStatus = await userProfile.getProfileStatus()
                let fundings2 = await userProfile.getFundingAccountsWithBalanceReload()
                await MainActor.run {
                    subTitleLbl.text = "Available amount \((self.kycStatus?.withdrawableCash ?? 0.0).priceUnchecked)"
                    self.updateSelectedAccount(self.userProfile.currentFundingAccounts)
                    self.hideLoader()
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        if let amount = amount.val {
            if mode == .deposit {
                guard amount >= minInvestAmount else {
                    showAlert(message: "Amount must be greater than or equal to $\(minInvestAmount)")
                    if !(self.kycStatus?.depositedFunds ?? false) {
                        GainyAnalytics.logEventAMP("deposit_first_amount_error", params: ["amount" : amount])
                    }
                    return
                }
            }
            
            guard (userProfile.selectedFundingAccount) != nil else {
                showAlert(message: "No account was selected. Please select or add one.")
                return
            }
            switch mode {
            case .deposit:
                coordinator?.showDepositOverview(amount:  amount)
                GainyAnalytics.logEventAMP("deposit_e", params: ["amount" : amount])
                break
            case .withdraw:
                let serverBalance = (self.kycStatus?.withdrawableCash ?? 0.0).round(to: 2)
                if abs(serverBalance - Float(amount) ) < 0.001 && amount > 0.0 {
                    coordinator?.showWithdrawOverview(amount:  Double(serverBalance))
                    GainyAnalytics.logEventAMP("withdraw_e", params: ["amount" : amount])
                    return
                }
                
                guard serverBalance >= Float(amount) else {
                    showAlert(message: "Not enough balance to withdraw")
                    return
                }
                coordinator?.showWithdrawOverview(amount:  amount)
                GainyAnalytics.logEventAMP("withdraw_e", params: ["amount" : amount])
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

