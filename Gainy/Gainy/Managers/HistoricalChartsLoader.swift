//
//  HistoricalChartsLoader.swift
//  Gainy
//
//  Created by Anton Gubarenko on 04.12.2021.
//

import SwiftDate

/// Charts loader helper
final class HistoricalChartsLoader {
    
    static let shared = HistoricalChartsLoader()
    
    /// Load charts data using new endpoint
    /// - Parameters:
    ///   - symbol: Stock symbol
    ///   - range: Chart range
    ///   - completion: response clouser with ChartData
    func loadChart(symbol: String, range: ScatterChartView.ChartPeriod, completion: @escaping (ChartData, [RemoteChartData]) -> Void) {
        
        var dateString = ""
        var periodString = ""
        
        switch range {
        case .d1:
            dateString = (Date().startOfDay - 7.days).toFormat("yyyy-MM-dd")
            periodString = "15min"
        case .w1:
            dateString = (Date().startOfDay - 1.weeks).toFormat("yyyy-MM-dd")
            periodString = "1d"
        case .m1:
            dateString = (Date().startOfDay - 1.months).toFormat("yyyy-MM-dd")
            periodString = "1d"
        case .m3:
            dateString = (Date().startOfDay - 3.months).toFormat("yyyy-MM-dd")
            periodString = "1w"
        case .y1:
            dateString = (Date().startOfDay - 1.years).toFormat("yyyy-MM-dd")
            periodString = "1w"
        case .y5:
            dateString = (Date().startOfDay - 5.years).toFormat("yyyy-MM-dd")
            periodString = "1m"
        case .all:
            dateString = "1900-01-01"
            periodString = "1m"
        }
        Network.shared.apollo.fetch(query: DiscoverChartsQuery(period: periodString, symbol: symbol, date: dateString) ){result in
            switch result {
            case .success(let graphQLResult):
                if var fetchedData = graphQLResult.data?.historicalPricesAggregated.filter({$0.close != nil}) {
                    
                    if range == .d1 {
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
                    }
                    
                    completion(ChartData.init(points: fetchedData, period: range), fetchedData)
                } else {
                    completion(ChartData.init(points: [0.0]), [])
                }
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion(ChartData.init(points: [0.0]), [])
                break
            }
        }
    }
    
    /// Load charts data using new endpoint for Plaid
    /// - Parameters:
    ///   - profileID: User Profile ID
    ///   - range: Chart range
    ///   - completion: response clouser with ChartData
    func loadPlaidPortfolioChart(profileID: Int, range: ScatterChartView.ChartPeriod, completion: @escaping (ChartData) -> Void) {
        
        var dateString = ""
        var periodString = ""
        
        switch range {
        case .d1:
            dateString = (Date().startOfDay - 1.days).toFormat("yyyy-MM-dd")
            periodString = "15min"
        case .w1:
            dateString = (Date().startOfDay - 1.weeks).toFormat("yyyy-MM-dd")
            periodString = "1d"
        case .m1:
            dateString = (Date().startOfDay - 1.months).toFormat("yyyy-MM-dd")
            periodString = "1d"
        case .m3:
            dateString = (Date().startOfDay - 3.months).toFormat("yyyy-MM-dd")
            periodString = "1w"
        case .y1:
            dateString = (Date().startOfDay - 1.years).toFormat("yyyy-MM-dd")
            periodString = "1w"
        case .y5:
            dateString = (Date().startOfDay - 5.years).toFormat("yyyy-MM-dd")
            periodString = "1m"
        case .all:
            dateString = "1900-01-01"
            periodString = "1m"
        }
        Network.shared.apollo.fetch(query: GetPortfolioChartsQuery.init(profileID: profileID, period: periodString, date: dateString) ){result in
            switch result {
            case .success(let graphQLResult):
                if var fetchedData = graphQLResult.data?.portfolioChart.filter({$0.value != nil}) {
                    
                    if range == .d1 {
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
                    }
                    
                    completion(ChartData.init(points: fetchedData, period: range))
                } else {
                    completion(ChartData.init(points: [0.0]))
                }
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion(ChartData.init(points: [0.0]))
                break
            }
        }
    }
}
