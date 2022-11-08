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
        userProfile.fundingAccountsPublisher.sink { [weak self] accounts in
            guard let self else { return }
            self.subTitleLbl.isHidden = true
            self.amountFlv.isHidden = true
            if (self.userProfile.selectedFundingAccount?.balance ?? 0) > 0 {
                self.subTitleLbl.isHidden = false
                self.amountFlv.isHidden = false
                self.subTitleLbl.text = "Buying power $\(self.userProfile.selectedFundingAccount?.balance)"
            }
            if accounts.count < 2 {
                self.addAccountBtn.mode = .add
                self.accountBtn.isHidden = true
            } else {
                self.addAccountBtn.mode = .dropdown
                self.accountBtn.isHidden = false
                self.accountBtn.mode = .info(title: self.userProfile.selectedFundingAccount?.name ?? "")
            }
        }.store(in: &cancellables)
        loadState()
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
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        if let amount = Double(String(amountFlv.text!.dropFirst())) {
            guard amount > 10 else {
                showAlert(message: "Amount must be > $10")
                return
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
            
        } else {
            showAlert(message: "Amount is not valid")
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
        nextBtn.isEnabled = Double(String(amountFlv.text!.dropFirst())) != nil
    }
}

