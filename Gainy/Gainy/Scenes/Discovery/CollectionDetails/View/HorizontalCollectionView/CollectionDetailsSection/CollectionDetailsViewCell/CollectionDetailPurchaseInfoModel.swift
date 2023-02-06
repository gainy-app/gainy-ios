//
//  CollectionDetailPurchaseInfoModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.11.2022.
//

import Foundation
import GainyAPI

struct CollectionDetailPurchaseInfoModel {
    let todayReturn: Float
    let todayReturnP: Float
    
    let totalReturn: Float
    let totalReturnP: Float
    
    let fractionalCost: Float
    let shareInPortfolio: Float
    
    let actualValue: Float
    
    init(status: TradingGetTtfStatusQuery.Data.TradingProfileCollectionStatus) {
        todayReturn = status.absoluteGain_1d ?? 0.0
        todayReturnP = status.relativeGain_1d ?? 0.0
        
        totalReturn = status.absoluteGainTotal ?? 0.0
        totalReturnP = status.relativeGainTotal ?? 0.0
        
        fractionalCost = status.actualValue ?? 0.0
        shareInPortfolio = status.valueToPortfolioValue ?? 0.0
        
        actualValue = status.actualValue ?? 0.0
    }
    
    init(status: TradingGetStockStatusQuery.Data.TradingProfileTickerStatus) {
        todayReturn = status.absoluteGain_1d ?? 0.0
        todayReturnP = status.relativeGain_1d ?? 0.0
        
        totalReturn = status.absoluteGainTotal ?? 0.0
        totalReturnP = status.relativeGainTotal ?? 0.0
        
        fractionalCost = status.actualValue ?? 0.0
        shareInPortfolio = status.valueToPortfolioValue ?? 0.0
        
        actualValue = status.actualValue ?? 0.0
    }
    
    var isPurchased: Bool {
        actualValue > 0.0
    }
}
