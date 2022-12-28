//
//  PositionView.swift
//  Gainy
//
//  Created by Евгений Таран on 19.12.22.
//

import UIKit
import GainyCommon

@IBDesignable
class PositionView: UIView {
    @IBOutlet private weak var todayReturnLabel: UILabel!
    @IBOutlet private weak var todayReturnValueLabel: UILabel!
    
    @IBOutlet private weak var totalReturnLabel: UILabel!
    @IBOutlet private weak var totalReturnValueLabel: UILabel!
    
    @IBOutlet private weak var ttfValueLabel: UILabel!
    
    @IBOutlet private weak var progressView: PlainCircularProgressBar!
    @IBOutlet private weak var progressLabel: UILabel!
    
    @IBOutlet private weak var todayArrow: UIImageView!
    @IBOutlet private weak var totalArrow: UIImageView!
    
    func configure(with model: CollectionDetailPurchaseInfoModel) {
        
        todayReturnValueLabel.text = model.todayReturn.priceUnchecked
        totalReturnValueLabel.text = model.totalReturn.priceUnchecked
        
        todayReturnLabel.text = model.todayReturnP.percent
        if model.todayReturnP >= 0.0 {
            todayReturnLabel.textColor = UIColor.Gainy.mainGreen
            todayArrow.image = UIImage(named: "arrow-up-green")
        } else {
            todayReturnLabel.textColor = UIColor.Gainy.mainRed
            todayArrow.image = UIImage(named: "arrow-down-red")
        }
        
        totalReturnLabel.text = model.totalReturnP.percent
        if model.totalReturnP >= 0.0 {
            totalReturnLabel.textColor = UIColor.Gainy.mainGreen
            totalArrow.image = UIImage(named: "arrow-up-green")
        } else {
            totalReturnLabel.textColor = UIColor.Gainy.mainRed
            totalArrow.image = UIImage(named: "arrow-down-red")
        }
        
        ttfValueLabel.text = model.fractionalCost.price
        
        progressView.progress = CGFloat(model.shareInPortfolio / 100.0)
        progressLabel.text = model.shareInPortfolio.percent
    }
}
