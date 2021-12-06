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
    

    let industries: [RemoteTickerDetailsFull.TickerIndustry]
    let categories: [RemoteTickerDetailsFull.TickerCategory]
    
    let showLTT: Bool
    
    let todayPrice: Float
    let todayGrow: Float
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    let percentInProfile: Float
    
    let securities: [HoldingSecurityViewModel]
    
    let holdingDetails: GetPlaidHoldingsQuery.Data.GetPortfolioHolding.Holding.HoldingDetail?
    
    let event: String?
    
    let accountId: Int
    let tickerInterests: [Int]
    let tickerCategories: [Int]
    let rawTicker: RemoteTickerDetailsFull?
    
    func infoForRange(_ range: ScatterChartView.ChartPeriod) -> (String, UIImage, String, String) {
        return (range.longName, UIImage(named: relativeGains[range] ?? 0.0 >= 0.0 ?  "small_up" : "small_down")!, absoluteGains[range]?.price ?? "", relativeGains[range]?.cleanTwoDecimalP ?? "" )

    }
    
    //Height calc
    func heightForState(range: ScatterChartView.ChartPeriod, isExpaned: Bool) -> CGFloat {
        let eventHeight: CGFloat = 16.0 + 32.0
        if isExpaned {
            let secHeight: CGFloat = Double(securities.count) * 80.0 + Double(securities.count - 1) * 8.0
            var height = 184.0 + secHeight + 16.0 + 16.0
            if event != nil {
                height += eventHeight
            }
            return height
        } else {
            if event != nil {
                return 232.0 + 16.0
            } else {
                return 184.0 + 16.0
            }
            
        }
    }
}

extension HoldingViewModel: Equatable {
    static func == (lhs: HoldingViewModel, rhs: HoldingViewModel) -> Bool {
        lhs.name == rhs.name
    }
    
    
}

extension HoldingViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.tickerSymbol)
        hasher.combine(self.matchScore)
    }
}
