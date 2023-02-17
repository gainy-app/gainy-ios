//
//  DWOrderStockCompositionCell.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 14.11.2022.
//

import UIKit
import GainyCommon
import GainyAPI

typealias TTFStockCompositionData = GetCollectionTickerActualWeightsQuery.Data.TradingCollectionTicker

final class DWOrderStockCompositionCell: UITableViewCell {
    
    @IBOutlet private weak var nameLbl: UILabel! {
        didSet {
            nameLbl.font = UIFont.proDisplayBold(16)
        }
    }
    @IBOutlet private weak var priceLbl: UILabel! {
        didSet {
            priceLbl.font = UIFont.proDisplayBold(16)
        }
    }
    @IBOutlet private weak var percentLbl: UILabel! {
        didSet {
            percentLbl.font = UIFont.compactRoundedSemibold(14)
        }
    }
    
    @IBOutlet private weak var weightProgress: PlainCircularProgressBar! {
        didSet {
            weightProgress.color = .black
        }
    }
    
    
    var data: (amount: Double, compData: TTFStockCompositionData)? {
        didSet {
            if let data {
                nameLbl.text = (data.compData.symbol  ?? "").uppercased()
                priceLbl.text = "\((Float(data.amount) * Float(data.compData.weight ?? 1.0)).price)"
                percentLbl.text = Float(data.compData.weight ?? 1.0).percentComponentRaw
                weightProgress.progress = CGFloat(data.compData.weight ?? 1.0)
            }
        }
    }
    
}
