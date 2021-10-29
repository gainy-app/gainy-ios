//
//  TickerDetailsWatchlistViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsWatchlistViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 120.0
    
    @IBOutlet weak var watchBtn: UIButton!
    
    override func updateFromTickerData() {
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        watchBtn.layer.borderWidth = 2.0
        updateTitle()
    }
    
    @IBAction func addToWatchAction(_ sender: Any) {
        
        guard let symbol = tickerInfo?.symbol else {
            return
        }
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        if addedToWatchlist {
            GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.removeTickerFromWatchlist(symbol) { success in
                self.updateTitle()
            }
        } else {
            GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                self.updateTitle()
            }
        }
    }
    
    private func updateTitle() {
        
        guard let symbol = tickerInfo?.symbol else {
            return
        }
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        var title = NSLocalizedString("Add to Watchlist", comment: "Add to Watchlist")
        if addedToWatchlist {
            title = NSLocalizedString("Remove from Watchlist", comment: "Remove from Watchlist")
        }
        watchBtn.setTitle(title, for: UIControl.State.normal)
    }
}
