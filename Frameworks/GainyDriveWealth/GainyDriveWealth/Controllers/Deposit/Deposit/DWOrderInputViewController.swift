//
//  DWOrderInputViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon

enum DWOrderInputMode {
    case invest, buy, sell
}

final class DWOrderInputViewController: DWBaseViewController {
    
    var collectionId: Int = 0
    var name : String = ""
    
    var mode: DWOrderInputMode = .invest
    
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
            accountBtn.mode = .info(title: "Checking - 1013")
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userProfile.fundingAccountsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] accounts in
                self?.updateSelectedAccount(accounts)
            }.store(in: &cancellables)
        loadState()
    }
    
    private func updateSelectedAccount(_ accounts: [GainyFundingAccount]) {
        subTitleLbl.isHidden = true
        amountFlv.isHidden = true
        if (userProfile.selectedFundingAccount?.balance ?? 0) > 0 {
            subTitleLbl.isHidden = false
            amountFlv.isHidden = false
            subTitleLbl.text = "Buying power $\(userProfile.selectedFundingAccount?.balance ?? 0.0)"
        }
        if accounts.count < 2 {
            addAccountBtn.mode = .add
            accountBtn.isHidden = true
        } else {
            addAccountBtn.mode = .dropdown
            accountBtn.isHidden = false
            accountBtn.mode = .info(title: userProfile.selectedFundingAccount?.name ?? "")
        }
    }

    private func loadState() {
        switch mode {
        case .invest:
            titleLbl.text = "How much do you want to invest?"
            nextBtn.configureWithTitle(title: "Overview", color: UIColor.white, state: .normal)
        case .buy:
            titleLbl.text = "How much do you want to buy?"
            nextBtn.configureWithTitle(title: "Buy", color: UIColor.white, state: .normal)
        case .sell:
            titleLbl.text = "How much do you want to sell?"
            nextBtn.configureWithTitle(title: "Sell", color: UIColor.white, state: .normal)
        }
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        proceedToPayment()
    }
    
    ///  Payment validation
    private func proceedToPayment() {
        
        guard let amount = Double(String(amountFlv.text!.dropFirst())) else  {
            showAlert(message: "Amount must not be empty")
            return
        }
        guard amount >= minInvestAmount else {
            showAlert(message: "Amount must be > $\(minInvestAmount))")
            return
        }
        guard let selectedAcc = userProfile.selectedFundingAccount else {
            showAlert(message: "Funding Account is required. Add one isung '+' button")
            return
        }
        if mode == .invest || mode == .buy {
            guard Double(selectedAcc.balance ?? 0.0) > amount else {
                showAlert(message: "Not enough balance to \(mode == .invest ? "invest" : "buy"). Deposit amount to fill the requirements.")
                return
            }
        }
        switch mode {
        case .invest:
            coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .invest)
        case .buy:
            coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .buy)
            break
        case .sell:
            coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .sell)
            break
        }
    }
    
    @IBAction func addAccountDidTap(_ sender: UIButton) {
        if userProfile.currentFundingAccounts.count < 2 {
            startFundingAccountLink(profileID: userProfile.profileID ?? 0)
        } else {
            coordinator?.showSelectAccountView()
        }
    }
    
}

extension DWOrderInputViewController: GainyPadViewDelegate {
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

