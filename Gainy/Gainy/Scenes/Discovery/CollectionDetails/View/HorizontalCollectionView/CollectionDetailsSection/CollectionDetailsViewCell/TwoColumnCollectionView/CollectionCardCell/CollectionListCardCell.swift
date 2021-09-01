//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit

final class CollectionListCardCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBOutlet weak var growthLbl: UILabel!
    @IBOutlet weak var yieldLbl: UILabel!
    @IBOutlet weak var peLbl: UILabel!
    @IBOutlet weak var marketLbl: UILabel!
    @IBOutlet weak var mlpLbl: UILabel!
    
    
    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        markerMetrics: [String]
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
