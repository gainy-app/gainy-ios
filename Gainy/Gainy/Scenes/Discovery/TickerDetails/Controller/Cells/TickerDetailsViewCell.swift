//
//  TickerDetailsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

/// Base Ticker TableView cell
class TickerDetailsViewCell: UITableViewCell {
    
    var tickerInfo: TickerInfo? {
        didSet {
            updateFromTickerData()
        }
    }
    
    func updateFromTickerData() {
        
    }
}
