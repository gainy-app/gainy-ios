//
//  HoldingViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import UIKit

struct HoldingViewModel {
    let matchScore: Int
    let name: String
    let balance: Float
    let tickerSymbol: String
    

    let categories: [RemoteTicker.TickerIndustry]
    let interests: [RemoteTicker.TickerInterest]
    
    let showLTT: Bool
    
    let todayPrice: Float
    let todayGrow: Float
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    let percentInProfile: Float
    
    let securities: [HoldingSecurityViewModel]
    
    let event: String?
}
