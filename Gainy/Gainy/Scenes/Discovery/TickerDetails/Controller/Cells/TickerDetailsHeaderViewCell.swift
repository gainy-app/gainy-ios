//
//  TickerDetailsHeaderViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsHeaderViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 120.0
    
    @IBOutlet private weak var tickerNameLbl: UILabel!
    @IBOutlet private weak var symbolLbl: UILabel!
    
    override func updateFromTickerData() {
        tickerNameLbl.text = tickerInfo?.name
        symbolLbl.text = tickerInfo?.symbol
    }
    
    @IBAction func shareAction() {
        GainyAnalytics.logEvent("ticker_shared", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
    }
}
