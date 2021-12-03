//
//  SearchStockTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.11.2021.
//

import UIKit

final class SearchStockTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var stockNameLbl: UILabel!
    @IBOutlet private weak var stockSymLbl: UILabel!
    @IBOutlet private weak var stockPriceLbl: UILabel!
    @IBOutlet private weak var stockDiffLbl: UILabel!
    
    var stock: RemoteTickerDetails? {
        didSet {
            if let stock = stock {
                stockNameLbl.text = stock.name
                stockSymLbl.text = stock.symbol
                
                let priceChange = stock.realtimeMetrics?.relativeDailyChange ?? 0.0
                stockPriceLbl.text = stock.realtimeMetrics?.actualPrice?.price ?? ""
                stockPriceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
                stockDiffLbl.text = priceChange.cleanOneDecimalP
            }
        }
    }
}
