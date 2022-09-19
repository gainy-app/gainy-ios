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
    
    
}
