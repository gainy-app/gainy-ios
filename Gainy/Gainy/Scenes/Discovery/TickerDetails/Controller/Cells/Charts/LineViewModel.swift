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
    var isMedianVisible: Bool = false
    
    @Published
    var chartPeriod: ScatterChartView.ChartPeriod = .d1
}
