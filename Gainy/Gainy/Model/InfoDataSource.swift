//
//  InfoDataSource.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/22/21.
//

import Foundation

enum InfoDataSourceType: Int, Codable {
    
    case Interst
    case Category
    case SecurityType
}

struct InfoDataSource: Codable {
    
    let type: InfoDataSourceType
    let id: Int
    let title: String
    let iconURL: String
    let selected: Bool
}
