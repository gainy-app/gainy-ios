//
//  StockViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.08.2021.
//

import UIKit

final class StockViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var growthLbl: UILabel!
    
    var ticker: RemoteTickerDetails? {
        didSet {
            if let ticker = ticker {
                nameLbl.text = ticker.name
                symbolLbl.text = ticker.symbol
                let priceChange = ticker.tickerFinancials.last?.priceChangeToday ?? 0.0
                priceLbl.text = ticker.tickerFinancials.last?.currentPrice.price ?? ""
                priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
                growthLbl.text = priceChange.percentRaw
            }
        }
    }
}