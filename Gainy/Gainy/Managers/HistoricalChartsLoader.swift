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
            periodString = "1d"
        case .w1:
            dateString = (Date().startOfTradingDay - 1.weeks).toFormat(backTimeFormat)
            periodString = "1w"
        case .m1:
            dateString = (Date().startOfTradingDay - 1.months).toFormat(backTimeFormat)
            periodString = "1m"
        case .m3:
            dateString = (Date().startOfTradingDay - 3.months).toFormat(backTimeFormat)
            periodString = "3m"
        case .y1:
            dateString = (Date().startOfTradingDay - 1.years).toFormat(backTimeFormat)
            periodString = "1y"
        case .y5:
            dateString = (Date().startOfTradingDay - 5.years).toFormat(backTimeFormat)
            periodString = "5y"
        case .all:
            dateString = "1900-01-01"
            periodString = "all"
        }
        Network.shared.apollo.fetch(query: DiscoverChartsQuery(period: periodString, symbol: symbol)) {result in
            switch result {
            case .success(let graphQLResult):
                if var fetchedData = graphQLResult.data?.chart.filter({$0.close != nil}) {
                    if range == .d1 && fetchedData.count == 2 {
                        if let firstData = fetchedData.first {
                            fetchedData.insert(DiscoverChartsQuery.Data.Chart(symbol: firstData.symbol,
                                                                              datetime: firstData.datetime,
                                                                              period: firstData.period,
                                                                              open: firstData.open,
                                                                              high: firstData.high,
                                                                              low: firstData.low,
                                                                              close: firstData.close,
                                                                              adjustedClose: firstData.open,
                                                                              volume: firstData.volume), at: 0)
                        }
                    }
                    completion(ChartData.init(points: fetchedData, period: range), fetchedData)
                } else {
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
    func loadPlaidPortfolioChart(profileID: Int, range: ScatterChartView.ChartPeriod, settings: PortfolioSettings, interestsCount: Int , categoriesCount: Int,  completion: @escaping ([ChartNormalized]) -> Void) {
        
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
            periodString = "1d"
        case .w1:
            dateString = (Date().startOfTradingDay - 1.weeks).toFormat(backTimeFormat)
            periodString = "1w"
        case .m1:
            dateString = (Date().startOfTradingDay - 1.months).toFormat(backTimeFormat)
            periodString = "1m"
        case .m3:
            dateString = (Date().startOfTradingDay - 3.months).toFormat(backTimeFormat)
            periodString = "3m"
        case .y1:
            dateString = (Date().startOfTradingDay - 1.years).toFormat(backTimeFormat)
            periodString = "1y"
        case .y5:
            dateString = (Date().startOfTradingDay - 5.years).toFormat(backTimeFormat)
            periodString = "5y"
        case .all:
            dateString = "1900-01-01"
            periodString = "all"
        }
        dprint("GetPortfolioChartsQuery start")
                
        let intersIDs = settings.interests.filter { item in
            item.selected
        }.compactMap({$0.id})
        
        let catsIDs = settings.categories.filter { item in
            item.selected
        }.compactMap({$0.id})
        
        let securityTypes = settings.securityTypes.filter { item in
            item.selected
        }.compactMap({$0.title})
        
        var accountIds = UserProfileManager.shared.linkedPlaidAccounts.compactMap({$0.id})
        let disabledAccounts = settings.disabledAccounts.compactMap({$0.id})
        accountIds = accountIds.filter({!disabledAccounts.contains($0)})
        
        dprint("GetPortfolioChartsQuery profile: \(profileID) period: \(periodString) inter: \(intersIDs) send: \(String(describing: intersIDs.count == interestsCount || intersIDs.isEmpty ? nil : intersIDs)) accs: \(accountIds) cats: \(catsIDs)) send: \(String(describing: catsIDs.count == categoriesCount || catsIDs.isEmpty ? nil : catsIDs)) ltt: \(settings.onlyLongCapitalGainTax) secs: \(securityTypes)")
        Network.shared.apollo.fetch(query: GetPortfolioChartsQuery.init(profileId: profileID,
                                                                        periods: [periodString],
                                                                        interestIds: intersIDs.count == interestsCount || intersIDs.isEmpty ? nil : intersIDs,
                                                                        accountIds: accountIds,
                                                                        categoryIds: catsIDs.count == categoriesCount || catsIDs.isEmpty ? nil : catsIDs,
                                                                        institutionIds: nil,
                                                                        lttOnly: settings.onlyLongCapitalGainTax,
                                                                        securityTypes: securityTypes)) { result in
            switch result {
            case .success(let graphQLResult):
                if var fetchedData = graphQLResult.data?.getPortfolioChart?.filter({$0?.adjustedClose != nil}).compactMap({$0}) {
                    dprint("GetPortfolioChartsQuery min: \(String(describing: fetchedData.min(by: {($0.adjustedClose ?? 0.0) < ($1.adjustedClose ?? 0.0)})))")
                    dprint("GetPortfolioChartsQuery max: \(String(describing: fetchedData.max(by: {($0.adjustedClose ?? 0.0) < ($1.adjustedClose ?? 0.0)})))")
                    if range == .d1 {
                        if let lastDay = fetchedData.last {
                            let filtered = fetchedData.filter({$0.date.compare(toDate: lastDay.date, granularity: .day) == .orderedSame})
                            fetchedData = filtered
                        }
                    }
                    
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
