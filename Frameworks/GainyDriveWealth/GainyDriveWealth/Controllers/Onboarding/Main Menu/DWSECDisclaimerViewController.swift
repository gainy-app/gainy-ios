//
//  DWSECDisclaimerViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 15.04.2023.
//

import UIKit
import GainyCommon

final class DWSECDisclaimerViewController: DWBaseViewController {
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.setKern()
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Ok, sounds good", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Ok, sounds good", color: UIColor.white, state: .disabled)
        }
    }
    
    @IBOutlet private weak var bottomLbl1: UILabel! {
        didSet {
            bottomLbl1.font = .proDisplayMedium(14)
            bottomLbl1.setLineHeight(lineHeight: 24, textAlignment: .left)
        }
    }
    
    @IBOutlet private weak var bottomLbl2: UILabel! {
        didSet {
            bottomLbl2.font = .proDisplayMedium(14)
            bottomLbl2.setLineHeight(lineHeight: 24, textAlignment: .left)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        gainyNavigationBar.configureWithItems(items: [])
    }
    
    @IBAction func backButtonTap(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
