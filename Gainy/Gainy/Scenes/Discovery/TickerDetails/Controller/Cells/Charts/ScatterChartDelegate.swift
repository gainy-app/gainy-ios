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
    func comparePressed()
}

class ScatterChartDelegate: ObservableObject {
    
    weak var delegate: ScatterChartViewDelegate?
    
    var range: ScatterChartView.ChartPeriod = .d1 {
        didSet {
            delegate?.chartPeriodChanged(period: range)
        }
    }
    
    func comparePressed() {
        delegate?.comparePressed()
    }
}


protocol HoldingScatterChartViewDelegate: AnyObject {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel)
    func comparePressed()
}

class HoldingScatterChartDelegate: ObservableObject {
    
    weak var delegate: HoldingScatterChartViewDelegate?
    
    func changeRange(range: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel) {
        delegate?.chartPeriodChanged(period: range, viewModel: viewModel)
    }
    
    func comparePressed() {
        delegate?.comparePressed()
    }
}
