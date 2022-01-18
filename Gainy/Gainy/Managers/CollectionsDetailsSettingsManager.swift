//
//  CollectionsDetailsSettingsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 31.08.2021.
//

import UIKit

typealias CollectionId = Int

struct CollectionSettings: Codable {
    enum ViewMode: Int, Codable {
        case list = 0, grid
    }
    
    let collectionID: Int
    let sorting: MarketDataField
    let ascending: Bool
    let viewMode: ViewMode
    
    func sortingValue() -> MarketDataField {
        
        let marketDataToShow: [MarketDataField] = self.marketDataToShow
        if marketDataToShow.contains(where: { item in
            item == sorting
        }) {
            return sorting
        }
        
        return marketDataToShow.first ?? .matchScore
    }
    
    func sortingText() -> String {
        
        let marketDataToShow: [MarketDataField] = self.marketDataToShow
        if marketDataToShow.contains(where: { item in
            item == sorting
        }) {
            return sorting.title
        }
        
        return marketDataToShow.first?.title ?? "Match Score"
    }
    
    
    //Used for prefetching
    var marketDataToShow: [MarketDataField] {
        
        let defaultSortingList = MarketDataField.rawOrder
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == collectionID
        }
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        var sortingList: [MarketDataField] = []
        if tickerMetrics.count == 0 {
            sortingList = defaultSortingList
        } else {
            sortingList.append(.matchScore)
            for metric in MarketDataField.allCases {
                for item in tickerMetrics {
                    if metric.fieldName == item.fieldName {
                        sortingList.append(metric)
                    }
                }
            }
        }
        
        if let index = sortingList.firstIndex(where: {$0 == sorting}) {
            sortingList.remove(at: index)
            sortingList.insert(sorting, at: 0)
        }
        return sortingList
    }
}

final class CollectionsDetailsSettingsManager {
    
    static let shared = CollectionsDetailsSettingsManager()
    
    @UserDefault("CollectionsDetailsSettingsManager.settings_v1.0_prod")
    private var settings: [CollectionId : CollectionSettings]?
    
    //MARK: - Functions
    
    //All Sortings
    func sortingsForCollectionID(collectionID: Int) -> [String] {
        
        let defaultSortingList = MarketDataField.rawOrder
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == collectionID
        }
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        var sortingList: [MarketDataField] = []
        if tickerMetrics.count == 0 {
            sortingList = defaultSortingList
        } else {
            sortingList.append(.matchScore)
            for metric in MarketDataField.allCases {
                for item in tickerMetrics {
                    if metric.fieldName == item.fieldName {
                        sortingList.append(metric)
                    }
                }
            }
        }
        
