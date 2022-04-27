//
//  HomeTickerInnerTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.04.2022.
//

import UIKit


//Will be used further
final class HomeTickerInnerTableViewCell: UICollectionViewCell {
    
    weak var delegate: HomeTickerInnerTableViewCellDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wlBtn: UIButton! {
        didSet {
            wlBtn.setImage(UIImage(named: "remove_from_wl"), for: .selected)
            wlBtn.setTitle("", for: .selected)
            
            wlBtn.setImage(UIImage(named: "add_to_wl"), for: .normal)
            wlBtn.setTitle("", for: .normal)
            
            wlBtn.addTarget(self, action: #selector(addToWatchlistToggleAction(_:)), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var matchCircle: UIImageView! {
        didSet {
            matchCircle.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
            matchCircle.tintColor = .white
        }
    }
    @IBOutlet private weak var matchLabel: UILabel! {
        didSet {
            matchLabel.layer.cornerRadius = 12.0
            matchLabel.clipsToBounds = true
        }
    }
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var growLbl: UILabel!
    
    //MARK: - Properties
    var isInWL: Bool = false {
        didSet {
            if isInWL {
                wlBtn.isSelected = true
            } else {
                wlBtn.isSelected = false
            }
        }
    }
    
    var stock: AltStockTicker? {
        didSet {
            guard let stock = stock else {return}
            nameLbl.text = stock.name
            symbolLbl.text = stock.symbol
            
            let storedData = TickerLiveStorage.shared.getSymbolData(stock.symbol ?? "")
            let priceChange = storedData?.priceChangeToday ?? 0.0
            priceLbl.text = storedData?.currentPrice.price ?? ""
            priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
                  
            growLbl.text = storedData?.priceChangeToday.percent ?? ""
            growLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
            arrowImgView.image = UIImage(named: priceChange >= 0.0 ? "small_up" : "small_down")
            
            let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
                item == stock.symbol
            }
            isInWL = addedToWatchlist
            if let matchScore = TickerLiveStorage.shared.getMatchData(stock.symbol ?? "")?.matchScore {
                matchLabel.text = "\(matchScore)"
                matchLabel.backgroundColor = MatchScoreManager.circleColorFor(matchScore)                
            } else {
                matchLabel.text = "-"
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addToWatchlistToggleAction(_ sender: UIButton) {
        guard let symbol = stock?.symbol else {
            return
        }
        
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
            if let stock = stock {
                delegate?.wlPressed(stock: stock, cell: self)
            }
        }
    }
}