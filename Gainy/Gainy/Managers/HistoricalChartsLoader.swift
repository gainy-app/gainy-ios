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
    
    //9.30 un-US -5:00
    
    let backTimeFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    /// Load charts data using new endpoint
    /// - Parameters:
    ///   - symbol: Stock symbol
    ///   - range: Chart range
    ///   - completion: response clouser with ChartData
    func loadChart(symbol: String, range: ScatterChartView.ChartPeriod, completion: @escaping (ChartData, [ChartNormalized]) -> Void) {
        
        var dateString = ""
        var periodString = ""
        
        switch range {
        case .d1:
            let weekDay = Date().toFormat("ccc", locale: Locale.init(identifier: "en_US"))
            var daysToTake = 2
            if weekDay == "Mon" {
                daysToTake = 4
            }
            
            dateString = (Date().startOfTradingDay - daysToTake.days).toFormat(backTimeFormat)
            periodString = "15min"
        case .w1:
            dateString = (Date().startOfTradingDay - 1.weeks).toFormat(backTimeFormat)
            periodString = "1d"
        case .m1:
            dateString = (Date().startOfTradingDay - 1.months).toFormat(backTimeFormat)
            periodString = "1d"
        case .m3:
            dateString = (Date().startOfTradingDay - 3.months).toFormat(backTimeFormat)
            periodString = "1w"
        case .y1:
            dateString = (Date().startOfTradingDay - 1.years).toFormat(backTimeFormat)
            periodString = "1w"
        case .y5:
            dateString = (Date().startOfTradingDay - 5.years).toFormat(backTimeFormat)
            periodString = "1m"
        case .all:
            dateString = "1900-01-01"
            periodString = "1m"
        }
        Network.shared.apollo.fetch(query: DiscoverChartsQuery(period: periodString, symbol: symbol, dateG: dateString, dateL: (Date()).toFormat(backTimeFormat))) {result in
            switch result {
            case .success(let graphQLResult):
                if var fetchedData = graphQLResult.data?.historicalPricesAggregated.filter({$0.close != nil}) {
                    print("CG \(range) : \(fetchedData.count)")
                    
                    if range == .d1 {
                        print("CG")
                    }
                    completion(ChartData.init(points: fetchedData, period: range), fetchedData)
                } else {
                    print("CG \(range) : \(0)")
                    completion(ChartData.init(points: [0.0]), [])
                }
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(range) \(error)")
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
    func loadPlaidPortfolioChart(profileID: Int, range: ScatterChartView.ChartPeriod, completion: @escaping ([ChartNormalized]) -> Void) {
        
        var dateString = ""
        var periodString = ""
        
        switch range {
        case .d1:
            let weekDay = Date().toFormat("ccc", locale: Locale.init(identifier: "en_US"))
            var daysToTake = 2
            if weekDay == "Mon" {
                daysToTake = 4
            }
            
            dateString = (Date().startOfTradingDay - daysToTake.days).toFormat(backTimeFormat)
            periodString = "15min"
        case .w1:
            dateString = (Date().startOfTradingDay - 1.weeks).toFormat(backTimeFormat)
            periodString = "1d"
        case .m1:
            dateString = (Date().startOfTradingDay - 1.months).toFormat(backTimeFormat)
            periodString = "1d"
        case .m3:
            dateString = (Date().startOfTradingDay - 3.months).toFormat(backTimeFormat)
            periodString = "1w"
        case .y1:
            dateString = (Date().startOfTradingDay - 1.years).toFormat(backTimeFormat)
            periodString = "1w"
        case .y5:
            dateString = (Date().startOfTradingDay - 5.years).toFormat(backTimeFormat)
            periodString = "1m"
        case .all:
            dateString = "1900-01-01"
            periodString = "1m"
        }
        Network.shared.apollo.fetch(query: GetPortfolioChartsQuery.init(profileID: profileID, period: periodString, dateG: dateString, dateL: (Date()).toFormat(backTimeFormat))) {result in
            switch result {
            case .success(let graphQLResult):
                if let fetchedData = graphQLResult.data?.portfolioChart.filter({$0.value != nil}) {
                    completion(fetchedData)
                } else {
                    completion([])
                }
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion([])
                break
            }
        }
    }
}
