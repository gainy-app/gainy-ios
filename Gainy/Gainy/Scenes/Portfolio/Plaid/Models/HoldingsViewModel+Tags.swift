//
//  HoldingsViewModel+Tags.swift
//  Gainy
//
//  Created by Anton Gubarenko on 29.07.2022.
//

import UIKit

//MARK: - Unified Tag container

public struct UnifiedTagContainer {
    let id: Int
    let name: String
    let url: String
    let collectionId: Int
    let type: TagType
    
    enum TagType {
        case interest, industry, category, ttf
    }
    
    func tickerTag() -> TickerTag {
        TickerTag(name: name,
                  url: url,
                  collectionID: collectionId,
                  id: id)
    }
}

extension UnifiedTagContainer: Hashable {
    public static func == (lhs: UnifiedTagContainer, rhs: UnifiedTagContainer) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.name)
    }
}

protocol TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer]
}

extension RemoteTickerDetailsFull.TickerInterest : TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer] {
        [UnifiedTagContainer.init(id: interest?.id ?? -1,
                                 name: interest?.name ?? "",
                                  url: interest?.iconUrl ?? "",
                                 collectionId: Constants.CollectionDetails.noCollectionId,
                                  type: .interest)]
    }
}

extension RemoteTickerDetailsFull.TickerIndustry : TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer] {
        [UnifiedTagContainer.init(id: gainyIndustry?.id ?? -1,
                                 name: gainyIndustry?.name ?? "",
                                 url: "",
                                 collectionId: gainyIndustry?.collectionId ?? Constants.CollectionDetails.noCollectionId,
                                  type: .industry)]
    }
}

extension RemoteTickerDetailsFull.TickerCategory : TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer] {
        [UnifiedTagContainer.init(id: categories?.id ?? -1,
                                 name: categories?.name ?? "",
                                 url: categories?.iconUrl ?? "",
                                 collectionId: categories?.collectionId ?? Constants.CollectionDetails.noCollectionId,
                                  type: .category)]
    }
}


//extension GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Tag : TagUnifiable {
//    func toUnifiedContainers() -> [UnifiedTagContainer] {
//        var res = [UnifiedTagContainer]()
//        
////        if let interest = interest {
////            res.append(UnifiedTagContainer.init(id: interest.id,
////                                                name: interest.name ?? "",
////                                                url: interest.iconUrl ?? "",
////                                                collectionId: collection?.id ?? Constants.CollectionDetails.noCollectionId,
////                                                type: .interest) )
////        }
////
////        if let category = category {
////            res.append(UnifiedTagContainer.init(id: category.id,
////                                                name: category.name ?? "",
////                                                 url: category.iconUrl ?? "",
////                                                collectionId: collection?.id ?? Constants.CollectionDetails.noCollectionId,
////                                                type: .category
////                                                 ) )
////        }
//        
//        return res
//    }
//}
