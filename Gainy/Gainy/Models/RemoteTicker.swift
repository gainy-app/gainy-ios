//
//  RemoteTicker.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.09.2021.
//

import UIKit
import SwiftDate
import Apollo

/// Ticker model to pupulate cells
typealias RemoteTicker = RemoteTickerDetails
typealias AltStockTicker = RemoteTickerDetails
class TickerInfo {
    
    let ticker: RemoteTicker
    
    init(ticker: RemoteTicker) {
        self.ticker = ticker
        
        self.name = ticker.name ?? ""
        self.symbol = ticker.symbol ?? ""
        self.about = String((ticker.description ?? "").dropFirst().dropLast())
        self.aboutShort = self.about.count < debugStr.count ? self.about : String(self.about.prefix(debugStr.count)) + "..."
        
        let industries = ticker.tickerIndustries.compactMap({$0.gainyIndustry?.name})
        let categories = ticker.tickerCategories.compactMap({$0.categories?.name})
        self.tags = categories + industries
        self.highlights = ticker.tickerHighlights.compactMap(\.highlight)
        self.wsjData = WSRData(rate: ticker.tickerAnalystRatings?.rating ?? 0.0, targetPrice: ticker.tickerAnalystRatings?.targetPrice ?? 0.0,  analystsCount: 39, detailedStats: [WSRData.WSRDataDetails(name: "VERY BULLISH", count: ticker.tickerAnalystRatings?.strongBuy ?? 0),
                                                                                                                                                                                   WSRData.WSRDataDetails(name: "BULLISH", count: ticker.tickerAnalystRatings?.buy ?? 0),
                                                                                                                                                                                   WSRData.WSRDataDetails(name: "NEUTRAL", count: ticker.tickerAnalystRatings?.hold ?? 0),
                                                                                                                                                                                   WSRData.WSRDataDetails(name: "BEARISH", count: ticker.tickerAnalystRatings?.sell ?? 0),
                                                                                                                                                                                   WSRData.WSRDataDetails(name: "VERY BEARISH", count: ticker.tickerAnalystRatings?.strongSell ?? 0)])
        let wsrParts = [(ticker.tickerAnalystRatings?.strongBuy ?? 0), (ticker.tickerAnalystRatings?.buy ?? 0), (ticker.tickerAnalystRatings?.hold ?? 0), (ticker.tickerAnalystRatings?.sell ?? 0), (ticker.tickerAnalystRatings?.strongSell ?? 0)]
        self.wsrAnalystsCount = wsrParts.reduce(0, +)
        self.recommendedScore = 0.0
        
        self.news = []
        self.altStocks = []
        self.upcomingEvents = ticker.tickerEvents
        
        self.updateMarketData()
    }
    
    let debugStr =
    """
    Activision Inc. operates as a holding company, which engages in the development of data integration and software solutions.
    """
    
    //MARK: - Caching
    private var chartsCache: [ScatterChartView.ChartPeriod : ChartDataCache] = [:]
    
    class ChartDataCache {
        var medianGrow: Float = 0.0
        var haveMedian: Bool = false
        var chartData: [DiscoverChartsQuery.Data.FetchChartDatum] = []
        
        var description: String {
            "Have M: \(haveMedian) M: \(medianGrow) CD: \(chartData.count)"
        }
    }
    
