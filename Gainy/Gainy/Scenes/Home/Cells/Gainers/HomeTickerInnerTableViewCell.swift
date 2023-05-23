//
//  HomeTickerInnerTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.04.2022.
//

import UIKit

protocol HomeTickerInnerTableViewCellDelegate: AnyObject {
    func wlPressed(stock: HomeTickerInnerTableViewCellModel, cell: HomeTickerInnerTableViewCell)
}

//Will be used further
final class HomeTickerInnerTableViewCell: UICollectionViewCell {
    
    weak var delegate: HomeTickerInnerTableViewCellDelegate?
    
    //MARK: - Outlets
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var shadowView: UIView!
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
//            matchCircle.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
//            matchCircle.tintColor = .white
        }
    }
    @IBOutlet private weak var matchLabel: UILabel! {
        didSet {
            matchLabel.layer.cornerRadius = 12.0
            matchLabel.clipsToBounds = true
        }
    }
    @IBOutlet private weak var arrowImgView: UIImageView!
    @IBOutlet private weak var growLbl: UILabel!
    @IBOutlet private weak var bottomViewWidth: NSLayoutConstraint!
    
    func setBottomViewWidth(_ width: CGFloat = 40.0) {
        bottomViewWidth.constant = width
        if width == 48 {
            wlBtn.setImage(UIImage(named: "add_to_wl_rec"), for: .normal)
            wlBtn.setImage(UIImage(named: "remove_from_wl_rec"), for: .selected)
        }
    }
    
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
      
    
    
    var stock: HomeTickerInnerTableViewCellModel? {
        didSet {
            guard let stock = stock else {return}
            nameLbl.text = stock.name
            symbolLbl.text = stock.symbol
            
            let storedData = TickerLiveStorage.shared.getSymbolData(stock.symbol)
            let priceChange = storedData?.priceChangeToday ?? 0.0
            priceLbl.text = storedData?.currentPrice.price ?? ""
            priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
                  
            growLbl.text = storedData?.priceChangeToday.percentUnsigned ?? ""
            growLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
            if priceChange == 0.0 {
                growLbl.textColor = .lightGray
                priceLbl.textColor = .lightGray
            }
            arrowImgView.image = UIImage(named: priceChange >= 0.0 ? "small_up" : "small_down")
            
            let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
                item == stock.symbol
            }
            isInWL = addedToWatchlist
            if let matchScore = TickerLiveStorage.shared.getMatchData(stock.symbol)?.matchScore {
                matchLabel.text = "\(matchScore)"
                matchLabel.backgroundColor = MatchScoreManager.circleColorFor(matchScore)                
                if !UserProfileManager.shared.isOnboarded {
                    matchLabel.text = "?"
                }
                matchCircle.isHidden = false
            } else {
                if UserProfileManager.shared.isOnboarded {
                    matchLabel.text = ""
                    matchLabel.backgroundColor = .clear
                    matchCircle.isHidden = true
                } else {
                    matchLabel.text = "?"
                    matchLabel.backgroundColor = MatchScoreManager.circleColorFor(100)
                    matchCircle.isHidden = false
                }
            }
        }
    }
    
    var cornerRadius: CGFloat = 16.0

        override func awakeFromNib() {
            super.awakeFromNib()
                
            // Apply rounded corners to contentView
            contentView.layer.cornerRadius = cornerRadius
            contentView.layer.masksToBounds = true
            
            // Set masks to bounds to false to avoid the shadow
            // from being clipped to the corner radius
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = false
            
            // Apply a shadow
            layer.shadowRadius = 4.0
            layer.shadowOpacity = 0.10
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            shadowView.fillRemoteButtonBack()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            // Improve scrolling performance with an explicit shadowPath
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: cornerRadius
            ).cgPath
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
            GainyAnalytics.logEventAMP("ticker_removed_from_wl", params: ["tickerSymbol" : symbol, "tickerType" : stock?.type ?? "", "action" : "bookmark", "isFromSearch" : "false", "location" : "ticker_card"])
            UserProfileManager.shared.removeTickerFromWatchlist(symbol) { success in
                if success {
                    sender.isSelected = false
                }
            }
        } else {
            GainyAnalytics.logEvent("ticker_added_to_wl", params: ["af_content_id" : symbol, "af_content_type" : "ticker"])
            GainyAnalytics.logEventAMP("ticker_added_to_wl", params: ["tickerSymbol" : symbol, "tickerType" : stock?.type ?? "", "action" : "bookmark", "isFromSearch" : "false", "location" : "ticker_card"])
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
