//
//  TickerDetailsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

/// Ticker model to pupulate cells
typealias RemoteTicker = DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker
class TickerInfo {
    
    let ticker: RemoteTicker
    
    init(ticker: RemoteTicker) {
        self.ticker = ticker
        
        self.name = ticker.name ?? ""
        self.symbol = ticker.symbol ?? ""
        self.about = String((ticker.description ?? "").dropFirst().dropLast())
        self.aboutShort = self.about.count < debugStr.count ? self.about : String(self.about.prefix(debugStr.count)) + "..."
        
        self.tags = ["DIVIDEND", "GAMING"] //needed
        self.highlights = ["Industry has a huge upside with WFH. Dividend yeild and growth 2x faster industry.", "High growth potential. Dividend yeild and growth 2x faster industry."] //needed
        
        self.marketData = [MarketData.init(name: "📌 Growth rate CAGR", period: "ANNUAL", value: ticker.tickerFinancials.last!.dividentGrowth ?? 0.0),
                           MarketData.init(name: "📌 EV/S", period: "ANNUAL", value: 14.5),
                           MarketData.init(name: "📌 Market Capitalization", period: "ANNUAL", value: ticker.tickerFinancials.last!.marketCapitalization ?? 0.0),
                           MarketData.init(name: "📌 Month to day", period: "ANNUAL", value: 14.5),
                           MarketData.init(name: "📌 Net Profit Margin", period: "ANNUAL", value: 150.6)] //needed
        
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
        let value: Double
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
    let altStocks: [CollectionCardViewCellModel]
    
    //MARK: - Upcoming events
    let upcomingEvents: [String]
}

final class TickerDetailsViewModel: NSObject, CardDetailsViewModelProtocol {
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
        self.dataSource = TickerDetailsDataSource(ticker: ticker)
    }

    let ticker: TickerInfo
    
    let dataSource: TickerDetailsDataSource
}


