//
//  HoldingsInProgressViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.12.2021.
//

import Foundation
import UIKit

protocol HoldingsInProgressViewControllerDelegate: AnyObject {
    func discoveryPressed(vc: HoldingsInProgressViewController)
}

final class HoldingsInProgressViewController: BaseViewController {
    
    weak var delegate: HoldingsInProgressViewControllerDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var infoLbl: UILabel!
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func moveAction(_ sender: Any) {
        delegate?.discoveryPressed(vc: self)
    }
}