        return sortingList.map { item in
            return item.title
        }
    }
    
    func getSettingByID(_ id: Int) -> CollectionSettings {
        if settings == nil {
            settings = [:]
        }
        if let settings = settings?[id] {
            return settings
        } else {
            let defSettigns = CollectionSettings(collectionID: id, sorting: MarketDataField.matchScore, ascending: false, viewMode: .grid)
            settings?[id] = defSettigns
            return defSettigns
        }
    }
    
    
    //MARK: - Modifiers
    func changeSortingForId(_ id: Int, sorting: MarketDataField) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(collectionID: id, sorting: sorting, ascending: cur.ascending, viewMode: cur.viewMode)
    }
    
    func changeViewModeForId(_ id: Int, viewMode: CollectionSettings.ViewMode) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(collectionID: id, sorting: cur.sorting, ascending: cur.ascending, viewMode: viewMode )
    }
    
    func changeAscendingForId(_ id: Int, ascending: Bool) {
        let cur = getSettingByID(id)
        settings?[id] = CollectionSettings(collectionID: id, sorting: cur.sorting, ascending: ascending, viewMode: cur.viewMode )
    }
    
    func tickerMetricsOrderForMarketData(filed: MarketDataField, ascending: Bool) -> ticker_metrics_order_by {

        let order = ascending ? order_by.asc : order_by.desc
        var orderBy = ticker_metrics_order_by.init()
        switch filed {
            
        case .matchScore:
            orderBy = ticker_metrics_order_by.init()
        case .avgVolume10d:
            orderBy = ticker_metrics_order_by.init(avgVolume_10d: order)
        case .sharesOutstanding:
            orderBy = ticker_metrics_order_by.init(sharesOutstanding: order)
        case .shortPercentOutstanding:
            orderBy = ticker_metrics_order_by.init(shortPercentOutstanding: order)
        case .avgVolume90d:
            orderBy = ticker_metrics_order_by.init(avgVolume_90d: order)
        case .sharesFloat:
            orderBy = ticker_metrics_order_by.init(sharesFloat: order)
        case .shortRatio:
            orderBy = ticker_metrics_order_by.init(shortRatio: order)
        case .beta:
            orderBy = ticker_metrics_order_by.init(beta: order)
        case .impliedVolatility:
            orderBy = ticker_metrics_order_by.init(impliedVolatility: order)
        case .volatility52Weeks:
            orderBy = ticker_metrics_order_by.init(relativeHistoricalVolatilityAdjustedMax_1y: order,
                                                   relativeHistoricalVolatilityAdjustedMin_1y: order)
        case .revenueGrowthYoy:
            orderBy = ticker_metrics_order_by.init(revenueGrowthYoy: order)
        case .revenueGrowthFwd:
            orderBy = ticker_metrics_order_by.init(revenueGrowthFwd: order)
        case .ebitdaGrowthYoy:
            orderBy = ticker_metrics_order_by.init(ebitdaGrowthYoy: order)
        case .epsGrowthYoy:
            orderBy = ticker_metrics_order_by.init(epsGrowthYoy: order)
        case .epsGrowthFwd:
            orderBy = ticker_metrics_order_by.init(epsGrowthFwd: order)
        case .address:
            orderBy = ticker_metrics_order_by.init(addressCity: order)
        case .exchangeName:
            orderBy = ticker_metrics_order_by.init(exchangeName: order)
        case .marketCapitalization:
            orderBy = ticker_metrics_order_by.init(marketCapitalization: order)
        case .enterpriseValueToSales:
            orderBy = ticker_metrics_order_by.init(enterpriseValueToSales: order)
        case .priceToEarningsTtm:
            orderBy = ticker_metrics_order_by.init(priceToEarningsTtm: order)
        case .priceToSalesTtm:
            orderBy = ticker_metrics_order_by.init(priceToSalesTtm: order)
        case .priceToBookValue:
            orderBy = ticker_metrics_order_by.init(priceToBookValue: order)
        case .enterpriseValueToEbitda:
            orderBy = ticker_metrics_order_by.init(enterpriseValueToEbitda: order)
        case .priceChange1m:
            orderBy = ticker_metrics_order_by.init(priceChange_1m: order)
        case .priceChange3m:
            orderBy = ticker_metrics_order_by.init(priceChange_3m: order)
        case .priceChange1y:
            orderBy = ticker_metrics_order_by.init(priceChange_1y: order)
        case .dividendYield:
            orderBy = ticker_metrics_order_by.init(dividendYield: order)
        case .dividendsPerShare:
            orderBy = ticker_metrics_order_by.init(dividendsPerShare: order)
        case .dividendPayoutRatio:
            orderBy = ticker_metrics_order_by.init(dividendPayoutRatio: order)
        case .yearsOfConsecutiveDividendGrowth:
            orderBy = ticker_metrics_order_by.init(yearsOfConsecutiveDividendGrowth: order)
        case .dividendFrequency:
            orderBy = ticker_metrics_order_by.init(dividendFrequency: order)
        case .epsActual:
            orderBy = ticker_metrics_order_by.init(epsActual: order)
        case .epsEstimate:
            orderBy = ticker_metrics_order_by.init(epsEstimate: order)
        case .beatenQuarterlyEpsEstimationCountTtm:
            orderBy = ticker_metrics_order_by.init(beatenQuarterlyEpsEstimationCountTtm: order)
        case .epsSurprise:
            orderBy = ticker_metrics_order_by.init(epsSurprise: order)
        case .revenueEstimateAvg0y:
            orderBy = ticker_metrics_order_by.init(revenueEstimateAvg_0y: order)
        case .revenueActual:
            orderBy = ticker_metrics_order_by.init(revenueActual: order)
        case .revenueTtm:
            orderBy = ticker_metrics_order_by.init(revenueTtm: order)
        case .revenuePerShareTtm:
            orderBy = ticker_metrics_order_by.init(revenuePerShareTtm: order)
        case .roi:
            orderBy = ticker_metrics_order_by.init(roi: order)
        case .netIncome:
            orderBy = ticker_metrics_order_by.init(netIncome: order)
        case .assetCashAndEquivalents:
            orderBy = ticker_metrics_order_by.init(assetCashAndEquivalents: order)
        case .roa:
            orderBy = ticker_metrics_order_by.init(roa: order)
        case .totalAssets:
            orderBy = ticker_metrics_order_by.init(totalAssets: order)
        case .ebitda:
            orderBy = ticker_metrics_order_by.init(ebitda: order)
        case .profitMargin:
            orderBy = ticker_metrics_order_by.init(profitMargin: order)
        case .netDebt:
            orderBy = ticker_metrics_order_by.init(netDebt: order)
        }
        
        return orderBy
    }
}
