//
//  TickerDetailsHeaderViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsHeaderViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 100.0
    
    @IBOutlet private weak var tickerNameLbl: UILabel!
    @IBOutlet private weak var symbolLbl: UILabel!
    @IBOutlet private weak var addToWatchlistButton: UIButton! {
        didSet {
            let selectedImage = UIImage.init(named: "add_coll_from_wl")
            let normalImage = UIImage.init(named: "remove_coll_from_wl")
            addToWatchlistButton.setImage(normalImage, for: .normal)
            addToWatchlistButton.setImage(selectedImage, for: .selected)
            addToWatchlistButton.tintColor = UIColor.init(hexString: "#000000")
        }
    }
    @IBOutlet private weak var compareStocksButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = false
        compareStocksButton.isHidden = true
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
    }
}
