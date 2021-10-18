//
//  APIModels+Caching.swift
//  Gainy
//
//  Created by Anton Gubarenko on 14.10.2021.
//

import UIKit

extension Array where Element == RemoteCollectionDetails {
    mutating func swapIDs(_ firstId: Int, _ secondId: Int) {
        if let index1 = self.firstIndex(where: {$0.id == firstId}), let index2 = self.firstIndex(where: {$0.id == secondId}) {
            self.swapAt(index1, index2)
        }
    }
}

extension Array where Element == CollectionDetailViewCellModel {
    mutating func swapIDs(_ firstId: Int, _ secondId: Int) {
        if let index1 = self.firstIndex(where: {$0.id == firstId}), let index2 = self.firstIndex(where: {$0.id == secondId}) {
            self.swapAt(index1, index2)
        }
    }
}
