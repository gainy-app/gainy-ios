//
//  DemoUserContainer.swift
//  Gainy
//
//  Created by Anton Gubarenko on 28.09.2021.
//

import UIKit

final class DemoUserContainer {
        
    static let shared = DemoUserContainer()
        
    @UserDefaultArray<Int>(key: Constants.UserDefaults.favKey)
    var favoriteCollections: [Int]
}
