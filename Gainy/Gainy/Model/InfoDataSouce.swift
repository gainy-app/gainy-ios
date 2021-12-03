//
//  InfoDataSouce.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/22/21.
//

import Foundation

enum InfoDataSouceType: Int {
    
    case Interst
    case Category
    case SecurityType
}

struct InfoDataSouce {
    
    let type: InfoDataSouceType
    let id: Int
    let title: String
    let iconURL: URL
    let selected: Bool
}
