//
//  HoldingSecurityTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit

final class HoldingSecurityTableViewCell: HoldingRangeableCell {
    @IBOutlet weak var cornerView: UIView!
    
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var progressView: PlainCircularProgressBar!
    @IBOutlet weak var progressLbl: UILabel!
    @IBOutlet weak var bottomNameLbl: UILabel!
    @IBOutlet weak var bottomPriceLbl: UILabel!
    @IBOutlet weak var rangeNameLbl: UILabel!
    @IBOutlet weak var rangePriceLbl: UILabel!
    @IBOutlet weak var rangeGrowLbl: UILabel!
    @IBOutlet weak var rangeArrowView: UIImageView!
    
    func setModel(_ model: HoldingSecurityViewModel, _ range: ScatterChartView.ChartPeriod) {
        nameLbl.text = model.name
        progressView.progress = CGFloat(model.percentInHolding)
        balanceLbl.text = model.totalPrice.price
        progressLbl.text = (model.percentInHolding * 100).cleanOneDecimalP
        
        bottomNameLbl.text = "Avg cost"
        bottomPriceLbl.text = model.singlePrice.price
        
        (rangeNameLbl.text, rangeArrowView.image, rangePriceLbl.text, rangeGrowLbl.text, rangePriceLbl.textColor, rangeGrowLbl.textColor) = model.infoForRange(range)
    }
}
