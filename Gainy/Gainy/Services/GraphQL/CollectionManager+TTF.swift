//
//  CollectionManager+TTF.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.04.2022.
//

import UIKit

typealias PieChartData = GetTtfPieChartQuery.Data.CollectionPiechart

extension CollectionsManager {
    func populateTTFCard(uniqID: String, _ completion: @escaping (String, [[ChartNormalized]], [GetTtfPieChartQuery.Data.CollectionPiechart], [TickerTag]) -> Void) {
        
        Task {
        //Load D1 Top
            async let allTopCharts = loadChartsForRange(uniqID: uniqID, range: .d1)
            
        //Load Pie - category
        
            async let pieChart = loadPieChart(uniqID: uniqID)
        //Load Rec Tags
            async let recTags = loadRecTags(uniqID: uniqID)
            
            let allInfo = await (allTopCharts, pieChart, recTags)
            
            await MainActor.run {
                completion(uniqID, allInfo.0, allInfo.1, allInfo.2)
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
                        continuation.resume(returning: tags)
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
                            continuation.resume(returning: fetchedData)
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
    
}
