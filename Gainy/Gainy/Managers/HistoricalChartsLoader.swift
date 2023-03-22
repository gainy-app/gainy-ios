//
//  HistoricalChartsLoader.swift
//  Gainy
//
//  Created by Anton Gubarenko on 04.12.2021.
//

import SwiftDate
import GainyAPI

typealias PortofolioMetrics = GetPortfolioChartMetricsQuery.Data.GetPortfolioChartPreviousPeriodClose

extension PortofolioMetrics {
    func lastDayPrice(range: ScatterChartView.ChartPeriod) -> Double? {
        switch range {
        case .d1:
            return prevClose_1d
        case .m1:
            return prevClose_1m
        case .m3:
            return prevClose_3m
        case .w1:
            return prevClose_1w
        case .y1:
            return prevClose_1y
        case .y5:
            return prevClose_5y
        default:
            return prevClose_1d
        }
    }
}

struct PrevDayData {
    let d1: Float
    let w1: Float
    let m1: Float
    let m3: Float
    let y1: Float
    let y5: Float
    let all: Float
    
    init() {
        self.d1 = 0.0
        self.w1 = 0.0
        self.m1 = 0.0
        self.m3 = 0.0
        self.y1 = 0.0
        self.y5 = 0.0
        self.all = 0.0
    }
    
    func lastDayPrice(range: ScatterChartView.ChartPeriod) -> Float {
        switch range {
        case .d1:
            return d1
        case .m1:
            return m1
        case .m3:
            return m3
        case .w1:
            return w1
        case .y1:
            return y1
        case .y5:
            return y5
        case .all:
            return all
        }
    }
    
    init(portoMetrics: PortofolioMetrics) {
        self.d1 = Float(portoMetrics.prevClose_1d ?? 0.0)
        self.w1 = Float(portoMetrics.prevClose_1w ?? 0.0)
        self.m1 = Float(portoMetrics.prevClose_1m ?? 0.0)
        self.m3 = Float(portoMetrics.prevClose_3m ?? 0.0)
        self.y1 = Float(portoMetrics.prevClose_1y ?? 0.0)
        self.y5 = Float(portoMetrics.prevClose_5y ?? 0.0)
        self.all = 0.0
    }
    
    init(tickerMetrics: RemoteTicker.TickerMetric?) {
        self.d1 = tickerMetrics?.prevPrice_1d ?? 0.0
        self.w1 = tickerMetrics?.prevPrice_1w ?? 0.0
        self.m1 = tickerMetrics?.prevPrice_1m ?? 0.0
        self.m3 = tickerMetrics?.prevPrice_3m ?? 0.0
        self.y1 = tickerMetrics?.prevPrice_1y ?? 0.0
        self.y5 = tickerMetrics?.prevPrice_5y ?? 0.0
        self.all = tickerMetrics?.prevPriceAll ?? 0.0
    }
    
    init(ttfMetrics: RemoteCollectionDetails.Metric?) {
        self.d1 = ttfMetrics?.previousDayClosePrice ?? 0.0
        self.w1 = ttfMetrics?.prevValue_1w ?? 0.0
        self.m1 = ttfMetrics?.prevValue_1m ?? 0.0
        self.m3 = ttfMetrics?.prevValue_3m ?? 0.0
        self.y1 = ttfMetrics?.prevValue_1y ?? 0.0
        self.y5 = ttfMetrics?.prevValue_5y ?? 0.0
        self.all = ttfMetrics?.prevValueTotal ?? 0.0
    }
}

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
        print("Thread \(Thread.isMainThread) \(Date()) DiscoverChartsQuery start")
        Network.shared.apollo.fetch(query: DiscoverChartsQuery(period: periodString, symbol: symbol)) {result in
            print("Thread \(Thread.isMainThread) \(Date()) DiscoverChartsQuery done")
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
    func loadPlaidPortfolioChart(profileID: Int, range: ScatterChartView.ChartPeriod, settings: PortfolioSettings, interestsCount: Int , categoriesCount: Int, isDemo: Bool,  completion: @escaping ([ChartNormalized]) -> Void) {
        
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
        
//        let securityTypes = settings.securityTypes.compactMap({$0.title})
        
        var accountIds = UserProfileManager.shared.linkedBrokerAccounts.compactMap({$0.id})
        let disabledAccounts = settings.disabledAccounts.compactMap({$0.id})
        accountIds = accountIds.filter({!disabledAccounts.contains($0)})
        
        //let institutionIDs = UserProfileManager.shared.linkedBrokerAccounts.compactMap({$0.institutionID})
        
        dprint("GetPortfolioChartsQuery profile: \(profileID) period: \(periodString) inter: \(intersIDs) send: \(String(describing: intersIDs.count == interestsCount || intersIDs.isEmpty ? nil : intersIDs)) accessTokenIds: \(accountIds) cats: \(catsIDs)) send: \(String(describing: catsIDs.count == categoriesCount || catsIDs.isEmpty ? nil : catsIDs)) ltt: \(settings.onlyLongCapitalGainTax)")
        Network.shared.apollo.fetch(query: GetPortfolioChartsQuery.init(profileId: profileID,
                                                                        periods: [periodString],
                                                                        broker_ids: nil,
                                                                        interestIds: intersIDs.count == interestsCount || intersIDs.isEmpty ? nil : intersIDs,
                                                                        categoryIds: catsIDs.count == categoriesCount || catsIDs.isEmpty ? nil : catsIDs,
                                                                        lttOnly: settings.onlyLongCapitalGainTax,
                                                                        securityTypes: nil)) { result in
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
    
    func loadPlaidPortfolioChartMetrics(profileID: Int, settings: PortfolioSettings, interestsCount: Int , categoriesCount: Int, isDemo: Bool, completion: @escaping (PortofolioMetrics?) -> Void) {
        let intersIDs = settings.interests.filter { item in
            item.selected
        }.compactMap({$0.id})
        
        let catsIDs = settings.categories.filter { item in
            item.selected
        }.compactMap({$0.id})
        
        var accountIds = UserProfileManager.shared.linkedBrokerAccounts.compactMap({$0.id})
        let disabledAccounts = settings.disabledAccounts.compactMap({$0.id})
        accountIds = accountIds.filter({!disabledAccounts.contains($0)})
        
        //let institutionIDs = UserProfileManager.shared.linkedBrokerAccounts.compactMap({$0.institutionID})
        
        dprint("GetPortfolioChartMetricsQuery profile: \(profileID) inter: \(intersIDs) send: \(String(describing: intersIDs.count == interestsCount || intersIDs.isEmpty ? nil : intersIDs)) accessTokenIds: \(accountIds) cats: \(catsIDs)) send: \(String(describing: catsIDs.count == categoriesCount || catsIDs.isEmpty ? nil : catsIDs)) ltt: \(settings.onlyLongCapitalGainTax)")
        Network.shared.apollo.fetch(query: GetPortfolioChartMetricsQuery.init(profileId: profileID,
                                                                        interestIds: intersIDs.count == interestsCount || intersIDs.isEmpty ? nil : intersIDs,
                                                                        accountIds: nil,
                                                                        categoryIds: catsIDs.count == categoriesCount || catsIDs.isEmpty ? nil : catsIDs,
                                                                        lttOnly: settings.onlyLongCapitalGainTax,
                                                                        securityTypes: nil)) { result in
            switch result {
            case .success(let graphQLResult):
                if let fetchedData = graphQLResult.data?.getPortfolioChartPreviousPeriodClose {
                    completion(fetchedData)
                } else {
                    completion(nil)
                }
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion(nil)
                break
            }
        }
    }
}
