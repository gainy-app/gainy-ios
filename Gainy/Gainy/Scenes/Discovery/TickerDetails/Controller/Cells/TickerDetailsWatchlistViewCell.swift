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
    
    @IBOutlet weak var watchBtn: BorderButton! {
        didSet {
            watchBtn.titleLabel?.lineBreakMode = .byWordWrapping
            watchBtn.titleLabel?.textAlignment = .center
        }
    }
    @IBOutlet weak var tradeBtn: BorderButton! {
        didSet {
            tradeBtn.layer.borderWidth = 2.0
        }
    }
    @IBOutlet weak var changeCurrentBrokerBtn: BorderButton!
    
    override func updateFromTickerData() {
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        watchBtn.layer.borderWidth = 2.0
        updateTitle()
        
        if let selectedBroker = UserProfileManager.shared.selectedBrokerToTrade {
            changeCurrentBrokerBtn.isHidden = false
            changeCurrentBrokerBtn.setTitle("Change current broker — " + selectedBroker.brokerName, for: .normal)
            changeCurrentBrokerBtn.titleLabel?.textColor = UIColor.init(hexString: "#0062FF")
        } else {
            changeCurrentBrokerBtn.isHidden = true
        }
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
    
    @IBAction func tradeAction(_ sender: Any) {
        
        guard let symbol = tickerInfo?.symbol else {
            return
        }
        GainyAnalytics.logEvent("ticker_trade_pressed", params: ["tickerSymbol" : symbol])
        if let currentBroker = UserProfileManager.shared.selectedBrokerToTrade {
            if let url = currentBroker.brokerURLWithSymbol(symbol: symbol) {
                
                if let vc = self.window?.rootViewController {
                    WebPresenter.openLink(vc: vc, url: url)
                }
                GainyAnalytics.logEvent("ticker_trade_link_shared", params: ["tickerSymbol" : symbol])
                
            }
            return
        }
        
        self.showBrokersList()
    }
    
    @IBAction func changeCurrentBrokerAction(_ sender: Any) {
        
        self.showBrokersList()
    }
    
    private func showBrokersList() {
        
        guard let symbol = tickerInfo?.symbol else {
            return
        }
        
        self.delegate?.didRequestShowBrokersListForSymbol(symbol: symbol)
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
            title = NSLocalizedString("Remove from\nWatchlist", comment: "Remove from Watchlist")
        }
        watchBtn.setTitle(title, for: UIControl.State.normal)
        watchBtn.titleLabel?.font = .proDisplayRegular(Deviice.current.size == .screen4Dot7Inches ? 13 : 16)
    }
}
