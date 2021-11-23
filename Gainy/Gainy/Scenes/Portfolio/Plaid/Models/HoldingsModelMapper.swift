//
//  HoldingsModelMapper.swift
//  Gainy
//
//  Created by Anton Gubarenko on 21.11.2021.
//

import UIKit

struct HoldingsModelMapper {
    static func modelsFor(holdings: [GetPlaidHoldingsQuery.Data.GetPortfolioHolding], securities: [GetPlaidTransactionsQuery.Data.GetPortfolioTransaction], profileHoldings: GetProfileGainsQuery.Data.AppProfile?) -> [HoldingViewModel] {
        
        let profileID = UserProfileManager.shared.profileID ?? 0
        
        var holds: [HoldingViewModel] = []
        
        
        for rawHolding in holdings {
            let security: GetPlaidHoldingsQuery.Data.GetPortfolioHolding.Security? = rawHolding.security.first
            print("Sec: \(security?.id ?? 0)")
            print("Name: \(security?.name ?? "")")
            let ticker = security?.tickers?.fragments.remoteTickerDetails
            let symbol = security?.tickerSymbol ?? ""
            
            let portfolioHoldingsGains = profileHoldings?.profileHoldings.first(where: {
                $0.securityId == security?.id
            })?.portfolioHoldingGains
            
//            let portfolioTransactionsGains = profileHoldings?.profileHoldings.first(where: {
//                $0.securityId == security?.id
//            }).tr
            
            let absGains: [ScatterChartView.ChartPeriod : Float] = [
                .d1 : Float(rawHolding.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0),
                .w1 : portfolioHoldingsGains?.absoluteGain_1w ?? 0.0,
                .m1 : portfolioHoldingsGains?.absoluteGain_1m ?? 0.0,
                .m3 : portfolioHoldingsGains?.absoluteGain_3m ?? 0.0,
                .y1 : portfolioHoldingsGains?.absoluteGain_1y ?? 0.0,
                .y5 : portfolioHoldingsGains?.absoluteGain_5y ?? 0.0,
                .all : portfolioHoldingsGains?.absoluteGainTotal ?? 0.0
              ]
            
            let relGains: [ScatterChartView.ChartPeriod : Float]  = [
                .d1 : (TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0),
                .w1 : portfolioHoldingsGains?.relativeGain_1w ?? 0.0,
                .m1 : portfolioHoldingsGains?.relativeGain_1m ?? 0.0,
                .m3 : portfolioHoldingsGains?.relativeGain_3m ?? 0.0,
                .y1 : portfolioHoldingsGains?.relativeGain_1y ?? 0.0,
                .y5 : portfolioHoldingsGains?.relativeGain_5y ?? 0.0,
                .all : portfolioHoldingsGains?.relativeGainTotal ?? 0.0
              ]
            
            let holdModel = HoldingViewModel.init(matchScore: TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0,
                                                  name: security?.name ?? "",
                                                  balance: Float(rawHolding.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0),
                                                  tickerSymbol: symbol,
                                                  industries: ticker?.tickerIndustries ?? [],
                                                  categories: ticker?.tickerCategories ?? [],
                                                  showLTT: false,
                                                  todayPrice: TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0,
                                                  todayGrow: TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0,
                                                  absoluteGains: absGains,
                                                  relativeGains: relGains,
                                                  percentInProfile:portfolioHoldingsGains?.valueToPortfolioValue ?? 0.0,
                                                  securities: [],
                                                  event: ticker?.tickerEvents.first?.description)
            
            holds.append(holdModel)
        }
        
        
        return holds
    }
}
