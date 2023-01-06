//
//  SharedValuesManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.01.2023.
//

import Foundation

/// Storage for shared Porto gains and other mid-screen data
final class SharedValuesManager {
    
    static let shared = SharedValuesManager()
    
    var portfolioBalance: Float = 0
}
