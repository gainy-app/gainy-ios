//
//  RemoteTicker.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.09.2021.
//

import UIKit
import SwiftDate
import Apollo

struct TickerTag {
    let name: String
    let url: String
    let collectionID: Int
    let id: Int
}

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
        
        self.tags = []
        self.matchTags = []
        self.highlights = ticker.tickerHighlights.compactMap(\.highlight)
        self.wsjData = WSRData(rate: 0.0, targetPrice: 0.0, analystsCount: 0, detailedStats: [])
       
        self.wsrAnalystsCount = 0
        self.recommendedScore = 0.0
        self.medianIndustry = 1
        
        self.news = []
        self.altStocks = []
        self.upcomingEvents = []
        self.linkedCollections = []
        
        self.updateMarketData()
    }

    var isETF: Bool {
        (ticker.type ?? "") == "ETF"
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
        var chartData: ChartData = ChartData(points: [0.0])
        var medianData: ChartData = ChartData(points: [0.0])
        
        var description: String {
            "Have M: \(haveMedian) M: \(medianGrow) CD: \(chartData.points.count)"
        }
    }
    
    func updateMarketData() {
        var markers: [MarketData] = []
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == nil
        }
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        
        for metric in MarketDataField.allCases {
            let marketData = metric.mapToMarketData(ticker: ticker)
            guard let marketData = marketData else {
                continue
            }
            
            if tickerMetrics.count == 0 {
                if MarketDataField.metricsOrder.contains(where: { item in
                    item == metric
                }) {
                    markers.append(marketData)
                }
            }
        }
        
        if tickerMetrics.count > 0 {
            for tickerMetric in tickerMetrics {
                for metric in MarketDataField.allCases {
                    let marketData: TickerInfo.MarketData? = metric.mapToMarketData(ticker: ticker)
                    guard let marketData = marketData else {
                        continue
                    }
                    if tickerMetric.fieldName == metric.fieldName {
                        markers.append(marketData)
                    }
                }
            }
        }
        
        self.marketData = markers
    }
    
    private(set) var isMainDataLoaded: Bool = false
    var isChartDataLoaded: Bool = false
    private var matchLoadTask: Task<Void, Never>?

    func loadDetails(mainDataLoaded:  @escaping () -> Void, chartsLoaded:  @escaping () -> Void) {
        let queue = DispatchQueue.init(label: "TickerInfo.loadDetails")
        let mainDS = DispatchGroup()
        let chartsDS = DispatchGroup()
        chartsCache.removeAll()
        
        if isMainDataLoaded {
            DispatchQueue.main.async {
                mainDataLoaded()
            }
        } else {
            delay(3.0) {
                DispatchQueue.main.async {
                    mainDataLoaded()
                }
            }
        }
        
        if isChartDataLoaded {
            DispatchQueue.main.async {
                chartsLoaded()
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else {return}
            
            
            
            
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
                
                //Load Details
                mainDS.enter()
                
                Network.shared.apollo.fetch(query: GetTickerExtraDetailsQuery.init(symbol: self.symbol)){[weak self] result in
                    switch result {
                    case .success(let graphQLResult):
                        
                         if let tickerDetails = graphQLResult.data?.tickers.compactMap({$0.fragments.remoteTickerExtraDetails}).first {
                            self?.upcomingEvents = tickerDetails.tickerEvents
                             let industries = tickerDetails.tickerIndustries.compactMap({TickerTag.init(name: ($0.gainyIndustry?.name ?? ""),
                                                                                                       url: "",
                                                                                                       collectionID: $0.gainyIndustry?.collectionId ?? -404,
                                                                                                       id: $0.gainyIndustry?.id ?? -404
                            )  })
                            let categories = tickerDetails.tickerCategories.compactMap({TickerTag.init(name: ($0.categories?.name ?? ""), url: $0.categories?.iconUrl ?? "",
                                                                                                       collectionID: $0.categories?.collectionId ?? -404,
                                                                                                       id: $0.categories?.id ?? -404
                            )})
                            
                            self?.tags = categories + industries
                            self?.wsjData = WSRData(rate: tickerDetails.tickerAnalystRatings?.rating ?? 0.0, targetPrice: tickerDetails.tickerAnalystRatings?.targetPrice ?? 0.0,  analystsCount: 39, detailedStats: [WSRData.WSRDataDetails(name: "VERY BULLISH", count: tickerDetails.tickerAnalystRatings?.strongBuy ?? 0),
                                                                                                                                                                                                       WSRData.WSRDataDetails(name: "BULLISH", count: tickerDetails.tickerAnalystRatings?.buy ?? 0),
                                                                                                                                                                                                       WSRData.WSRDataDetails(name: "NEUTRAL", count: tickerDetails.tickerAnalystRatings?.hold ?? 0),
                                                                                                                                                                                                       WSRData.WSRDataDetails(name: "BEARISH", count: tickerDetails.tickerAnalystRatings?.sell ?? 0),
                                                                                                                                                                                                       WSRData.WSRDataDetails(name: "VERY BEARISH", count: tickerDetails.tickerAnalystRatings?.strongSell ?? 0)])
                            let wsrParts = [(tickerDetails.tickerAnalystRatings?.strongBuy ?? 0), (tickerDetails.tickerAnalystRatings?.buy ?? 0), (tickerDetails.tickerAnalystRatings?.hold ?? 0), (tickerDetails.tickerAnalystRatings?.sell ?? 0), (tickerDetails.tickerAnalystRatings?.strongSell ?? 0)]
                            self?.wsrAnalystsCount = wsrParts.reduce(0, +)
                             
                             if let mainIndustry  = tickerDetails.tickerIndustries.sorted(by: {($0.industryOrder ?? 1) < ($1.industryOrder ?? 1)}).first  {
                                 self?.medianIndustry = mainIndustry.industryId
                             }
                             if let self = self {
                                 self.loadChartFromServer(period: self.chartRange, dispatchGroup: chartsDS) {
                                     self.isChartDataLoaded = true
                                     if let chartCache = self.chartsCache[.d1] {
                                         self.updateChartData(chartCache.chartData)
                                         self.medianGrow = chartCache.medianGrow
                                         self.haveMedian = chartCache.haveMedian
                                     }
                                     DispatchQueue.main.async {
                                         chartsLoaded()
                                     }
                                 }
                             }
                             self?.linkedCollections = tickerDetails.tickerCollections.compactMap({$0.collection?.fragments.remoteCollectionDetails})
                        }
                        
                        mainDS.leave()
                        break
                    case .failure(let error):
                        dprint("Failure when making GraphQL request. Error: \(error)")
                        mainDS.leave()
                        break
                    }
                }
                
                //Load Match Tags
                
                mainDS.enter()
                if let matchData  = TickerLiveStorage.shared.getMatchData(self.symbol) {
                    if let matchLoadTask = self.matchLoadTask {
                        matchLoadTask.cancel()
                    }
                    self.matchLoadTask = Task {
                        let loadedTags = await matchData.combinedTags()
                        self.matchTags = loadedTags
                        mainDS.leave()
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
                        self?.altStocks = tickers.filter({$0.symbol != self?.symbol}).uniqued().sorted(by: {
                            ($0.matchScore?.matchScore ?? 0) > ($1.matchScore?.matchScore ?? 0)
                        })

                        for tickLivePrice in tickers.compactMap(\.realtimeMetrics) {
                            TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                        }
                        
                        for mScore in tickers.compactMap(\.matchScore) {
                            TickerLiveStorage.shared.setMatchData(mScore.symbol, data: mScore)
                        }
                        mainDS.leave()
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
                DispatchQueue.main.async {
                    self.isMainDataLoaded = true
                    mainDataLoaded()
                }
            }
            
            chartsDS.notify(queue: queue) {
                self.isChartDataLoaded = true
                if let chartCache = self.chartsCache[.d1] {
                    self.updateChartData(chartCache.chartData)
                    self.medianGrow = chartCache.medianGrow
                    self.haveMedian = chartCache.haveMedian
                }
                DispatchQueue.main.async {
                    chartsLoaded()
                }
            }
        }
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
    
    
    private func setChartsCache(_ period: ScatterChartView.ChartPeriod, chartData: ChartData) {
        print("CHART \(period) \(chartData.points.count)")
        if let cache = chartsCache[period] {
            cache.chartData = chartData
        }
    }
    
    private func setMedianData(_ period: ScatterChartView.ChartPeriod, medianGrow: Float, haveMedian: Bool, medianChart: ChartData? = nil) {
        if let cache = chartsCache[period] {
            cache.medianGrow = medianGrow
            cache.haveMedian = haveMedian
            if let medianChart = medianChart {
                cache.medianData = medianChart
            }
        }
    }
    
    private func loadChartFromServer(period: ScatterChartView.ChartPeriod, dispatchGroup: DispatchGroup? = nil, _ completion: ( () -> Void)?) {
        dispatchGroup?.enter()
        
        var mainChart: [ChartNormalized] = []
        var medianChart: [ChartNormalized] = []
        
        let innerGroup = DispatchGroup()
        innerGroup.enter()
        HistoricalChartsLoader.shared.loadChart(symbol: symbol, range: period) {[weak self] chartData, chartRemData in
            
            self?.setChartsCache(period, chartData: chartData)
            
            if dispatchGroup == nil {
                self?.updateChartData(chartData)
            }
            mainChart = chartRemData
            
            innerGroup.leave()
        }
        
        innerGroup.enter()
        loadMedianForRange(period, industryId: medianIndustry) {[weak self] dailyStats in
            
            if dailyStats.count > 1 {
                let firstDay = dailyStats.first?.medianPrice ?? 0.0
                let lastDay = dailyStats.last?.medianPrice  ?? 0.0
                self?.medianGrow = self?.pctDiff(firstDay, lastDay) ?? 0.0
                self?.haveMedian = true
                self?.setMedianData(period, medianGrow: self?.pctDiff(firstDay, lastDay) ?? 0.0, haveMedian: true)
            } else {
                self?.medianGrow = 0.0
                self?.haveMedian = false
                self?.setMedianData(period, medianGrow: 0.0, haveMedian: false)
            }
            medianChart = dailyStats
            
            innerGroup.leave()
        }
        
        innerGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            
            //Normalize
            let (main, median) = normalizeCharts(mainChart, medianChart)
            
            let mainData = ChartData(points: main, period: period)
            let medianData = ChartData(points: median, period: period)
            
            self.setChartsCache(period, chartData: mainData)
            
            //if dispatchGroup == nil {
            self.updateChartData(mainData)
            self.updateMedianData(medianData)
            //}
            
            self.setMedianData(period, medianGrow: self.medianGrow, haveMedian: self.haveMedian, medianChart: medianData)
            completion?()
            dispatchGroup?.leave()
        }
    }
    
    private var medianLoader: Cancellable?
    func loadMedianForRange(_ range: ScatterChartView.ChartPeriod, industryId: Int, _ completion: ( ([FetchStockMedianQuery.Data.IndustryMedianChart]) -> Void)? = nil) {
        
        haveMedian = false
        
        Network.shared.apollo.fetch(query: FetchStockMedianQuery.init(industryId: industryId, period: range.rawValue.lowercased())) {[weak self] result in
            switch result {
            case .success(let graphQLResult):
                if let dailyStats = graphQLResult.data?.industryMedianChart {
                    completion?(dailyStats)
                } else {
                    completion?([])
                }
                break
            case .failure(let error):
                dprint("Failure when making FetchStockMedianQuery request. Error: \(error)")
                completion?([])
                break
            }
        }
    }
    
    private func pctDiff(_ x1: Float, _ x2: Float) -> Float {
        let diff = (x2 - x1) / x1
        return Float(round(100 * (diff * 100)) / 100)
    }
    
    private func updateChartData(_ data: ChartData) {
        self.localChartData = data
    }
    
    private func updateMedianData(_ data: ChartData) {
        self.localMedianData = data
    }
    
    private func updateNewsData(_ data: [DiscoverNewsQuery.Data.FetchNewsDatum]) {
        self.news = data
    }
    
    //MARK: - Header
    let name: String
    let symbol: String
    
    //MARK: - Chart
    var chartRange: ScatterChartView.ChartPeriod = .d1
    var localChartData: ChartData = ChartData.init(points: [0.0])
    var localMedianData: ChartData = ChartData.init(points: [0.0])
    
    //MARK: - About
    let about: String
    let aboutShort: String
    var tags: [TickerTag]
    var matchTags: [TickerTag]
    
    
    
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
    
    var wsjData: WSRData
    var wsrAnalystsCount: Int
    
    //MARK: - Recommended
    let recommendedScore: Float
    
    //MARK: - News
    var news: [DiscoverNewsQuery.Data.FetchNewsDatum]
    
    //MARK: - Stocks
    var altStocks: [AltStockTicker]
    
    var tickersToCompare: [AltStockTicker] = []
    
    //MARK: - Upcoming events
    var upcomingEvents: [RemoteTickerExtraDetails.TickerEvent]
    
    //MARK: -  Median Data
    
    var medianIndustry: Int = 1
    var medianGrow: Float = 0.0
    var haveMedian: Bool = false
    
    //MARK: - Linked Collections
    var linkedCollections: [RemoteCollectionDetails] = []
}
