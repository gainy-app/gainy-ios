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
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Ok, got it", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Ok, got it", color: UIColor.white, state: .disabled)
        }
    }
    @IBOutlet private weak var contentLbl: UILabel! {
        didSet {
            contentLbl.attributedText = "Electronic deposits to your account via ACH will typically take 1-4 business days to clear. ACH deposits must remain in your account for a minimum of thirty (30) days after the funds clear prior to being able to withdraw. Other restrictions may apply if fraud or other potential anti-money laundering concerns are raised.".attr(font: .proDisplayRegular(14), lineHeight: 10)
        }
    }
    
    //MARK: - Actions
    @IBAction func backButtonTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
