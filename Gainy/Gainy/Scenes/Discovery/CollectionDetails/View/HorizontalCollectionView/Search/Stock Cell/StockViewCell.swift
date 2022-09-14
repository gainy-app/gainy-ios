//
//  StockViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.08.2021.
//

import UIKit
import GainyAPI

final class StockViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var growthLbl: UILabel!
   
    @IBOutlet private weak var addToWatchlistToggle: UIButton!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        updateAddToWatchlistToggle()
    }
    
    var ticker: RemoteTickerDetails? {
        didSet {
            if let ticker = ticker {
                nameLbl.text = ticker.name?.companyMarkRemoved ?? ""
                symbolLbl.text = ticker.symbol
                let priceChange = (ticker.realtimeMetrics?.relativeDailyChange ?? 0.0) * 100.0
                priceLbl.text = ticker.realtimeMetrics?.actualPrice?.price ?? ""
                priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
                growthLbl.text = priceChange.percentRaw
                
                addToWatchlistToggle.addTarget(self, action: #selector(addToWatchlistToggleAction(_:)), for: .touchUpInside)
            }
        }
    }
    
    @objc fileprivate func addToWatchlistToggleAction(_ sender: UIButton) {
        
        guard let ticker  = self.ticker else {
            return
        }
        let symbol = ticker.symbol
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        if addedToWatchlist {
            GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.removeTickerFromWatchlist(symbol) { success in
                if success {
                    sender.isSelected = false
                }
            }
        } else {
            GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                if success {
                    sender.isSelected = true
                }
            }
        }
    }
    
    fileprivate func updateAddToWatchlistToggle() {
       
        guard let ticker  = self.ticker else {
            return
        }
        let symbol = ticker.symbol
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        self.addToWatchlistToggle.isSelected = addedToWatchlist
    }
}
