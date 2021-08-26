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
        super.init()
        self.populateInitialHeights()
    }
    
    
    private let aboutMinHeight: CGFloat = 164.0 + 44.0
    private var cellHeights: [Row: CGFloat] = [:]
    private func populateInitialHeights() {
        cellHeights[.header] = 80.0
        cellHeights[.about] = aboutMinHeight
        cellHeights[.chart] = 291.0
        cellHeights[.highlights] = 169.0
        cellHeights[.marketData] = 284.0
        cellHeights[.wsr] = 230.0
        cellHeights[.recommended] = 156.0
        cellHeights[.news] = 201.0
        cellHeights[.alternativeStocks] = 0.0 //253.0
        cellHeights[.upcomingEvents] = 238.0
        cellHeights[.watchlist] = 120.0
    }

    let ticker: TickerInfo
    
    enum Row: Int {
        case header = 0, chart, about, highlights, marketData, wsr, recommended, news, alternativeStocks, upcomingEvents, watchlist
    }
    
    //MARK: - Hosting controllers
    
    static let hostingTag: Int = 7
    
    private lazy var wsrHosting: CustomHostingController<WSRView> = {
        let wsrHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: WSRView(totalScore: ticker.wsjData.rate, progress: ticker.wsjData.detailedStats))
        wsrHosting.view.tag = TickerDetailsDataSource.hostingTag
        return wsrHosting
    }()
    
    private lazy var chartHosting: CustomHostingController<ScatterChartView> = {
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: ScatterChartView(ticker: ticker.ticker,
                                                                                                              chartData: ticker.localChartData))
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        return chartHosting
    }()
}

extension TickerDetailsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Row(rawValue: indexPath.row)! {
        case .header:
            let cell: TickerDetailsHeaderViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .chart:
            let cell: TickerDetailsChartViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            if cell.addSwiftUIIfPossible(chartHosting.view) {
                chartHosting.view.autoSetDimension(.height, toSize: 291.0)
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell)
                chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell)
            }
            return cell
        case .about:
            let cell: TickerDetailsAboutViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            
            cell.cellHeightChanged = { [weak self] newHeight in
                tableView.beginUpdates()
                self?.cellHeights[.about] = max((self?.aboutMinHeight ?? 240.0), newHeight)
                tableView.endUpdates()
            }
            return cell
        case .highlights:
            let cell: TickerDetailsHighlightsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .marketData:
            let cell: TickerDetailsMarketDataViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .wsr:
            let cell: TickerDetailsWSRViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            if cell.addSwiftUIIfPossible(wsrHosting.view) {
                wsrHosting.view.autoSetDimension(.height, toSize: 119.0)
                wsrHosting.view.autoPinEdge(.leading, to: .leading, of: cell, withOffset: 28)
                wsrHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell, withOffset: -10)
                wsrHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell, withOffset: -28)
            }
            return cell
        case .recommended:
            let cell: TickerDetailsRecommendedViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .news:
            let cell: TickerDetailsNewsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .alternativeStocks:
            let cell: TickerDetailsAlternativeStocksViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .upcomingEvents:
            let cell: TickerDetailsUpcomingViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .watchlist:
            let cell: TickerDetailsWatchlistViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        }
    }
}

extension TickerDetailsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)!
        return cellHeights[row] ?? 0.0
    }
}
