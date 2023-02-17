//
//  HoldingPieChartNetworking.swift
//  Gainy
//
//  Created by r10 on 15.02.2023.
//

import GainyCommon
import GainyAPI
import Apollo

class HoldingPieChartNetworking {
    
    private let network = Network.shared
    
    func loadPieFilters(profileID: Int, selectedInterests: [Int], selectedCategories: [Int]) async throws -> (interests: [InfoDataSource], categories: [InfoDataSource], brokers: [PlaidAccountData]) {
        let query = GetPortfolioPieFiltersQuery(profileId: profileID)
        
        return try await withCheckedThrowingContinuation { continuation in
            network.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let interests = graphQLResult.data?.portfolioInterests.compactMap({ interest in
                        InfoDataSource(type: .Interst, id: interest.interest?.id ?? 0, title: interest.interest?.name ?? "", iconURL: "", selected: selectedInterests.contains(where: { $0 == (interest.interest?.id ?? 0) }))}),
                    let categories = graphQLResult.data?.portfolioCategories.compactMap({ category in
                        InfoDataSource(type: .Category, id: category.category?.id ?? 0, title: category.category?.name ?? "", iconURL: "", selected: selectedCategories.contains(where: { $0 == (category.category?.id ?? 0) }))}) else {
                            continuation.resume(throwing: GainyAPIError.noData)
                            return
                        }
                    
                    guard let brokers = graphQLResult.data?.profileBrokers.compactMap({ broker in
                        PlaidAccountData(id: 0, institutionID: 0, name: broker.broker?.name ?? "", needReauthSince: nil, brokerName: nil, brokerUniqId: broker.broker?.uniqId ?? "0")
                    }) else {
                        continuation.resume(throwing: GainyAPIError.noData)
                        return
                    }
                    continuation.resume(returning: (interests: interests, categories: categories, brokers: brokers))
                case .failure(let error):
                    continuation.resume(throwing: GainyAPIError.loadError(error))
                }
            }
        }
    }
    
    func loadChartData(profileID: Int, brokerIds: [String]?, interestIds: [Int?]?, categoryIds: [Int?]?) async throws -> [PieChartData] {
        
        let query = GetPortfolioPieChartQuery.init(profileId: profileID,
                                                   brokerIds: brokerIds,
                                                   interestIds: interestIds,
                                                   categoryIds: categoryIds)
        
        return try await withCheckedThrowingContinuation { continuation in
            network.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let fetchedData = graphQLResult.data?.getPortfolioPiechart else {
                        continuation.resume(throwing: GainyAPIError.noData)
                        return
                    }
                    let data = fetchedData.compactMap({ item -> PieChartData? in
                        
                        if let item = item {
                            let weight = (item.weight != nil) ? float8(item.weight!) : nil
                            let relativeDailyChange = (item.relativeDailyChange != nil) ? float8(item.relativeDailyChange!) : float8(0)
                            let absoluteValue = (item.absoluteValue != nil) ? float8(item.absoluteValue!) : nil
                            let absoluteDailyChange = (item.absoluteDailyChange != nil) ? float8(item.absoluteDailyChange!) : nil
                            return PieChartData.init(weight: weight,
                                                     entityType: item.entityType,
                                                     relativeDailyChange: relativeDailyChange,
                                                     entityName: item.entityName,
                                                     entityId: item.entityId,
                                                     absoluteValue: absoluteValue,
                                                     absoluteDailyChange: absoluteDailyChange)
                        }
                        return nil
                    })
                    let interests = data.filter({$0.entityType == "interest"}).compactMap({InfoDataSource.init(type: .Interst, id: Int($0.entityId ?? "") ?? 0,  title:$0.entityName ?? "", iconURL:"", selected: false)})
                    print("INTERESTSCHART: \(interests.map({ return "ID:\($0.id), TITLE: \($0.title)"}))")
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: GainyAPIError.loadError(error))
                }
            }
        }
    }
}
