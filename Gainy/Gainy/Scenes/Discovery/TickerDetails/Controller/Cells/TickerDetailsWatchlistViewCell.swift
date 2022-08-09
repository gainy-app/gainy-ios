//
//  TickerDetailsWatchlistViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import Deviice

protocol TickerDetailsWatchlistViewCellDelegate: AnyObject {
    
    func didRequestShowBrokersListForSymbol(symbol: String)
}

final class TickerDetailsWatchlistViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 153.0
    static let cellHeightExpanded: CGFloat = 153.0
    
    public weak var delegate: TickerDetailsWatchlistViewCellDelegate?
    
    
    @IBOutlet weak var changeCurrentBrokerBtn: BorderButton!
    
    override func updateFromTickerData() {
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        
        if let selectedBroker = UserProfileManager.shared.selectedBrokerToTrade {
            changeCurrentBrokerBtn.isHidden = false
            changeCurrentBrokerBtn.setTitle("Change current broker — " + selectedBroker.brokerName, for: .normal)
            changeCurrentBrokerBtn.titleLabel?.textColor = UIColor.init(hexString: "#0062FF")
        } else {
            changeCurrentBrokerBtn.isHidden = true
        }
    }
    
    @IBAction func tradeAction(_ sender: Any) {
    }
}
