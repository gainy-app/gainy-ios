//
//  DepositInputViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import GainyCommon

final class DWDepositInputViewController: DWBaseViewController {
    
    enum Mode {
        case deposit, withdraw, invest
    }
    
    var mode: Mode = .deposit
    
    
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
}
