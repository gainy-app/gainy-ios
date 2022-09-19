//
//  DWDepositInputDoneViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import UIKit
import GainyCommon

final class DWDepositInputDoneViewController: DWBaseViewController {
        
    
    var amount: Double = 0.0
    var mode: DWDepositMode = .deposit
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplayBold(32)
        }
    }
    
    @IBOutlet private weak var infoLbl: UILabel! {
        didSet {
            infoLbl.font = UIFont.proDisplayMedium(16)
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Done", color: UIColor.white, state: .normal)
        }
    }
    
    @IBOutlet private weak var detailsBtn: UIButton! {
        didSet {
            detailsBtn.titleLabel?.font = .proDisplayRegular(16)
            detailsBtn.layer.cornerRadius = 24.0
            detailsBtn.clipsToBounds = true
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
            titleLbl.text = "Congrats!\nYour first deposit initiated"
            infoLbl.text = "We’re ready for your $\(amount) deposit, but won’t initiate it until your investing application is approved.\n\nPleace make shure to maintain a balance of $\(amount) in your bank account until the transfer is complete to avoid any issues."
        case .withdraw:
            titleLbl.text = "Congrats!\nYour first deposit initiated"
            infoLbl.text = "We’re ready for your $\(amount) deposr, but won’t initiate it until your investing application is approved.\n\nPleace make shure to maintain a balsnce of $\(amount) in your bank account until the transfer is complete to avoid any issues."
        case .invest:
            titleLbl.text = "Congrats!\nYour first deposit initiated"
            infoLbl.text = "We’re ready for your $\(amount) deposr, but won’t initiate it until your investing application is approved.\n\nPleace make shure to maintain a balsnce of $\(amount) in your bank account until the transfer is complete to avoid any issues."
        }
    }
    
    
    
}
