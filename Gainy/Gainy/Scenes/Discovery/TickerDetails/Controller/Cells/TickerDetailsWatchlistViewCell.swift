//
//  TickerDetailsWatchlistViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsWatchlistViewCell: TickerDetailsViewCell {
    @IBOutlet weak var watchBtn: UIButton! {
        didSet {
            watchBtn.layer.borderWidth = 2.0
        }
    }
    
    override func updateFromTickerData() {
        
    }
}
