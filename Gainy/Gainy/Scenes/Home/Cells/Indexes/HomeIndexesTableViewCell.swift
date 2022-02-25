//
//  HomeIndexesTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit

final class HomeIndexesTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 70
    
    enum HomeIndex: Int, CaseIterable {
        case dow = 0, spp, nasdaq, bitcoin
    }
    
    @IBOutlet private var indexViews: [HomeIndexView]!
    
    func updateIndexes(models: [HomeIndexViewModel]) {        
        for (ind, val) in models.enumerated() {
            indexViews[ind].indexModel = val
        }
    }
}
