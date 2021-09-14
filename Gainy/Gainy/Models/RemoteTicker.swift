//
//  RemoteTicker.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.09.2021.
//

import UIKit

/// Ticker model to pupulate cells
typealias RemoteTicker = DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker
class TickerInfo {
    
    let ticker: RemoteTicker
    
    init(ticker: RemoteTicker) {
        self.ticker = ticker
        
        self.name = ticker.name ?? ""
        self.symbol = ticker.symbol ?? ""
        self.about = String((ticker.description ?? "").dropFirst().dropLast())
        self.aboutShort = self.about.count < debugStr.count ? self.about : String(self.about.prefix(debugStr.count)) + "..."
        
        self.tags = ticker.tickerIndustries.compactMap({$0.gainyIndustry?.name})
        self.highlights = ticker.tickerFinancials.compactMap(\.highlight)  
        
        var markers: [MarketData] = []
        
        for metric in MarketDataField.metricsOrder {
            switch metric {
            case .dividendGrowth:
                markers.append(MarketData.init(name: "📌 \(metric.title)", period: "ANNUAL", value: Double(ticker.tickerFinancials.last!.dividendGrowth ?? 0.0).formatUsingAbbrevation()))
            case .evs:
                markers.append(MarketData.init(name: "📌 \(metric.title)", period: "ANNUAL", value: (Double(ticker.tickerFinancials.last!.enterpriseValueToSales ?? "0.0") ?? 0.0).formatUsingAbbrevation()))
            case .marketCap:
                markers.append(MarketData.init(name: "📌 \(metric.title)", period: "ANNUAL", value: (ticker.tickerFinancials.last!.marketCapitalization ?? 0.0).formatUsingAbbrevation()))
            case .monthToDay:
                markers.append(MarketData.init(name: "📌 \(metric.title)", period: "ANNUAL", value: (ticker.tickerFinancials.last!.sma_30days ?? 0.0).formatUsingAbbrevation()))
            case .netProfit:
                markers.append(MarketData.init(name: "📌 \(metric.title)", period: "ANNUAL", value:  (ticker.tickerFinancials.last!.netProfitMargin ?? 0.0).percent))
            case .growsRateYOY:
                markers.append(MarketData.init(name: "📌 \(metric.title)", period: "ANNUAL", value: (ticker.tickerFinancials.last!.marketCapCagr_1years ?? 0.0).formatUsingAbbrevation()))
            }
        }
        self.marketData = markers
        
        self.wsjData = WSRData(rate: 4.23, analystsCount: 39, detailedStats: [WSRData.WSRDataDetails(name: "VERY BULLISH", count: 22),
                                                                              WSRData.WSRDataDetails(name: "BULLISH", count: 8),
                                                                              WSRData.WSRDataDetails(name: "NEUTRAL", count: 6),
                                                                              WSRData.WSRDataDetails(name: "BEARISH", count: 2),
                                                                              WSRData.WSRDataDetails(name: "VERY BEARISH", count: 1)]) //needed
        
        self.recommendedScore = 75.0 //needed
        
        self.news = []
        self.altStocks = [] //needed
        self.upcomingEvents = [] //needed
    }
    
    let debugStr =
    """
    Activision Inc. operates as a holding company, which engages in the development of data integration and software solutions.
    """
    
    func loadDetails(_ completion:  @escaping () -> Void) {
        let queue = DispatchQueue.init(label: "TickerInfo.loadDetails")
        let dispatchGroup = DispatchGroup()
        //Load News data
        dispatchGroup.enter()
        Network.shared.apollo.fetch(query: DiscoverNewsQuery.init(symbol: symbol)){ result in
            switch result {
            case .success(let graphQLResult):
                self.updateNewsData(graphQLResult.data?.fetchNewsData?.compactMap({$0}) ?? [])
                dispatchGroup.leave()
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        }
        
        //Load Chart
        dispatchGroup.enter()
        Network.shared.apollo.fetch(query: DiscoverChartsQuery.init(period: chartRange.rawValue, symbol: symbol)){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                
                self?.updateChartData(graphQLResult.data?.fetchChartData?.compactMap({$0}) ?? [])
                dispatchGroup.leave()
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        }
        
        //Load Alt Stocks
        dispatchGroup.enter()
        Network.shared.apollo.fetch(query: SearchTickersQuery.init(text: "%Game%")){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                
                self?.altStocks = (graphQLResult.data?.tickers ?? []).prefix(20).filter({$0.symbol != self?.ticker.symbol})
                
                TickersLiveFetcher.shared.getSymbolsData(self?.altStocks.compactMap(\.symbol) ?? []) {
                    dispatchGroup.leave()
                }
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        }
        
        //Await for results
        dispatchGroup.notify(queue: queue) {
            DispatchQueue.main.async {
                completion()
            }
        }
        
    }
    
    /// Update Chart only
    func loadNewChartData(_ completion: ( () -> Void)? = nil) {
        Network.shared.apollo.fetch(query: DiscoverChartsQuery.init(period: chartRange.rawValue, symbol: symbol)){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                self?.updateChartData(graphQLResult.data?.fetchChartData?.compactMap({$0}) ?? [])
                completion?()
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                completion?()
                break
            }
        }
    }
    
    private func updateChartData(_ data: [DiscoverChartsQuery.Data.FetchChartDatum]) {
        self.chartData = data
        self.localChartData.loadValues(Array(data.suffix(30)), period: chartRange)
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
    struct MarketData {
        let name: String
        let period: String
        let value: String
    }
    
    let marketData: [MarketData]
    
    //MARK: - WSJ
    struct WSRData: Hashable {
        
        struct WSRDataDetails: Hashable {
            let name: String
            let count: Int
        }
        
        let rate: Double
        let analystsCount: Int
        let detailedStats: [WSRDataDetails]
    }
    
    let wsjData: WSRData
    
    //MARK: - Recommended
    let recommendedScore: Float
    
    //MARK: - News
    var news: [DiscoverNewsQuery.Data.FetchNewsDatum]
    
    //MARK: - Stocks
    var altStocks: [SearchTickersQuery.Data.Ticker]
    
    var tickersToCompare: [SearchTickersQuery.Data.Ticker] = []
    
    //MARK: - Upcoming events
    let upcomingEvents: [String]
}
