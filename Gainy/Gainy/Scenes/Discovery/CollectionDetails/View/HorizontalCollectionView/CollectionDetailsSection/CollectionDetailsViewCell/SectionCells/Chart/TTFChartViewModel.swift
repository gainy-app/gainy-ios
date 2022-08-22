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
    var dayGrow: Float
    
    @Published
    var chartData: ChartData
    
    @Published
    var sypChartData: ChartData
    
    @Published
    var isSPPVisible: Bool
    
    @Published
    var selectedTag: ScatterChartView.ChartPeriod
    
    @Published
    var isLoading: Bool
    
    @Published
    var lastDayPrice: Float = 0
        
    var dragActive: Bool = false
    
    var currentDataDiff: Double = 0.0
    
    @Published
    var min: Double?
    
    @Published
    var max: Double?
      
    init(spGrow: Float, dayGrow: Float, chartData: ChartData, sypChartData: ChartData, isSPPVisible: Bool) {
        self.spGrow = spGrow
        self.dayGrow = dayGrow
        self.chartData = chartData
        self.sypChartData = sypChartData
        self.isSPPVisible = isSPPVisible
        self.isLoading = true
        self.lastDayPrice = 0.0
        self.selectedTag = .m1
    }
}
