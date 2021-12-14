//
//  HoldingSecurityViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import Foundation
import UIKit

struct HoldingSecurityViewModel {
    let name: String
    let percentInHolding: Float
    let totalPrice: Float
    let quantity: Float
    
    let singlePrice: Float
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    
    func infoForRange(_ range: ScatterChartView.ChartPeriod) -> (String, UIImage, String, String) {
        return (range.longName, UIImage(named: relativeGains[range] ?? 0.0 >= 0.0 ?  "small_up" : "small_down")!, absoluteGains[range]?.price ?? "", relativeGains[range]?.cleanOneDecimalP ?? "" )
        
    }
    
    init(transaction: GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Holding.Transaction, holding: GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Holding) {
        var type = holding.holdingDetails?.securityType ?? ""
        if type == "derivative" {
            type = "Options"
        }
        if type == "equity" {
            type = "Shares"
        }
        self.name = type
        self.percentInHolding = Float(transaction.quantity) / (holding.quantity ?? 0.0)
        self.totalPrice = Float(transaction.quantity) * (transaction.portfolioTransactionGains?.absoluteGain_1d ?? 0.0)
        self.quantity = Float(transaction.quantity)
        self.singlePrice = Float(transaction.price)
        let absGains: [ScatterChartView.ChartPeriod : Float] = [
            .d1 : transaction.portfolioTransactionGains?.absoluteGain_1d ?? 0.0,
            .w1 : transaction.portfolioTransactionGains?.absoluteGain_1w ?? 0.0,
            .m1 : transaction.portfolioTransactionGains?.absoluteGain_1m ?? 0.0,
            .m3 : transaction.portfolioTransactionGains?.absoluteGain_3m ?? 0.0,
            .y1 : transaction.portfolioTransactionGains?.absoluteGain_1y ?? 0.0,
            .y5 : transaction.portfolioTransactionGains?.absoluteGain_5y ?? 0.0,
            .all : transaction.portfolioTransactionGains?.absoluteGainTotal ?? 0.0
        ]
        
        let relGains: [ScatterChartView.ChartPeriod : Float]  = [
            .d1 : (transaction.portfolioTransactionGains?.relativeGain_1d ?? 0.0) * 100.0,
            .w1 : (transaction.portfolioTransactionGains?.relativeGain_1w ?? 0.0) * 100.0,
            .m1 : (transaction.portfolioTransactionGains?.relativeGain_1m ?? 0.0) * 100.0,
            .m3 : (transaction.portfolioTransactionGains?.relativeGain_3m ?? 0.0) * 100.0,
            .y1 : (transaction.portfolioTransactionGains?.relativeGain_1y ?? 0.0) * 100.0,
            .y5 : (transaction.portfolioTransactionGains?.relativeGain_5y ?? 0.0) * 100.0,
            .all : (transaction.portfolioTransactionGains?.relativeGainTotal ?? 0.0) * 100.0
        ]
        self.absoluteGains = absGains
        self.relativeGains = relGains
    }
}

extension HoldingSecurityViewModel: Equatable {
    
}

extension HoldingSecurityViewModel: Hashable {
    
}
