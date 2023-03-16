//
//  HomeCollectionContainer.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.03.2023.
//

import Foundation
import GainyAPI

struct HomeCollectionContainer {
    let collection: RemoteShortCollectionDetails
    let gains: TTFStatus?
    
    var id: Int? {
        collection.id
    }
}

extension HomeCollectionContainer: Reorderable {
    typealias OrderElement = Int
    var orderElement: OrderElement {
        self.collection.orderElement
    }
}
