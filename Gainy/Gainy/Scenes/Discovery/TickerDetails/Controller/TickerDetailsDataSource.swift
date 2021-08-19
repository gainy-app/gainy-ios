//
//  TickerDetailsDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsDataSource: NSObject {
    let totalRows = 10
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
    }

    let ticker: TickerInfo
    
    enum Row: Int {
        case header = 0, chart, about, highlights, marketData, wsr, recommended, alternativeStocks, upcomingEvents, watchlist
    }
}

extension TickerDetailsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        totalRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Row(rawValue: indexPath.row)! {
        case .header:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .chart:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .about:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .highlights:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .marketData:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .wsr:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .recommended:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .alternativeStocks:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .upcomingEvents:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        case .watchlist:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        }
    }
}


























