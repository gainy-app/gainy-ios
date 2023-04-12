//
//  ChartDisclaimerViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 12.04.2023.
//

import UIKit
import GainyCommon

final class ChartDisclaimerViewController: BaseViewController {
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
    
    @IBOutlet private weak var bottomLbl: UILabel! {
        didSet {
            bottomLbl.font = .proDisplayRegular(14)
            bottomLbl.setLineHeight(lineHeight: 24, textAlignment: .center)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func backButtonTap(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
