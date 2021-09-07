//
//  ScatterChartDelegate.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import Combine
import SwiftUI

protocol ScatterChartViewDelegate: AnyObject {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod)
}

class ScatterChartDelegate: ObservableObject {
    
    weak var delegate: ScatterChartViewDelegate?
    
    var range: ScatterChartView.ChartPeriod = .d1 {
        didSet {
            delegate?.chartPeriodChanged(period: range)
        }
    }
}
