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
    @IBOutlet private weak var addToWatchlistButton: UIButton!
    @IBOutlet private weak var compareStocksButton: UIButton!
    @IBOutlet private weak var addToWatchlistButtonWidthConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = false
    }
    
    override func updateFromTickerData() {
        tickerNameLbl.text = tickerInfo?.name.companyMarkRemoved
        symbolLbl.text = tickerInfo?.symbol
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        updateAddToWatchlistToggle()
    }
    
    @IBAction func shareAction() {
        if let url = URL(string: Constants.Links.rhLink + (tickerInfo?.symbol ?? "")) {
            if let vc = self.window?.rootViewController {
                WebPresenter.openLink(vc: vc, url: url)
            }
        }
        GainyAnalytics.logEvent("ticker_shared", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
    }
    
    public func updateAddToWatchlistToggle() {
       
        guard let symbol = tickerInfo?.symbol else {
            return
        }
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == symbol
        }
        
        self.contentView.setNeedsLayout()
        self.addToWatchlistButton.isSelected = addedToWatchlist
        self.addToWatchlistButton.backgroundColor = addedToWatchlist ? UIColor(hex: 0x0062FF) : UIColor(hex: 0xF7F8F9)
        self.addToWatchlistButtonWidthConstraint.constant = addedToWatchlist ? 118.0 : 104.0
        self.contentView.layoutIfNeeded()
    }
}
