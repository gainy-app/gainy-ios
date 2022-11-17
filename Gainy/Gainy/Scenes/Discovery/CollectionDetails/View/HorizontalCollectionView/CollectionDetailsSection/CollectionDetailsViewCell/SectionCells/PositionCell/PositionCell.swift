//
//  PositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 15.11.22.
//

import UIKit
import GainyCommon

final class PositionCell: UICollectionViewCell {
    
    @IBOutlet private weak var todayReturnLabel: UILabel!
    @IBOutlet private weak var todayReturnValueLabel: UILabel!
    
    @IBOutlet private weak var totalReturnLabel: UILabel!
    @IBOutlet private weak var totalReturnValueLabel: UILabel!
    
    @IBOutlet private weak var ttfValueLabel: UILabel!
    
    @IBOutlet private weak var progressView: PlainCircularProgressBar!
    @IBOutlet private weak var progressLabel: UILabel!
    
    func configure(with model: CollectionDetailPurchaseInfoModel) {
        todayReturnValueLabel.text = model.todayReturn.price
        todayReturnLabel.text = model.todayReturnP.cleanTwoDecimalP
        
        totalReturnLabel.text = model.totalReturnP.cleanTwoDecimalP
        totalReturnValueLabel.text = model.totalReturn.price
        
        ttfValueLabel.text = model.fractionalCost.price
        
        progressView.progress = CGFloat(model.shareInPortfolio / 100.0)
        progressLabel.text = (model.shareInPortfolio).cleanOneDecimalP
    }
}
