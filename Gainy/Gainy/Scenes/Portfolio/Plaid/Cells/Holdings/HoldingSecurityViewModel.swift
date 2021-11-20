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
    let precentInHolding: Float
    let totalPrice: Float
    let quantity: Float
    
    let singlePrice: Float
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    
    func infoForRange(_ range: ScatterChartView.ChartPeriod) -> (String, UIImage, String, String) {
        return (range.longName, UIImage(named: relativeGains[range] ?? 0.0 >= 0.0 ?  "small_up" : "small_down")!, absoluteGains[range]?.price ?? "", relativeGains[range]?.cleanOneDecimalP ?? "" )

    }
}
