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
            let ticker = security?.tickers?.fragments.remoteTickerDetails
            let symbol = security?.tickerSymbol ?? ""
            
            let portfolioHoldingsGains = profileHoldings?.profileHoldings.first(where: {
                $0.securityId == security?.id
            })
            
            let portfolioTransactionsGains = profileHoldings?.profileHoldings.first(where: {
                $0.securityId == security?.id
            })
            
            let holdModel = HoldingViewModel.init(matchScore: TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0,
                                                  name: security?.name ?? "",
                                                  balance: Float(rawHolding.quantity) * (TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0),
                                                  tickerSymbol: symbol,
                                                  industries: ticker?.tickerIndustries ?? [],
                                                  categories: ticker?.tickerCategories ?? [],
                                                  showLTT: false,
                                                  todayPrice: TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0,
                                                  todayGrow: TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0,
                                                  absoluteGains: [
                                                    .d1 : 0.0,
                                                    .w1 : 0.0,
                                                    .m1 : 0.0,
                                                    .m3 : 0.0,
                                                    .y1 : 0.0,
                                                    .y5 : 0.0,
                                                    .all : 0.0
                                                  ],
                                                  relativeGains: [
                                                    .d1 : 0.0,
                                                    .w1 : 0.0,
                                                    .m1 : 0.0,
                                                    .m3 : 0.0,
                                                    .y1 : 0.0,
                                                    .y5 : 0.0,
                                                    .all : 0.0
                                                  ],
                                                  percentInProfile: portfolioHoldingsGains?.portfolioHoldingGains?.valueToPortfolioValue ?? 0.0,
                                                  securities: [],
                                                  event: ticker?.tickerEvents.first?.description)
            
            holds.append(holdModel)
        }
        
        
        return holds
    }
}
