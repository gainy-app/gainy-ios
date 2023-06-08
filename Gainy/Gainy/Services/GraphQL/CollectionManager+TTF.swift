//
//  CollectionManager+TTF.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.04.2022.
//

import UIKit
import GainyAPI

public struct PieChartData {
    public let weight: float8?
    public let entityType: String?
    public let relativeDailyChange: float8?
    public let entityName: String?
    public let entityId: String?
    public let absoluteValue: float8?
    public let absoluteDailyChange: float8?
}

typealias TTFStatus = TradingGetTtfStatusQuery.Data.TradingProfileCollectionStatus

extension CollectionsManager {
    func populateTTFCard(uniqID: String, collectionId: Int, range: ScatterChartView.ChartPeriod, _ completion: @escaping (String, [[ChartNormalized]], [PieChartData], [TickerTag], CollectionDetailPurchaseInfoModel?, CollectionDetailHistoryInfoModel,  GetCollectionMetricsQuery.Data.CollectionMetric?, Bool) -> Void) {
        
        Task {
            //Load D1 Top
            async let allTopCharts = loadChartsForRange(uniqID: uniqID, range: range)
            
            //Load Pie - category
            
            async let pieChart = loadPieChart(uniqID: uniqID)
            //Load Rec Tags
            async let recTags = loadRecTags(uniqID: uniqID)
            
            async let status = getCollectionStatus(collectionId: collectionId)
            
            async let history = getCollectionHistory(collectionId: collectionId)
            async let metrics = getCollectionMetrics(collectionUniqId: uniqID)
            async let openMarketDate = LatestTradingSessionManager.shared.getTTFSession(uniqID: uniqID)
            
            let allInfo = await (allTopCharts, pieChart, recTags, status, history, metrics, openMarketDate)
            
            await MainActor.run {
                
                var firstDataDate: Date?
              
                firstDataDate = allInfo.0.count > 1 ?  allInfo.0.first?.first?.date : nil
                
                //Checking Market Open Date
                var isMarketJustOpened = false
                if let openMarketDate = allInfo.6 {
                    if let firstDataDate {
                        if firstDataDate >= openMarketDate {
                            isMarketJustOpened = false
                        }
                    }
                    isMarketJustOpened = openMarketDate < Date() && Date() < openMarketDate.addingTimeInterval(60.0 * 20.0)                    
                } else {
                    isMarketJustOpened = false
                }
                completion(uniqID,
                           allInfo.0,
                           allInfo.1,
                           allInfo.2,
                           allInfo.3 != nil ? CollectionDetailPurchaseInfoModel.init(status: allInfo.3!) : nil,
                           CollectionDetailHistoryInfoModel.init(status: allInfo.4),
                           allInfo.5,
                           isMarketJustOpened)
            }
        }
    }
    
    func loadChartsForRange(uniqID: String, range: ScatterChartView.ChartPeriod) async -> [[ChartNormalized]] {
        async let chart = loadTopChart(uniqID: uniqID, range: range)
        async let syp = loadSYPChart(range: range)
        
        let bothCharts = await [chart, syp]
        return bothCharts
    }
    
    private func loadTopChart(uniqID: String, range: ScatterChartView.ChartPeriod) async -> [ChartNormalized] {
        return await
        withCheckedContinuation { continuation in
            var periodString = ""
            switch range {
            case .d1:
                periodString = "1d"
            case .w1:
                periodString = "1w"
            case .m1:
                periodString = "1m"
            case .m3:
                periodString = "3m"
            case .y1:
                periodString = "1y"
            case .y5:
                periodString = "5y"
            case .all:
                periodString = "all"
            }
            print("GetTTFChart: \(uniqID) \(periodString)")
            Network.shared.apollo.fetch(query: GetTtfChartQuery(uniqID: uniqID, period: periodString)) {result in
                switch result {
                case .success(let graphQLResult):
                    if var fetchedData = graphQLResult.data?.collectionChart.filter({$0.adjustedClose != nil}) {
                        if range == .d1 && fetchedData.count == 2 {
                            if let firstData = fetchedData.first {
                                fetchedData.insert(GetTtfChartQuery.Data.CollectionChart(datetime: firstData.datetime,
                                                                                         period: firstData.period,
                                                                                         adjustedClose: firstData.adjustedClose), at: 0)
                            }
                        }
                        continuation.resume(returning: fetchedData)
                    } else {
                        continuation.resume(returning: [ChartNormalized]())
                    }
                    break
                case .failure(let error):
                    dprint("Failure when making GetTtfChartQuery request. Error: \(range) \(error)")
                    continuation.resume(returning: [ChartNormalized]())
                    break
                }
            }
        }
        
    }
    
