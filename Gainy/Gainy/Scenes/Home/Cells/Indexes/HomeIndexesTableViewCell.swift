//
//  HomeIndexesTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit

final class HomeIndexesTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 16.0 + 70 + 16.0
    
    enum HomeIndex: Int, CaseIterable {
        case dow = 0, spp, nasdaq, bitcoin
    }
    
    @IBOutlet private var indexViews: [HomeIndexView]!
    
    func updateIndexes() {
        
        for ind in HomeIndex.allCases {
            indexViews[ind.rawValue].indexModel = HomeIndexViewModel.demoData[ind.rawValue]
        }
    }
}
