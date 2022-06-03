//
//  PurchaseInfoStorageProtocol.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation
import Combine

/// Protocol to store/save limits usage
protocol PurchaseInfoStorageProtocol {
    var collectionViewLimit: Int {get}
    
    func getViewedCollections()
    var viewedCount: Int {get}
    func isViewedCollection(_ colId: Int) -> Bool
    func viewCollection(_ colId: Int) -> Bool
    
    var collectionsViewedPublisher: AnyPublisher<Int, Never> {get}
}
