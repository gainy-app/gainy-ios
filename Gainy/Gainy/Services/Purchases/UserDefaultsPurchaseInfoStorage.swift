//
//  UserDefaultsPurchaseInfoStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import UIKit
import OneSignal

class UserDefaultsPurchaseInfoStorage: PurchaseInfoStorageProtocol {
    
    var collectionViewLimit: Int {
        3
    }
    
    @UserDefaultArray(key: "Purchases.viewedCollections")
    private var viewedCollections: [Int]
    
    
    func getViewedCollections() {
        OneSignal.getTags({[weak self] tags in
            for tag in (tags ?? [:]) {
                print(tag)
            }
            self?.viewedCollections  = []
        }, onFailure: { error in
            dprint("Error getting tags - \(error?.localizedDescription)")
        })
    }
    
    func isViewedCollection(_ colId: Int) -> Bool {
        viewedCollections.contains(colId)
    }
    
    func viewCollection(_ colId: Int) -> Bool {
        guard viewedCollections.count < collectionViewLimit else {return false}
        if !viewedCollections.contains(colId) {
            viewedCollections.append(colId)
            OneSignal.sendTag("Purchases.viewedCollections", value: viewedCollections.compactMap({String($0)}).joined())
        }
        return true
    }
    
}
