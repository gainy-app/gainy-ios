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
    
    @IBOutlet private weak var ttfLabel: UILabel!
    @IBOutlet private weak var ttfValueLabel: UILabel!
    
    @IBOutlet private weak var progressView: PlainCircularProgressBar!
    @IBOutlet private weak var progressLabel: UILabel!
    
    @IBOutlet private weak var todayArrow: UIImageView!
    @IBOutlet private weak var totalArrow: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(with model: CollectionDetailPurchaseInfoModel,
                   isTicker: Bool = false) {
        
        if let todayReturn = model.todayReturn {
            todayReturnValueLabel.text = todayReturn.priceUnchecked
        } else {
            todayReturnValueLabel.text = ""
        }
        
        if let todayReturnP = model.todayReturnP {
            todayReturnLabel.text = todayReturnP.percentUnsigned
            if todayReturnP >= 0.0 {
                todayReturnLabel.textColor = UIColor.Gainy.mainGreen
                todayArrow.image = UIImage(named: "arrow-up-green")
            } else {
                todayReturnLabel.textColor = UIColor.Gainy.mainRed
                todayArrow.image = UIImage(named: "arrow-down-red")
            }
        } else {
            todayReturnLabel.text = ""
            todayArrow.image = nil
        }
        
        totalReturnLabel.text = model.totalReturnP.percentUnsigned
        totalReturnValueLabel.text = model.totalReturn.priceUnchecked
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
        if isTicker {
            titleLabel.text = "Ticker Position"
            ttfLabel.text = "Position value"
        }
    }
}