    func updateMarketData() {
        var markers: [MarketData] = []
        for metric in MarketDataField.allCases {
            
            let marketData = metric.mapToMarketData(ticker: ticker)
            guard let marketData = marketData else {
                continue
            }
            
            var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
                item.collectionId == nil
            }
            tickerMetrics = tickerMetrics.sorted { left, right in
                left.order < right.order
            }
            if tickerMetrics.count == 0 {
                if MarketDataField.metricsOrder.contains(where: { item in
                    item == metric
                }) {
                    markers.append(marketData)
                }
            } else {
                if tickerMetrics.contains(where: { item in
                    item.fieldName == metric.fieldName
                }) {
                    markers.append(marketData)
                }
            }
        }
        self.marketData = markers
    }
    
    private(set) var isMainDataLoaded: Bool = false
    private(set) var isChartDataLoaded: Bool = false
    
    func loadDetails(mainDataLoaded:  @escaping () -> Void, chartsLoaded:  @escaping () -> Void) {
        let queue = DispatchQueue.init(label: "TickerInfo.loadDetails")
        let mainDS = DispatchGroup()
        let chartsDS = DispatchGroup()
        
        if isMainDataLoaded {
            DispatchQueue.main.async {
                mainDataLoaded()
            }
        }
        
        if isChartDataLoaded {
            DispatchQueue.main.async {
                chartsLoaded()
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {return}
            
            if !self.isChartDataLoaded {
                //Load Chart
                self.loadAllCharts(dispatchGroup: chartsDS)
            }
            
            if !self.isMainDataLoaded {
            //Load News data
            mainDS.enter()
            Network.shared.apollo.fetch(query: DiscoverNewsQuery.init(symbol: self.symbol)){ result in
                switch result {
                case .success(let graphQLResult):
                    self.updateNewsData(graphQLResult.data?.fetchNewsData?.compactMap({$0}) ?? [])
                    mainDS.leave()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    mainDS.leave()
                    break
                }
            }
            
            //Load Alt Stocks
            mainDS.enter()
            Network.shared.apollo.fetch(query: FetchAltStocksQuery.init(symbol: self.symbol)){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    
                    //let tickers = graphQLResult.data?.tickerInterests.compactMap({$0.interest?.tickerInterests.compactMap({$0.ticker?.fragments.remoteTickerDetails})}) ?? []
                    var tickers: [AltStockTicker] = []
                    
                    for tickInd1 in graphQLResult.data?.tickerIndustries ?? [] {
                        tickers.append(contentsOf: (tickInd1.gainyIndustry?.tickerIndustries ?? []).compactMap({$0.ticker?.fragments.remoteTickerDetails}))
                    }
                    
                    //let tickers = graphQLResult.data?.tickerIndustries.compactMap({$0.gainyIndustry?.tickerIndustries.compactMap($0.ticker.fragments.remoteTickerDetails) }) ?? []
                    self?.altStocks = tickers.filter({$0.symbol != self?.symbol}).uniqued()
                    
                    TickersLiveFetcher.shared.getSymbolsData(self?.altStocks.compactMap(\.symbol) ?? []) {
                        self?.altStocks.sort(by: {$0.matchScore > $1.matchScore})
                        mainDS.leave()
                    }
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    mainDS.leave()
                    break
                }
            }
            //Load updated MatchData
            if let profileID = UserProfileManager.shared.profileID {
                mainDS.enter()
                Network.shared.apollo.fetch(query: FetchTickerMatchDataQuery.init(profielId: profileID, symbol: self.symbol)){[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        
                        if let matchData = graphQLResult.data?.getMatchScoreByTicker?.fragments.liveMatch {
                            TickerLiveStorage.shared.setMatchData(self?.symbol ?? "", data: matchData)
                        }
                        mainDS.leave()
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        mainDS.leave()
                        break
                    }
                }
            }
            }
            
            //Await for results
            mainDS.notify(queue: queue) {
                self.isMainDataLoaded = true
                DispatchQueue.main.async {
                    mainDataLoaded()
                }
            }
            
            chartsDS.notify(queue: queue) {
                self.isChartDataLoaded = true
                DispatchQueue.main.async {
                    chartsLoaded()
                }
            }
        }    
    }
    
    /// Loading all charts at once
    /// - Parameter dispatchGroup: Group to sync work
    private func loadAllCharts(dispatchGroup: DispatchGroup) {
        
        for period in ScatterChartView.ChartPeriod.allCases {
            chartsCache[period] = ChartDataCache()
        }
        
        dispatchGroup.enter()
        Network.shared.apollo.fetch(query: DiscoverChartsQuery.init(period: ScatterChartView.ChartPeriod.d1.rawValue, symbol: symbol)){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                
                var fetchedData = (graphQLResult.data?.fetchChartData?.compactMap({$0}) ?? []).filter({$0.close != nil})
                if let lastDay = fetchedData.last {
                    let filtered = fetchedData.filter({$0.date.day == lastDay.date.day && $0.date.month == lastDay.date.month})
                    
                    if let index = fetchedData.firstIndex(where: {$0.datetime == filtered.first?.datetime}) {
                        if index == 0 {
                            fetchedData = filtered
                        } else {
                            fetchedData = Array(fetchedData[(index-1)...])
                        }
                    }
                }
                self?.setChartsCache(.d1, chartData: fetchedData)
                self?.updateChartData(fetchedData)
                dispatchGroup.leave()
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        }
        
        //Load day median
        loadMedianForRange(.d1, dispatchGroup: dispatchGroup)
        
        loadChartFromServer(period: .w1, dispatchGroup: dispatchGroup, nil)
        loadChartFromServer(period: .m1, dispatchGroup: dispatchGroup, nil)
        loadChartFromServer(period: .m3, dispatchGroup: dispatchGroup, nil)
        loadChartFromServer(period: .y1, dispatchGroup: dispatchGroup, nil)
        loadChartFromServer(period: .y5, dispatchGroup: dispatchGroup, nil)
        loadChartFromServer(period: .all, dispatchGroup: dispatchGroup, nil)
    }
    
    /// Update direct Chart only
    func loadNewChartData(period: ScatterChartView.ChartPeriod, _ completion: ( () -> Void)? = nil) {
        if let chartCache = chartsCache[chartRange] {
            self.updateChartData(chartCache.chartData)
            self.medianGrow = chartCache.medianGrow
            self.haveMedian = chartCache.haveMedian
            completion?()
        } else {
            loadChartFromServer(period: period, completion)
        }
    }
    
    
    private func setChartsCache(_ period: ScatterChartView.ChartPeriod, chartData: [DiscoverChartsQuery.Data.FetchChartDatum]) {
        if let cache = chartsCache[period] {
            cache.chartData = chartData
        }
    }
    
    private func setMedianData(_ period: ScatterChartView.ChartPeriod, medianGrow: Float, haveMedian: Bool) {
        if let cache = chartsCache[period] {
            cache.medianGrow = medianGrow
            cache.haveMedian = haveMedian
        }
    }
    
    private func loadChartFromServer(period: ScatterChartView.ChartPeriod, dispatchGroup: DispatchGroup? = nil, _ completion: ( () -> Void)?) {
        dispatchGroup?.enter()
        Network.shared.apollo.fetch(query: DiscoverChartsQuery.init(period: period.rawValue, symbol: symbol)){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                var chartRemData = (graphQLResult.data?.fetchChartData?.compactMap({$0}) ?? []).filter({$0.close != nil})
                if period == .d1 {
                    if let lastDay = chartRemData.last {
                        let filtered = chartRemData.filter({$0.date.day == lastDay.date.day && $0.date.month == lastDay.date.month})
                        if let index = chartRemData.firstIndex(where: {$0.datetime == filtered.first?.datetime}) {
                            if index == 0 {
                                chartRemData = filtered
                            } else {
                                chartRemData = Array(chartRemData[(index-1)...])
                            }
                        }
                    }
                }
                self?.setChartsCache(period, chartData: chartRemData)
                
                if dispatchGroup == nil {
                    self?.updateChartData(chartRemData)
                }
                if chartRemData.count > 0 {
                    if let datetime = chartRemData.first?.datetime {
                        self?.loadMedianForRange(period, explicitDate: String(datetime.prefix(while: { $0 != "T"}))) {
                            dprint("Date for median: \(self?.haveMedian ?? false)")
                            completion?()
                        }
                    } else {
                        self?.loadMedianForRange(period) {
                            completion?()
                        }
                    }
                } else {
                    self?.medianGrow = 0.0
                    self?.haveMedian = false
                    self?.setMedianData(period, medianGrow: 0.0, haveMedian: false)
                    completion?()
                }
                dispatchGroup?.leave()
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion?()
                dispatchGroup?.leave()
                break
            }
        }
    }
    
    private var medianLoader: Cancellable?
    func loadMedianForRange(_ range: ScatterChartView.ChartPeriod, explicitDate: String = "",  dispatchGroup: DispatchGroup? = nil, _ completion: ( () -> Void)? = nil) {
        dispatchGroup?.enter()
        haveMedian = false
        
        switch range {
        case .d1:
            dprint("Date for median: \((Date().startOfDay - 1.days).toFormat("yyyy-MM-dd"))")
            Network.shared.apollo.fetch(query: FetchStockMedianDayQuery.init(symbol: symbol, date: (Date().startOfDay - 1.days).toFormat("yyyy-MM-dd")) ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let tickers = graphQLResult.data?.tickers.first {
                        if let industries  = tickers.tickerIndustries.first {
                            if let dailyStats = industries.gainyIndustry?.industryStatsDailies.compactMap({$0.medianPrice}), dailyStats.count > 1 {
                                let firstDay = dailyStats.first ?? 0.0
                                let lastDay = dailyStats.last ?? 0.0
                                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                                self?.haveMedian = true
                                self?.setMedianData(range, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
                            }
                        }
                    }
                    dispatchGroup?.leave()
                    completion?()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    dispatchGroup?.leave()
                    completion?()
                    break
                }
            }
            break
            
        case .w1:
            dprint("Date for median: \((Date().startOfDay - 7.days).toFormat("yyyy-MM-dd"))")
            Network.shared.apollo.fetch(query: FetchStockMedianDayQuery.init(symbol: symbol, date: (Date().startOfDay - 7.days).toFormat("yyyy-MM-dd")) ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let tickers = graphQLResult.data?.tickers.first {
                        if let industries  = tickers.tickerIndustries.first {
                            if let dailyStats = industries.gainyIndustry?.industryStatsDailies.compactMap({$0.medianPrice}), dailyStats.count > 1 {
                                let firstDay = dailyStats.first ?? 0.0
                                let lastDay = dailyStats.last ?? 0.0
                                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                                self?.haveMedian = true
                                self?.setMedianData(range, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
                            }
                        }
                    }
                    dispatchGroup?.leave()
                    completion?()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    dispatchGroup?.leave()
                    completion?()
                    break
                }
            }
            break
        case .m1:
            var loadDate: String = explicitDate
            if explicitDate.isEmpty {
                loadDate = (Date().startOfDay - 1.months).toFormat("yyyy-MM-dd")
            }
            dprint("Date for median: \(loadDate)")
            Network.shared.apollo.fetch(query: FetchStockMedianDayQuery.init(symbol: symbol, date: loadDate) ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let tickers = graphQLResult.data?.tickers.first {
                        if let industries  = tickers.tickerIndustries.first {
                            if let dailyStats = industries.gainyIndustry?.industryStatsDailies.compactMap({$0.medianPrice}), dailyStats.count > 1 {
                                let firstDay = dailyStats.first ?? 0.0
                                let lastDay = dailyStats.last ?? 0.0
                                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                                self?.haveMedian = true
                                self?.setMedianData(range, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
                            }
                        }
                    }
                    dispatchGroup?.leave()
                    completion?()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    dispatchGroup?.leave()
                    completion?()
                    break
                }
            }
            break
        case .m3:
            var loadDate: String = explicitDate
            if explicitDate.isEmpty {
                loadDate = (Date().startOfDay - 3.months).toFormat("yyyy-MM-dd")
            }
            dprint("Date for median: \(loadDate)")
            Network.shared.apollo.fetch(query: FetchStockMedianWeekQuery.init(symbol: symbol, date: loadDate) ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let tickers = graphQLResult.data?.tickers.first {
                        if let industries  = tickers.tickerIndustries.first {
                            if let dailyStats = industries.gainyIndustry?.tickerIndustryMedian_1w.compactMap({$0.medianPrice}), dailyStats.count > 1 {
                                let firstDay = dailyStats.first ?? 0.0
                                let lastDay = dailyStats.last ?? 0.0
                                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                                self?.haveMedian = true
                                self?.setMedianData(range, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
                            }
                        }
                    }
                    dispatchGroup?.leave()
                    completion?()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    dispatchGroup?.leave()
                    completion?()
                    break
                }
            }
            break
        case .y1:
            var loadDate: String = explicitDate
            if explicitDate.isEmpty {
                loadDate = (Date().startOfDay - 1.years).toFormat("yyyy-MM-dd")
            }
            dprint("Date for median: \(loadDate)")
            Network.shared.apollo.fetch(query: FetchStockMedianMonthQuery.init(symbol: symbol, date: loadDate) ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let tickers = graphQLResult.data?.tickers.first {
                        if let industries  = tickers.tickerIndustries.first {
                            if let dailyStats = industries.gainyIndustry?.tickerIndustryMedian_1m.compactMap({$0.medianPrice}), dailyStats.count > 1 {
                                let firstDay = dailyStats.first ?? 0.0
                                let lastDay = dailyStats.last ?? 0.0
                                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                                self?.haveMedian = true
                                self?.setMedianData(range, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
                            }
                        }
                    }
                    dispatchGroup?.leave()
                    completion?()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    dispatchGroup?.leave()
                    completion?()
                    break
                }
            }
            break
        case .y5, .all:
            var loadDate: String = explicitDate
            if explicitDate.isEmpty {
                loadDate = (Date().startOfDay - 5.years).toFormat("yyyy-MM-dd")
            }
            dprint("Date for median: \(loadDate)")
            Network.shared.apollo.fetch(query: FetchStockMedianMonthQuery.init(symbol: symbol, date: loadDate) ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    if let tickers = graphQLResult.data?.tickers.first {
                        if let industries  = tickers.tickerIndustries.first {
                            if let dailyStats = industries.gainyIndustry?.tickerIndustryMedian_1m.compactMap({$0.medianPrice}), dailyStats.count > 1 {
                                let firstDay = dailyStats.first ?? 0.0
                                let lastDay = dailyStats.last ?? 0.0
                                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                                self?.haveMedian = true
                                self?.setMedianData(range, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
                            }
                        }
                    }
                    dispatchGroup?.leave()
                    completion?()
                    break
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    dispatchGroup?.leave()
                    completion?()
                    break
                }
            }
            break
        }
        
    }
    
    private func pctDiff(_ x1: Float, _ x2: Float) -> Float {
        let diff = (x2 - x1) / x1
        return Float(round(100 * (diff * 100)) / 100)
    }
    
    private func updateChartData(_ data: [DiscoverChartsQuery.Data.FetchChartDatum]) {
        self.chartData = data
        self.localChartData.loadValues(data, period: chartRange)
    }
    
    private func updateNewsData(_ data: [DiscoverNewsQuery.Data.FetchNewsDatum]) {
        self.news = data
    }
    
    //MARK: - Header
    let name: String
    let symbol: String
    
    //MARK: - Chart
    var chartData: [DiscoverChartsQuery.Data.FetchChartDatum] = []
    var chartRange: ScatterChartView.ChartPeriod = .d1
    var localChartData: ChartData =  ChartData.init(points: [0.0])
    
    //MARK: - About
    let about: String
    let aboutShort: String
    let tags: [String]
    
    //MARK: - Highlights
    let highlights: [String]
    
    //MARK: - Market data
    public struct MarketData {
        let name: String
        let period: String
        let value: String
        let marketDataField: MarketDataField
    }
    
    var marketData: [MarketData] = []
    
    //MARK: - WSJ
    struct WSRData: Hashable {
        
        struct WSRDataDetails: Hashable {
            let name: String
            let count: Int
        }
        
        let rate: Float
        let targetPrice: Float
        let analystsCount: Int
        let detailedStats: [WSRDataDetails]
    }
    
    let wsjData: WSRData
    let wsrAnalystsCount: Int
    
    //MARK: - Recommended
    let recommendedScore: Float
    
    //MARK: - News
    var news: [DiscoverNewsQuery.Data.FetchNewsDatum]
    
    //MARK: - Stocks
    var altStocks: [AltStockTicker]
    
    var tickersToCompare: [AltStockTicker] = []
    
    //MARK: - Upcoming events
    let upcomingEvents: [RemoteTickerDetails.TickerEvent]
    
    //MARK: -  Median Data
    
    var medianGrow: Float = 0.0
    var haveMedian: Bool = false
}
