//
//  TickerDetailsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

struct TickerInfo {
    
}

final class TickerDetailsViewModel: NSObject, CardDetailsViewModelProtocol {
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
        self.dataSource = TickerDetailsDataSource(ticker: ticker)
    }

    let ticker: TickerInfo
    
    let dataSource: TickerDetailsDataSource
}
