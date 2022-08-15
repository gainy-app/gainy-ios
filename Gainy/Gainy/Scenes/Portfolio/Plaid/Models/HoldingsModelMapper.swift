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
            
            if !RemoteConfigManager.shared.showPortoCash {
                if holdingGroup.holdings.first?.secType == .cash {
                    continue
                }
            }
            
            if !RemoteConfigManager.shared.showPortoCrypto {
                if holdingGroup.holdings.first?.secType == .crypto {
                    continue
                }
            }
            
            let ticker = holdingGroup.ticker?.fragments.remoteTickerDetailsFull
            let symbol = holdingGroup.symbol ?? ""
            
            var securities: [HoldingSecurityViewModel] = []
            for holding in holdingGroup.holdings {
                let model = HoldingSecurityViewModel(holding: holding)
                if model.type == .share {
                    securities.insert(model, at: 0)
                } else {
                    securities.append(model)
                }
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
            
            let institutionIds = holdingGroup.holdings.compactMap { item in
                item.holdingDetails?.holding?.accessToken?.institution?.id
            }
            
            var tags: [UnifiedTagContainer] = []
            
            var ttfTags: [UnifiedTagContainer] = []
            
            for tag in holdingGroup.tags {
                if let col = tag.collection {
                    ttfTags.append(UnifiedTagContainer.init(id: col.id ?? Constants.CollectionDetails.noCollectionId, name: col.name ?? "" , url: "", collectionId: col.id ?? Constants.CollectionDetails.noCollectionId, type: .ttf))
                }
            }
            ttfTags = ttfTags.uniqued()
            
            let industriesTags = (ticker?.tickerIndustries ?? []).flatMap({$0.toUnifiedContainers()})
            let categoriesTags = (ticker?.tickerCategories ?? []).flatMap({$0.toUnifiedContainers()})
            tags = ttfTags + categoriesTags + industriesTags
            
            //            if ticker.fragments.remoteTickerDetailsFull. {
            //                for tag in
            //            }
            
            let holdModel = HoldingViewModel(matchScore: TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0,
                                             name: (holdingGroup.details?.tickerName ?? "").companyMarkRemoved,
                                             balance: Float(holdingGroup.gains?.actualValue ?? 0.0),
                                             tickerSymbol: symbol,
                                             tickerTags: tags.compactMap({$0.tickerTag()}),
                                             showLTT: holdingGroup.details?.lttQuantityTotal ?? 0.0 > 0.0,
                                             todayPrice: TickerLiveStorage.shared.getSymbolData(symbol)?.currentPrice ?? 0.0,
                                             todayGrow: TickerLiveStorage.shared.getSymbolData(symbol)?.priceChangeToday ?? 0.0,
                                             absoluteGains: absGains,
                                             relativeGains: relGains,
                                             percentInProfile: (holdingGroup.details?.valueToPortfolioValue ?? 0.0) * 100.0,
                                             securities: securities,
                                             securityTypes: holdingGroup.holdings.compactMap({$0.holdingDetails?.securityType}),
                                             holdingDetails: holdingGroup.details,
                                             event: holdingGroup.details?.nextEarningsDate,
                                             institutionIds: institutionIds,
                                             accountIds: holdingGroup.holdings.compactMap(\.accountId),
                                             tickerInterests: tags.filter({$0.type == .interest}).compactMap({$0.id}),
                                             tickerCategories: tags.filter({$0.type == .category}).compactMap({$0.id}),
                                             rawTicker: ticker)
            
            holds.append(holdModel)
        }
        
        
        return holds
    }
    
    static func topChartGains(range: ScatterChartView.ChartPeriod, chartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]], sypChartsCache: [ScatterChartView.ChartPeriod : [ChartNormalized]], portfolioGains: GetPlaidHoldingsQuery.Data.PortfolioGain?) -> PortfolioChartGainsViewModel {
        
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
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1d ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1d ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP
            )
            return chartGainModel
        case .w1:
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1w ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1w ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .m1:
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1m ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1m ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .m3:
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_3m ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_3m ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .y1:
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_1y ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_1y ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .y5:
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGain_5y ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGain_5y ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            return chartGainModel
        case .all:
            let chartGainModel = PortfolioChartGainsViewModel.init(rangeGrow: (portfolioGains?.relativeGainTotal ?? 0.0) * 100.0,
                                                                   rangeGrowBalance: portfolioGains?.absoluteGainTotal ?? 0.0,
                                                                   chartData: chartDataPort,
                                                                   spGrow: Float(chartDataSP.startEndDiff),
                                                                   sypChartData: chartDataSP)
            
            return chartGainModel
        }
    }
}
