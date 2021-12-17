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
    let type: String
    let percentInHolding: Float
    let totalPrice: Float
    let quantity: Float
    
    let singlePrice: Float
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    
    func infoForRange(_ range: ScatterChartView.ChartPeriod) -> (String, UIImage, String, String) {
        return (range.longName, UIImage(named: relativeGains[range] ?? 0.0 >= 0.0 ?  "small_up" : "small_down")!, absoluteGains[range]?.price ?? "", relativeGains[range]?.cleanOneDecimalP ?? "" )
        
    }
    
    init(holding: GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Holding) {
        var type = holding.holdingDetails?.securityType ?? ""
        if type == "derivative" {
            type = "Options"
        }
        if type == "equity" {
            type = "Shares"
        }
        self.name = (type == "Options" ? (holding.holdingDetails?.tickerName ?? "")  : (holding.name ?? "")) + " x\(holding.quantity ?? 0.0)"
        self.type = type
        self.percentInHolding = holding.holdingDetails?.valueToPortfolioValue ?? 0.0
        self.totalPrice = Float(holding.gains?.actualValue ?? 0.0)
        self.quantity = Float(holding.quantity ?? 0.0)
        self.singlePrice = Float(55.0)
        let absGains: [ScatterChartView.ChartPeriod : Float] = [
            .d1 : holding.gains?.absoluteGain_1d ?? 0.0,
            .w1 : holding.gains?.absoluteGain_1w ?? 0.0,
            .m1 : holding.gains?.absoluteGain_1m ?? 0.0,
            .m3 : holding.gains?.absoluteGain_3m ?? 0.0,
            .y1 : holding.gains?.absoluteGain_1y ?? 0.0,
            .y5 : holding.gains?.absoluteGain_5y ?? 0.0,
            .all : holding.gains?.absoluteGainTotal ?? 0.0
        ]
        
        let relGains: [ScatterChartView.ChartPeriod : Float]  = [
            .d1 : (holding.gains?.relativeGain_1d ?? 0.0) * 100.0,
            .w1 : (holding.gains?.relativeGain_1w ?? 0.0) * 100.0,
            .m1 : (holding.gains?.relativeGain_1m ?? 0.0) * 100.0,
            .m3 : (holding.gains?.relativeGain_3m ?? 0.0) * 100.0,
            .y1 : (holding.gains?.relativeGain_1y ?? 0.0) * 100.0,
            .y5 : (holding.gains?.relativeGain_5y ?? 0.0) * 100.0,
            .all : (holding.gains?.relativeGainTotal ?? 0.0) * 100.0
        ]
        self.absoluteGains = absGains
        self.relativeGains = relGains
    }
}

extension HoldingSecurityViewModel: Equatable {
    
}

extension HoldingSecurityViewModel: Hashable {
    
}
