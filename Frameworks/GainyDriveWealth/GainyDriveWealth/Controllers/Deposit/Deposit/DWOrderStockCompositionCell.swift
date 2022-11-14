//
//  DWOrderStockCompositionCell.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 14.11.2022.
//

import UIKit
import GainyCommon
import GainyAPI

typealias TTFStockCompositionData = GetCollectionTickerActualWeightsQuery.Data.CollectionTickerActualWeight

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
    
    @IBOutlet private weak var weightProgress: PlainCircularProgressBar!
    
    
    var data: TTFStockCompositionData? {
        didSet {
            if let data {
                
            }
        }
    }
    
}
