//
//  ScatterChartViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 22.10.2021.
//

import SwiftUI

final class ScatterChartViewModel: ObservableObject {
    
    init(ticker: RemoteTicker, localTicker: TickerInfo, chartData: ChartData, medianData: ChartData) {
        self.ticker = ticker
        self.localTicker = localTicker
        self.chartData = chartData
        self.medianData = medianData
    }
    
    @Published
    var ticker: RemoteTicker
    
    @Published
    var localTicker: TickerInfo
    
    @Published
    var chartData: ChartData
    
    @Published
    var medianData: ChartData
}