    private func loadSYPChart(range: ScatterChartView.ChartPeriod) async -> [ChartNormalized] {
        return await
        withCheckedContinuation { continuation in
            HistoricalChartsLoader.shared.loadChart(symbol: Constants.Chart.sypSymbol, range: range) { chartData, rawData in
                continuation.resume(returning: rawData)
            }
        }
    }
    
    //MARK: - Tags
    
    private func loadRecTags(uniqID: String) async -> [TickerTag] {
        return await
        withCheckedContinuation { continuation in
            guard let profileID = UserProfileManager.shared.profileID else {
                continuation.resume(returning: [TickerTag]())
                return
            }
            Network.shared.apollo.fetch(query: GetTtfTagsQuery(uniqID: uniqID, profileId: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    var tags = [TickerTag]()
                    
                    for expl in graphQLResult.data?.collectionMatchScoreExplanation ?? [] {
                        if let interest = expl.interest {
                            tags.append(TickerTag(name: (interest.name ?? ""), url: interest.iconUrl ?? "", collectionID: -404, id: interest.id ?? -1))
                        }
                        if let category = expl.category {
                            tags.append(TickerTag(name: (category.name ?? ""), url: category.iconUrl ?? "", collectionID: category.collectionId ?? -404, id: category.id ?? -1))
                        }
                    }
                    continuation.resume(returning: tags.uniqued())
                    break
                case .failure(let error):
                    dprint("Failure when making GetTtfTagsQuery request. Error: \(error)")
                    continuation.resume(returning: [TickerTag]())
                    break
                }
            }
        }
    }
    
    //MARK: - Pie
    
    private func loadPieChart(uniqID: String) async -> [PieChartData] {
        return await
        withCheckedContinuation { continuation in
            Network.shared.apollo.fetch(query: GetTtfPieChartQuery(uniqID: uniqID)) {result in
                switch result {
                case .success(let graphQLResult):
                    if let fetchedData = graphQLResult.data?.collectionPiechart {
                        let data = fetchedData.compactMap { item in
                            return PieChartData.init(weight: item.weight,
                                                     entityType: item.entityType,
                                                     relativeDailyChange: item.relativeDailyChange,
                                                     entityName: item.entityName,
                                                     entityId: item.entityId,
                                                     absoluteValue: item.absoluteValue,
                                                     absoluteDailyChange: item.absoluteDailyChange)
                        }
                        continuation.resume(returning: data)
                    } else {
                        continuation.resume(returning: [PieChartData]())
                    }
                    break
                case .failure(let error):
                    dprint("Failure when making GetTtfChartQuery request. Error: \(error)")
                    continuation.resume(returning: [PieChartData]())
                    break
                }
            }
        }
    }
    
