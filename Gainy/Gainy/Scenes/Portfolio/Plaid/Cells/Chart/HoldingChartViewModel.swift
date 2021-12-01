//
//  HoldingChartViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import UIKit
import Combine

final class HoldingChartViewModel: ObservableObject {
    //Account
    @Published
    var balance: Float
    
    @Published
    var rangeGrow: Float
    
    @Published
    var rangeGrowBalance: Float
    
    //S&P
    @Published
    var spGrow: Float
    
    @Published
    var chartData: ChartData
    
    @Published
    var sypChartData: ChartData
    
    init(balance: Float, rangeGrow: Float, rangeGrowBalance: Float, spGrow: Float, chartData: ChartData, sypChartData: ChartData) {
        self.balance = balance
        self.rangeGrow = rangeGrow
        self.rangeGrowBalance = rangeGrowBalance
        self.spGrow = spGrow
        self.chartData = chartData
        self.sypChartData = sypChartData
    }
}
