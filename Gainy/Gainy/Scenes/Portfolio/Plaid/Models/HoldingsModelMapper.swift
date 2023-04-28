//
//  HoldingsModelMapper.swift
//  Gainy
//
//  Created by Anton Gubarenko on 21.11.2021.
//

import UIKit
import GainyAPI

struct HoldingsModelMapper {
    static func modelsFor(holdingGroups: [GetPlaidHoldingsQuery.Data.ProfileHoldingGroup], profileHoldings: PortoGains?) -> [HoldingViewModel] {
        
        let profileID = UserProfileManager.shared.profileID ?? 0
        
        var holds: [HoldingViewModel] = []
        
        
        for holdingGroup in holdingGroups {
         
            
            let ticker = holdingGroup.ticker?.fragments.remoteTickerDetails
            var symbol = holdingGroup.symbol ?? ""
            
            var holdingType: SecType = .share
            var securities: [HoldingSecurityViewModel] = []
            for holding in holdingGroup.holdings {
//                if holding.type == .share {
//                    securities.insert(model, at: 0)
//                } else {
//                    securities.append(model)
//                }
                holdingType = SecType.init(rawValue: holding.type ?? "") ?? .share
            }
            
            let absGains: [ScatterChartView.ChartPeriod : Float?] = [
                .d1 : holdingGroup.gains?.absoluteGain_1d,
                .w1 : holdingGroup.gains?.absoluteGain_1w,
                .m1 : holdingGroup.gains?.absoluteGain_1m,
                .m3 : holdingGroup.gains?.absoluteGain_3m,
                .y1 : holdingGroup.gains?.absoluteGain_1y,
                .y5 : holdingGroup.gains?.absoluteGain_5y,
                .all : holdingGroup.gains?.absoluteGainTotal
            ]
            
            let relGains: [ScatterChartView.ChartPeriod : Float?]  = [
                .d1 : holdingGroup.gains?.relativeGain_1d,
                .w1 : holdingGroup.gains?.relativeGain_1w,
                .m1 : holdingGroup.gains?.relativeGain_1m,
                .m3 : holdingGroup.gains?.relativeGain_3m,
                .y1 : holdingGroup.gains?.relativeGain_1y,
                .y5 : holdingGroup.gains?.relativeGain_5y,
                .all : holdingGroup.gains?.relativeGainTotal
            ]
            
            let brokerIds = holdingGroup.holdings.compactMap { item in
                item.broker?.uniqId
            }
            
            var tags: [UnifiedTagContainer] = []
            
            var ttfTags: [UnifiedTagContainer] = []
            
            for tag in holdingGroup.tags {
                ttfTags.append(contentsOf: tag.unifiedTags)
            }
            ttfTags = ttfTags.uniqued()
            
 //           let interests = (ticker?.tickerInterests ?? []).flatMap({$0.toUnifiedContainers()})
//            let industriesTags = (ticker?.tickerIndustries ?? []).flatMap({$0.toUnifiedContainers()})
//            let categoriesTags = (ticker?.tickerCategories ?? []).flatMap({$0.toUnifiedContainers()})
//            tags = categoriesTags + industriesTags
            
            //            if ticker.fragments.remoteTickerDetailsFull. {
            //                for tag in
            //            }

            var ms = TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0
            if let collection = holdingGroup.collection {
                ms = Int(collection.matchScore?.matchScore ?? 0)
                symbol = Constants.CollectionDetails.ttfSymbol
                
            }
            tags = ttfTags
            
            let holdModel = HoldingViewModel(matchScore: ms,
                                             name: holdingGroup.collection != nil ? (holdingGroup.details?.name ?? "").companyMarkRemoved : (holdingGroup.ticker?.name ?? "").companyMarkRemoved,
                                             balance: Float(holdingGroup.gains?.actualValue ?? 0.0),
                                             tickerSymbol: symbol,
                                             type: holdingType,
                                             tickerTags: tags.compactMap({$0.tickerTag()}),
                                             showLTT: holdingGroup.details?.lttQuantityTotal ?? 0.0 > 0.0,
                                             todayPrice: TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0,
                                             todayGrow: TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0,
                                             absoluteGains: absGains,
                                             relativeGains: relGains,
                                             percentInProfile: (holdingGroup.gains?.valueToPortfolioValue ?? 0.0) * 100.0,
                                             securities: securities,
                                             securityTypes: holdingGroup.holdings.compactMap({$0.type}),
                                             holdingDetails: holdingGroup.details,
                                             event: holdingGroup.details?.nextEarningsDate,
                                             brokerIds: brokerIds,
                                             accountIds: [],
                                             tickerInterests: tags.filter({$0.type == .interest}).compactMap({$0.id}),
                                             tickerCategories: tags.filter({$0.type == .category}).compactMap({$0.id}),
                                             rawTicker: ticker,
                                             collectionId: holdingGroup.collection?.id ?? Constants.CollectionDetails.noCollectionId)
            
            holds.append(holdModel)
        }
        
        
        return holds
    }
    
    static func topChartGains(range: ScatterChartView.ChartPeriod, chartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]], sypChartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]], portfolioGains: PortoGains?) -> PortfolioChartGainsViewModel {
        
        let spChart = sypChartsCache[range] ?? [ChartNormalized]()
        let (main, median) = normalizeCharts(chartsCache[range] ?? [ChartNormalized](), spChart)
        
        var chartDataSP: ChartData!
        if let firstMedian: Double = median.first?.val, let firstMain: Double = main.first?.val {
            var pcts: [Double] = []
            for val in median.compactMap({$0.val}) {
                let cur = val / firstMedian
                pcts.append(firstMain * cur)
            }
            chartDataSP = ChartData(points: pcts)
        } else {
            chartDataSP = ChartData.init(points: median, period: range)
        }
        
        let chartDataPort = ChartData.init(points: main, period: range)
        
        switch range {
        case .d1:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGain_1d ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1d ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP
            )
            return chartGainModel
        case .w1:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGain_1w ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1w ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .m1:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGain_1m ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1m ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .m3:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGain_3m ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_3m ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .y1:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGain_1y ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1y ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .y5:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGain_5y ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_5y ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .all:
            let chartGainModel = PortfolioChartGainsViewModel.init(balance: portfolioGains?.actualValue ?? 0.0,
                                                                   rangeGrow: (portfolioGains?.relativeGainTotal ?? 0.0),
                                                                   rangeGrowBalance: portfolioGains?.absoluteGainTotal ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            
            return chartGainModel
        }
    }
}
