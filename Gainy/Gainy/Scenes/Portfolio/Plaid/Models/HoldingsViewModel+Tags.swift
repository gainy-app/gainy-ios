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
    
    func tickerTag() -> TickerTag {
        TickerTag(name: name,
                  url: url,
                  collectionID: collectionId,
                  id: id)
    }
}

protocol TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer]
}

extension RemoteTickerDetailsFull.TickerIndustry : TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer] {
        [UnifiedTagContainer.init(id: gainyIndustry?.id ?? -1,
                                 name: gainyIndustry?.name ?? "",
                                 url: "",
                                 collectionId: gainyIndustry?.collectionId ?? -404)]
    }
}

extension RemoteTickerDetailsFull.TickerCategory : TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer] {
        [UnifiedTagContainer.init(id: categories?.id ?? -1,
                                 name: categories?.name ?? "",
                                 url: categories?.iconUrl ?? "",
                                 collectionId: categories?.collectionId ?? -404)]
    }
}


extension GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Tag : TagUnifiable {
    func toUnifiedContainers() -> [UnifiedTagContainer] {
        var res = [UnifiedTagContainer]()
        
        if let interest = interest {
            res.append(UnifiedTagContainer.init(id: interest.id,
                                                name: interest.name ?? "",
                                                url: interest.iconUrl ?? "",
                                                collectionId: collection?.id ?? Constants.CollectionDetails.noCollectionId) )
        }
        
        if let category = category {
            res.append(UnifiedTagContainer.init(id: category.id,
                                                name: category.name ?? "",
                                                 url: category.iconUrl ?? "",
                                                collectionId: collection?.id ?? Constants.CollectionDetails.noCollectionId
                                                 ) )
        }
        
        return res
    }
}
