//
//  TickerDetailsWatchlistViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsWatchlistViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 120.0
    
    @IBOutlet weak var watchBtn: UIButton! {
        didSet {
            watchBtn.layer.borderWidth = 2.0
        }
    }
    
    override func updateFromTickerData() {
        
    }
    
    @IBAction func addToWatchAction(_ sender: Any) {
        GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : tickerInfo?.symbol ?? "", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        NotificationManager.shared.showMessage(title: "Beta version", text: "Sorry, feature in development", cancelTitle: "OK", actions: nil)
    }
}
