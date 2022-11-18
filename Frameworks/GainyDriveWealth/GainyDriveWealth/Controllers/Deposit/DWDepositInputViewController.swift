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
        if let amount = amount.val {
            guard amount >= minInvestAmount else {
                showAlert(message: "Amount must be > $\(minInvestAmount)")
                return
            }
            guard (userProfile.selectedFundingAccount) != nil else {
                showAlert(message: "No account where selected. Please select or add one.")
                return
            }
            switch mode {
            case .deposit:
                coordinator?.showDepositOverview(amount:  amount)
                break
            case .withdraw:
                guard (userProfile.selectedFundingAccount?.balance ?? 0.0) >= Float(amount) else {
                    showAlert(message: "Not enough balance to withdraw")
                    return
                }
                coordinator?.showWithdrawOverview(amount:  amount)
                break
            case .invest:
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

class Amount {
    var val: Double? {
        return Double("\(left)\(isDot ? "." : "")\(right)")
    }
    
    var valStr: String {
        if val != nil {
            if right.isEmpty {
                if isDot {
                    return "$\(amountFormatter.string(from: NSNumber(value: Double(left) ?? 0.0)) ?? "")."
                } else {
                    return "$\(amountFormatter.string(from: NSNumber(value: Double(left) ?? 0.0)) ?? "")"
                }
            } else {
                return "$\(amountFormatter.string(from: NSNumber(value: Double(left) ?? 0.0)) ?? "").\(right)"
            }
        } else {
            return "$"
        }
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        return formatter
    }()
    
    var left: String = ""
    
    var right: String = ""
    
    var isDot: Bool = false
    
    func addDigit(digit: String) {
        if isDot && digit == "." {
            return
        }
        if digit == "." && !isDot {
            if left.isEmpty {
                left += "0"
            }
            isDot = true
        } else {
            if isDot {
                right += digit
            } else {
                left += digit
            }
        }
    }
    
    func deleteDigit() {
        if !right.isEmpty {
            right = String(right.dropLast())
        } else {
            if isDot {
                isDot = false
            } else {
                left = String(left.dropLast())
            }
        }
    }
}
