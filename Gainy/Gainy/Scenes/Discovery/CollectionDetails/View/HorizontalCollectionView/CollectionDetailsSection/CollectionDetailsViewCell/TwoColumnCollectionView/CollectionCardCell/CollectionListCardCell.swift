//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit

final class CollectionListCardCell: UICollectionViewCell {

    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var symbolLbl: UILabel!
    @IBOutlet private weak var priceLbl: UILabel!
    
    
    @IBOutlet private weak var growthLbl: UILabel!
    @IBOutlet private weak var yieldLbl: UILabel!
    @IBOutlet private weak var peLbl: UILabel!
    @IBOutlet private weak var marketLbl: UILabel!
    @IBOutlet private weak var mlpLbl: UILabel!
    
    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        markerHeaders: [String],
        markerMetrics: [String],
        matchScore: String,
        isMatch: Bool
    ) {
        nameLbl.text = companyName

        symbolLbl.text = tickerSymbol

        priceLbl.text = "$\(tickerPrice)"
        priceLbl.textColor = tickerPercentChange.hasPrefix(" +")
            ? UIColor.Gainy.green
            : UIColor.Gainy.red

        let lbls = [growthLbl, yieldLbl, peLbl, marketLbl, mlpLbl]
        
        for (ind, val) in markerMetrics.enumerated() {
            lbls[ind]?.text = val
        }
        
        layoutIfNeeded()
    }
}
