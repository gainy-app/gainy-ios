//
//  UserDefaultsPurchaseInfoStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation

class UserDefaultsPurchaseInfoStorage: PurchaseInfoStorageProtocol {
    
    var collectionViewLimit: Int {
        3
    }
    
    @UserDefaultArray(key: "Purchases.viewedCollections")
    private var viewedCollections: [Int]
    
    
    func isViewedCollection(_ colId: Int) -> Bool {
        viewedCollections.contains(colId)
    }
    
    func viewCollection(_ colId: Int) -> Bool {
        guard viewedCollections.count < collectionViewLimit else {return false}
        if !viewedCollections.contains(colId) {
            viewedCollections.append(colId)
        }
        return true
    }
    
}
