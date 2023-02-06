//
//  DWDepositComissionViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 06.01.2023.
//

import UIKit
import GainyCommon

final class DWDepositComissionViewController: DWBaseViewController {
    
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
        
        gainyNavigationBar.configureWithItems(items: [])
    }
    
    @IBAction func backButtonTap(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
