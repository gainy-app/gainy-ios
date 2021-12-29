//
//  HoldingsModelMapper.swift
//  Gainy
//
//  Created by Anton Gubarenko on 21.11.2021.
//

import UIKit

struct HoldingsModelMapper {
    static func modelsFor(holdingGroups: [GetPlaidHoldingsQuery.Data.ProfileHoldingGroup], profileHoldings: GetPlaidHoldingsQuery.Data.PortfolioGain?) -> [HoldingViewModel] {
        
        let profileID = UserProfileManager.shared.profileID ?? 0
        
        var holds: [HoldingViewModel] = []
        
        
        for holdingGroup in holdingGroups {
            
            let ticker = holdingGroup.ticker?.fragments.remoteTickerDetailsFull
            let symbol = holdingGroup.symbol ?? ""
            
            var securities: [HoldingSecurityViewModel] = []
            for holding in holdingGroup.holdings {
                let model = HoldingSecurityViewModel(holding: holding)
                securities.append(model)
            }
            
            let absGains: [ScatterChartView.ChartPeriod : Float] = [
                .d1 : holdingGroup.gains?.absoluteGain_1d ?? 0.0,
                .w1 : holdingGroup.gains?.absoluteGain_1w ?? 0.0,
                .m1 : holdingGroup.gains?.absoluteGain_1m ?? 0.0,
                .m3 : holdingGroup.gains?.absoluteGain_3m ?? 0.0,
                .y1 : holdingGroup.gains?.absoluteGain_1y ?? 0.0,
                .y5 : holdingGroup.gains?.absoluteGain_5y ?? 0.0,
                .all : holdingGroup.gains?.absoluteGainTotal ?? 0.0
            ]
            
            let relGains: [ScatterChartView.ChartPeriod : Float]  = [
                .d1 : (holdingGroup.gains?.relativeGain_1d ?? 0.0) * 100.0,
                .w1 : (holdingGroup.gains?.relativeGain_1w ?? 0.0) * 100.0,
                .m1 : (holdingGroup.gains?.relativeGain_1m ?? 0.0) * 100.0,
                .m3 : (holdingGroup.gains?.relativeGain_3m ?? 0.0) * 100.0,
                .y1 : (holdingGroup.gains?.relativeGain_1y ?? 0.0) * 100.0,
                .y5 : (holdingGroup.gains?.relativeGain_5y ?? 0.0) * 100.0,
                .all : (holdingGroup.gains?.relativeGainTotal ?? 0.0) * 100.0
            ]
            
            let categories: [Int] = ticker?.tickerCategories.flatMap({ item in
                item.categories.flatMap { catItem in
                    catItem.id
                }
            }) ?? []
            let holdModel = HoldingViewModel(matchScore: TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0,
                                             name: (ticker?.fragments.remoteTickerDetails.name ?? "").companyMarkRemoved,
                                             balance: Float(holdingGroup.gains?.actualValue ?? 0.0),
                                             tickerSymbol: symbol,
                                             industries: ticker?.tickerIndustries ?? [],
                                             categories: ticker?.tickerCategories ?? [],
                                             showLTT: holdingGroup.details?.lttQuantityTotal ?? 0.0 > 0.0,
                                             todayPrice: TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0,
                                             todayGrow: TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0,
                                             absoluteGains: absGains,
                                             relativeGains: relGains,
                                             percentInProfile: (holdingGroup.details?.valueToPortfolioValue ?? 0.0) * 100.0,
                                             securities: securities,
                                             securityTypes: [],
                                             holdingDetails: holdingGroup.details,
                                             event: holdingGroup.details?.nextEarningsDate,
                                             accountIds: holdingGroup.holdings.compactMap(\.accountId),
                                             tickerInterests: ticker?.tickerInterests.compactMap({$0.interestId}) ?? [],
                                             tickerCategories:categories,
                                             rawTicker: ticker)
            
            holds.append(holdModel)
        }
        
        
        return holds
    }
    
    static func topChartGains(range: ScatterChartView.ChartPeriod, chartsCache: [ScatterChartView.ChartPeriod : ChartData], sypChartsCache: [ScatterChartView.ChartPeriod : ChartData], portfolioGains: GetPlaidHoldingsQuery.Data.PortfolioGain?) -> PortfolioChartGainsViewModel {        
            
            let spChart = sypChartsCache[range] ?? ChartData.init(points: [0.0])
            
            switch range {
            case .d1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1d ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.relativeGain_1d ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
                return chartGainModel
            case .w1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1w ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.absoluteGain_1w ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
                return chartGainModel
            case .m1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1m ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.absoluteGain_1m ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
                return chartGainModel
            case .m3:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_3m ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.absoluteGain_3m ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
                return chartGainModel
            case .y1:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1y ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.absoluteGain_1y ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
                return chartGainModel
            case .y5:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_5y ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.absoluteGain_5y ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
                return chartGainModel
            case .all:
                let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGainTotal ?? 0.0) * 100.0,
                                                                       rangeGrowBalance: portfolioGains?.absoluteGainTotal ?? 0.0,
                                                                       chartData: chartsCache[range] ?? ChartData.init(points: [0.0]),
                                                                       spGrow: Float(spChart.startEndDiff),
                                                                       sypChartData: spChart)
            
                    return chartGainModel
            }
    }
}
