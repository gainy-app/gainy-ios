//
//  PurchaseInfoStorageProtocol.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation

/// Protocol to store/save limits usage
protocol PurchaseInfoStorageProtocol {
    var collectionViewLimit: Int {get}
    
    func viewedCollections() -> [Int]
    func viewCollection(colId: Int) -> Bool
}
