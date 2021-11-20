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
    var rangeName: String
    
    @Published
    var rangeGrow: Float
    
    @Published
    var rangeGrowBalance: Float
    
    //S&P
    @Published
    var spGrow: Float
    
    init(balance: Float, rangeName: String, rangeGrow: Float, rangeGrowBalance: Float, spGrow: Float) {
        self.balance = balance
        self.rangeName = rangeName
        self.rangeGrow = rangeGrow
        self.rangeGrowBalance = rangeGrowBalance
        self.spGrow = spGrow
    }
}
