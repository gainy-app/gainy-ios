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
        self.isSPPVisible = false
        self.isLoading = true
        self.lastDayPrice = 0.0
        self.relatedCollection1DGain = 0.0
        self.compareTTFName = ""
        self.min = nil
        self.max = nil
    }
    
    @Published
    var ticker: RemoteTicker
    
    @Published
    var localTicker: TickerInfo
    
    @Published
    var chartData: ChartData
    
    @Published
    var medianData: ChartData
    
    @Published
    var isSPPVisible: Bool
    
    @Published
    var isLoading: Bool
    
    @Published
    var lastDayPrice: Float = 0
    
    @Published
    var relatedCollection1DGain: Float = 0
    
    @Published
    var compareTTFName: String
    
    @Published
    var min: Double?
    
    @Published
    var max: Double?
}