    //MARK: - Trading
    
    
    /// Get purchased weights for TTF
    /// - Parameter collectionId: TTF ID
    /// - Returns: Empty if not purchased or weights of purchase
    @discardableResult  func getCollectionStatus(collectionId: Int) async -> TTFStatus? {
        guard let profileID = UserProfileManager.shared.profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingGetTtfStatusQuery.init(profile_id: profileID, collection_id: collectionId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.tradingProfileCollectionStatus.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Gets TTF operations collection
    /// - Parameter collectionId: TTF ID
    /// - Returns: History data
    @discardableResult func getCollectionHistory(collectionId: Int) async -> [TradingGetTtfHistoryQuery.Data.AppTradingCollectionVersion] {
        guard let profileID = UserProfileManager.shared.profileID else {
            return [TradingGetTtfHistoryQuery.Data.AppTradingCollectionVersion]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingGetTtfHistoryQuery.init(profile_id: profileID, collection_id: collectionId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.appTradingCollectionVersions else {
                        continuation.resume(returning: [TradingGetTtfHistoryQuery.Data.AppTradingCollectionVersion]())
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: [TradingGetTtfHistoryQuery.Data.AppTradingCollectionVersion]())
                }
            }
        }
    }
    
    /// Get TTf metrics for chart ranges
    /// - Parameter collectionId: uniq Col ID
    /// - Returns: Metrics if exists
    @discardableResult  func getCollectionMetrics(collectionUniqId: String) async -> GetCollectionMetricsQuery.Data.CollectionMetric? {
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetCollectionMetricsQuery(colID: collectionUniqId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.collectionMetrics.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Get Stock status
    /// - Parameter symbol: stock symbol
    /// - Returns: purchase status
    @discardableResult  func getStockStatus(symbol: String) async -> TradingGetStockStatusQuery.Data.TradingProfileTickerStatus? {
        guard let profileID = UserProfileManager.shared.profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingGetStockStatusQuery.init(profile_id: profileID, symbol: symbol)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.tradingProfileTickerStatus.first else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Get stock history
    /// - Parameter symbol: stock symbol
    /// - Returns: history data
    @discardableResult func getStockHistory(symbol: String) async -> [TradingGetStockHistoryQuery.Data.AppTradingOrder] {
        Network.shared.apollo.clearCache()
        typealias StockData = TradingGetStockHistoryQuery.Data.AppTradingOrder
        guard let profileID = UserProfileManager.shared.profileID else {
            return [StockData]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: TradingGetStockHistoryQuery.init(profile_id: profileID, symbol: symbol)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.appTradingOrders else {
                        continuation.resume(returning: [StockData]())
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: [StockData]())
                }
            }
        }
    }
    
    
    /// Cancels pending order
    /// - Parameter orderId: order ID
    /// - Returns: result of cancellation
    @discardableResult func cancelStockOrder(orderId: Int) async -> TradingCancelStockPendingOrderMutation.Data.TradingCancelPendingOrder? {
        guard let profileID = UserProfileManager.shared.profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.perform(mutation: TradingCancelStockPendingOrderMutation.init(profile_id: profileID, trading_order_id: orderId)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.tradingCancelPendingOrder else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Cancel TTF order
    /// - Parameter versionID: collection version ID
    /// - Returns: cancellation result
    @discardableResult func cancelTTFOrder(versionID: Int) async -> TradingCancelPendingOrderMutation.Data.TradingCancelPendingOrder? {
        guard let profileID = UserProfileManager.shared.profileID else {
            return nil
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.perform(mutation: TradingCancelPendingOrderMutation.init(profile_id: profileID, trading_collection_version_id: versionID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let status = graphQLResult.data?.tradingCancelPendingOrder else {
                        continuation.resume(returning: nil)
                        return
                    }
                    continuation.resume(returning: status)
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    /// Get History Item by I
    /// - Parameter uniqId: ID of history item
    /// - Returns: TradingHistoryFrag
    func getTradingHistoryById(uniqId: String, completion: @escaping ((TradingHistoryFrag?) -> Void))  {
        guard let profileID = UserProfileManager.shared.profileID else {
            completion(nil)
            return
        }
        Network.shared.fetch(query: GetProfileExactHistoryItemQuery(profile_id: profileID, uniq_id: uniqId)) {result in
            switch result {
            case .success(let graphQLResult):
                guard let historyItem = graphQLResult.data?.tradingHistory.compactMap({$0.fragments.tradingHistoryFrag}).first else {
                    completion(nil)
                    return
                }
                completion(historyItem)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
