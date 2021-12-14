//
//  Array-Reorder.swift
//  Gainy
//
//  Created by Anton Gubarenko on 29.09.2021.
//

import Foundation

protocol Reorderable {
    associatedtype OrderElement: Equatable
    var orderElement: OrderElement { get }
}

extension Array where Element: Reorderable {
    
    func reorder(by preferredOrder: [Element.OrderElement]) -> [Element] {
        sorted {
            guard let first = preferredOrder.firstIndex(of: $0.orderElement) else {
                return false
            }
            
            guard let second = preferredOrder.firstIndex(of: $1.orderElement) else {
                return true
            }
            
            return first < second
        }
    }
}

extension Int: Reorderable {
    typealias OrderElement = Int
    var orderElement: OrderElement { self }
}

extension Array {
    func uniqueUsingKey<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}

extension Array where Element: Hashable {
    func uniqued() -> Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}

extension Array where Element == HoldingViewModel {
    func sortedAndFilter(by settings: PortfolioSettings) -> [Element] {
        
        //Sortings
        let sortingField: PortfolioSortingField = settings.sorting
        let ascending: Bool = settings.ascending
        let dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        
        //Filters
        return self.sorted { lhs, rhs in
            switch sortingField {
            case .purchasedDate:
                guard let lhd = lhs.holdingDetails, let rhd = rhs.holdingDetails else {
                    return false
                }

                if ascending {
                    return (lhd.purchaseDate ?? "").toDate(dateFormat)?.date ?? Date() < (rhd.purchaseDate ?? "").toDate(dateFormat)?.date ?? Date()
                } else {
                    return (lhd.purchaseDate ?? "").toDate(dateFormat)?.date ?? Date() > (rhd.purchaseDate ?? "").toDate(dateFormat)?.date ?? Date()
                }
            case .totalReturn:
                guard let lhd = lhs.holdingDetails, let rhd = rhs.holdingDetails else {
                    return false
                }

                if ascending {
                    return lhd.relativeGainTotal ?? 0 < rhd.relativeGainTotal ?? 0
                } else {
                    return lhd.relativeGainTotal ?? 0 > rhd.relativeGainTotal ?? 0
                }
                
            case .todayReturn:
                guard let lhd = lhs.holdingDetails, let rhd = rhs.holdingDetails else {
                    return false
                }
                if ascending {
                    return lhd.relativeGain_1d ?? 0 < rhd.relativeGain_1d ?? 0
                } else {
                    return lhd.relativeGain_1d ?? 0 > rhd.relativeGain_1d ?? 0
                }
            case .percentOFPortfolio:
                if ascending {
                    return lhs.percentInProfile < rhs.percentInProfile
                } else {
                    return lhs.percentInProfile > rhs.percentInProfile
                }
                
            case .matchScore:
                if ascending {
                    return lhs.matchScore < rhs.matchScore
                } else {
                    return lhs.matchScore > rhs.matchScore
                }
                
            case .name:
                if ascending {
                    return lhs.name < rhs.name
                } else {
                    return lhs.name > rhs.name
                }
                
            case .marketCap:
                guard let lhd = lhs.holdingDetails, let rhd = rhs.holdingDetails else {
                    return false
                }

                if ascending {
                    return lhd.marketCapitalization ?? 0 < rhd.marketCapitalization ?? 0
                } else {
                    return lhd.marketCapitalization ?? 0 > rhd.marketCapitalization ?? 0
                }
                
            case .earningsDate:
                guard let lhd = lhs.holdingDetails, let rhd = rhs.holdingDetails else {
                    return false
                }

                if ascending {
                    return (lhd.nextEarningsDate ?? "").toDate(dateFormat)?.date ?? Date() < (rhd.nextEarningsDate ?? "").toDate(dateFormat)?.date ?? Date()
                } else {
                    return (lhd.nextEarningsDate ?? "").toDate(dateFormat)?.date ?? Date() > (rhd.nextEarningsDate ?? "").toDate(dateFormat)?.date ?? Date()
                }
            }
        }.filter { model in
            
            //TO-DO: Serhii plz check this
            let notInAccount = settings.disabledAccounts.contains(where: {model.accountIds.contains($0.id)})
            
            let inInterests = model.tickerInterests.contains { item in
                return settings.interests.contains { dataSource in
                    dataSource.selected && item == dataSource.id
                }
            }
            
            let inCats = model.tickerCategories.contains { item in
                return settings.categories.contains { dataSource in
                    dataSource.selected && item == dataSource.id
                }
            }
            
            //TO-DO: Serhii plz check this
            var inSec = false
            let modelSecs = model.securityTypes
            inSec = Set(settings.securityTypes.filter({$0.selected}).compactMap({$0.title})).union(Set(modelSecs)).count > 0
            
            let isLTT = settings.onlyLongCapitalGainTax ? model.showLTT : true
            
            return !notInAccount && (inInterests || inCats || inSec) && isLTT
        }
    }
}
