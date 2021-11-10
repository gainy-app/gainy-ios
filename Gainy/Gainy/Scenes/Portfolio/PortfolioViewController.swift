//
//  PortfolioViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit

final class PortfolioViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var plaidLinkBtn: UIButton!
    
    
    //MARK: - Action
    @IBAction func plaidLinkAction(_ sender: Any) {
        showNetworkLoader()
        
        presentPlaidLinkUsingLinkToken("Need token")
    }
}
