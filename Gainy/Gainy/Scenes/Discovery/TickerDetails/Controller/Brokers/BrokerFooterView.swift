//
//  BrokerFooterView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/3/21.
//

import UIKit
import Foundation

protocol BrokerFooterViewDelegate: AnyObject {
    
    func didRequestNewBroker()
}

final class BrokerFooterView: UICollectionReusableView {
    
    public weak var delegate: BrokerFooterViewDelegate?
    @IBOutlet private weak var actionButton: BorderButton!
    
    @IBAction private func onActionButtonTap(_ sender: Any) {
        
        self.delegate?.didRequestNewBroker()
    }
}
