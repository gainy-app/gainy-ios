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
        loadState()
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
        }
    }
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        if let amount = Double(String(amountFlv.text!.dropFirst())) {
            
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
            let alert = UIAlertController.init(title: "Error", message: "Amount is not valid", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default))
            present(alert, animated: true)
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
        nextBtn.isEnabled = Double(String(amountFlv.text!.dropFirst())) != nil
    }
}
