//
//  HoldingRangeableCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import UIKit

class HoldingRangeableCell: UITableViewCell {
    
    //Range update logic
    var range: ScatterChartView.ChartPeriod = .d1 {
        didSet {
            rangeChanged(range)
        }
    }
    
    func rangeChanged(_ range: ScatterChartView.ChartPeriod) {
        
    }
    
    //Cell height cahnge notifier
    var cellHeightChanged: ((CGFloat) -> Void)?
}
