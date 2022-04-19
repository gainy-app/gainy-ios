//
//  TTFChartViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.04.2022.
//

import UIKit
import Combine

final class TTFChartViewModel: ObservableObject {

    //S&P
    @Published
    var spGrow: Float
    
    @Published
    var chartData: ChartData
    
    @Published
    var sypChartData: ChartData
    
    init(spGrow: Float, chartData: ChartData, sypChartData: ChartData) {
        self.spGrow = spGrow
        self.chartData = chartData
        self.sypChartData = sypChartData
    }
}
