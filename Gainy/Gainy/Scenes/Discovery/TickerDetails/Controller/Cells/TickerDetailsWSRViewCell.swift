//
//  TickerDetailsWSRViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsWSRViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 270.0
    
    @IBOutlet weak var analyticsLbl: UILabel!
    
    override func updateFromTickerData() {
        analyticsLbl.text = "\(tickerInfo?.wsrAnalystsCount ?? 0) analysts reported"
    }
}
