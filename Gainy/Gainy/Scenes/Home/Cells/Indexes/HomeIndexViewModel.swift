//
//  HomeIndexViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.02.2022.
//

import Foundation

struct HomeIndexViewModel {
    let name: String
    let grow: Float
    let value: Float
    
    static var demoData: [HomeIndexViewModel] = [
        HomeIndexViewModel(name: "Dow Jones", grow: 1.05, value: 35_090),
        HomeIndexViewModel(name: "S&P 500", grow: 1.55, value: 4_501),
        HomeIndexViewModel(name: "Nasdaq", grow: 2.38, value: 14_098),
        HomeIndexViewModel(name: "Bitcoin", grow: -0.77, value: 40_673)
    ]
}
