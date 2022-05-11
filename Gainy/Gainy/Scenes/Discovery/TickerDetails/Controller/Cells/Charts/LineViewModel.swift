//
//  LineViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.09.2021.
//

import SwiftUI
import Foundation

class LineViewModel: ObservableObject {
    @Published
    var dragLocation:CGPoint = .zero
    
    @Published
    var indicatorLocation:CGPoint = .zero
    
    @Published
    var closestPoint: CGPoint = .zero
        
    @Published
    var opacity:Double = 0
    
    @Published
    var currentDataNumber: String = ""
    
    @Published
    var currentDataValue: String = ""
    
    @Published
    var hideHorizontalLines: Bool = false
    
    @Published
    var isSPYVisible: Bool = false
    
    @Published
    var chartPeriod: ScatterChartView.ChartPeriod = .d1
    
    @Published
    var showCloseLine: Bool = true
    
    @Published
    var minMaxPercent: Bool = false
    
    @Published
    var lastDayPrice: Float = 0
    
    init(minMaxPercent: Bool = false) {
        self.minMaxPercent = minMaxPercent
    }
}
