//
//  DemoUserContainer.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

final class DemoUserContainer {
    
    static let shared = DemoUserContainer()
    
    let porfileID: Int = 4
    
    @UserDefaultArray<Int>(key: Constants.UserDefaults.favKey)
    var favoriteCollections: [Int]
    
    
}
