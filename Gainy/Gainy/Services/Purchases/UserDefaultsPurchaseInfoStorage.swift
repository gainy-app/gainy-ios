//
//  UserDefaultsPurchaseInfoStorage.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.05.2022.
//

import Foundation

struct UserDefaultsPurchaseInfoStorage: PurchaseInfoStorageProtocol {
    var collectionViewLimit: Int {
        3
    }
    
    func getCollectionViewCount(profileId: Int) -> Int {
        UserDefaults.standard.integer(forKey: "profile_limit_\(profileId)")
    }
    
    func setCollectionViewCount(profileId: Int, amount: Int) {
        UserDefaults.standard.set(max(0, amount), forKey: "profile_limit_\(profileId)")
    }
    
}
