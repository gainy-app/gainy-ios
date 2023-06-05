//
//  WithdrawInfoViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 05.06.2023.
//

import UIKit
import GainyCommon

final class WithdrawInfoViewController: BaseViewController {
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
