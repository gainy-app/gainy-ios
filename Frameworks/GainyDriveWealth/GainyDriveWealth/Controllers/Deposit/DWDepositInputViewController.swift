//
//  DepositInputViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import GainyCommon

enum DWDepositMode {
    case deposit, withdraw, invest
}

final class DWDepositInputViewController: DWBaseViewController {
    
    var mode: DWDepositMode = .deposit
    
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
            nextBtn.configureWithTitle(title: "Minimum required $10", color: UIColor.white, state: .disabled)
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
        loadState()
        updateSelectedAccount(userProfile.currentFundingAccounts)
    }
    
    private func loadState() {
        switch mode {
        case .deposit:
            titleLbl.text = "How much do you want to transfer to Gainy?"
            subTitleLbl.text = "Minimum required $10"
        case .withdraw:
            titleLbl.text = "How much do you want to withdraw?"
            subTitleLbl.text = "Minimum required $10"
        case .invest:
            titleLbl.text = "How much do you want to invest?"
            subTitleLbl.text = "Available $1,468.13"
            nextBtn.configureWithTitle(title: "Overview", color: UIColor.white, state: .normal)
        }
    }
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        if let amount = Double(String(amountFlv.text!.dropFirst())) {
            guard amount >= minInvestAmount else {
                showAlert(message: "Amount must be > $\(minInvestAmount)")
                return
            }
            switch mode {
            case .deposit:
                coordinator?.showDepositOverview(amount:  amount)
                break
            case .withdraw:
                coordinator?.showWithdrawOverview(amount:  amount)
                break
            case .invest:
                break
            }
        } else {
            showAlert(message: "Amount is not valid")
        }
    }
    
    //MARK: - Plaid Connect
    
    override func plaidLinked(token: Int, plaidAccounts: [PlaidAccountToLink]) {
        super.plaidLinked(token: token, plaidAccounts: plaidAccounts)
        
        hideLoader()
        showPlaidAccsToLink(token: token, plaidAccounts: plaidAccounts)
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    /// Showing Plaid account which can be added as Trading
    /// - Parameters:
    ///   - token: Plaid token
    ///   - plaidAaccounts: Plaid accounts
    private func showPlaidAccsToLink(token: Int, plaidAccounts: [PlaidAccountToLink]) {
        let alertController = UIAlertController(title: "Plaid Account Link", message: "Which account you would like to add?", preferredStyle: .actionSheet)
        
        for plaidAaccount in plaidAccounts {
            let sendButton = UIAlertAction(title: "\(plaidAaccount.name) - $\(amountFormatter.string(from: NSNumber(value: plaidAaccount.balanceAvailable)) ?? "")", style: .default, handler: { (action) -> Void in
                
                self.showNetworkLoader()
                Task {
                    do {
                        let createdLinkToken = try await self.dwAPI.linkTradingAccount(accessToken: token, plaidAccount: plaidAaccount)
                    } catch {
                        print("Create link failed: \(error)")
                    }
                    await MainActor.run {
                        self.hideLoader()
                    }
                }
            })
            alertController.addAction(sendButton)
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            
        })
        alertController.addAction(cancelBtn)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addAccountDidTap(_ sender: UIButton) {
        if userProfile.currentFundingAccounts.count < 2 {
            startFundingAccountLink(profileID: userProfile.profileID ?? 0)
        } else {
            coordinator?.showSelectAccountView()
        }
    }
}

extension DWDepositInputViewController: GainyPadViewDelegate {
    func deleteDigit(view: GainyPadView) {
        guard amountFlv.text!.count > 1 else {return}
        amountFlv.text = String(amountFlv.text!.dropLast(1))
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        amountFlv.text?.append(digit)
        validateAmount()
    }
    
    func validateAmount() {
        let val = Double(String(amountFlv.text!.dropFirst()).replacingOccurrences(of: ",", with: ""))
        nextBtn.isEnabled = val != nil
        if let val {
            amountFlv.text = "$" + (amountFormatter.string(from: NSNumber.init(value: val)) ?? "")
        }
    }
}
