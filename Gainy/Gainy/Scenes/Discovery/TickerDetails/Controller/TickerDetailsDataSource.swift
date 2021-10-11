//
//  TickerDetailsDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import Combine

protocol TickerDetailsDataSourceDelegate: AnyObject {
    func altStockPressed(stock: AltStockTicker)
    func loadingState(started: Bool)
    func comparedStocksChanged()
}

final class TickerDetailsDataSource: NSObject {
    weak var delegate: TickerDetailsDataSourceDelegate?
    
    let totalRows = 10
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
        super.init()
        self.populateInitialHeights()
    }
    
    //Notifs
    var cancellable = Set<AnyCancellable>()
    fileprivate var lastOffset: CGFloat = 0.0
    
    private var aboutMinHeight: CGFloat = 164.0 + 44.0
    private let chatHeight: CGFloat = 291.0 + 10
    
    private var cellHeights: [Row: CGFloat] = [:]
    private func populateInitialHeights() {
        cellHeights[.header] = TickerDetailsHeaderViewCell.cellHeight
        cellHeights[.about] = aboutMinHeight
        cellHeights[.chart] = chatHeight
        cellHeights[.highlights] = TickerDetailsHighlightsViewCell.cellHeight
        cellHeights[.marketData] = TickerDetailsMarketDataViewCell.cellHeight
        cellHeights[.wsr] = TickerDetailsWSRViewCell.cellHeight
        cellHeights[.recommended] = TickerDetailsRecommendedViewCell.cellHeight
        cellHeights[.news] = TickerDetailsNewsViewCell.cellHeight
        cellHeights[.alternativeStocks] = TickerDetailsAlternativeStocksViewCell.cellHeight
        cellHeights[.upcomingEvents] = TickerDetailsUpcomingViewCell.cellHeight
        cellHeights[.watchlist] = TickerDetailsWatchlistViewCell.cellHeight
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
        var rootView = ScatterChartView(ticker: ticker.ticker,
                                        chartData: ticker.localChartData,
                                        delegate: chartDelegate)
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: rootView)
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        return chartHosting
    }()
    
    private lazy var chartDelegate: ScatterChartDelegate = {
        let delegateObject =  ScatterChartDelegate()
        delegateObject.delegate = self
        return delegateObject
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
                chartHosting.view.autoSetDimension(.height, toSize: chatHeight)
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell)
                chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell)
            }
            return cell
        case .about:
            let cell: TickerDetailsAboutViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            cell.cellHeightChanged = { [weak self] newHeight in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.about] = max((self?.aboutMinHeight ?? 208.0), newHeight)
                    tableView.endUpdates()
                }
            }
            cell.minHeightUpdated = { [weak self] minHeight in
                DispatchQueue.main.async {
                    dprint("New min height: \(minHeight)")
                    self?.aboutMinHeight = max(minHeight, self?.aboutMinHeight ?? 0.0)
                    tableView.beginUpdates()
                    self?.cellHeights[.about] = minHeight
                    tableView.endUpdates()
                }
            }
            cell.tickerInfo = ticker
            return cell
        case .highlights:
            let cell: TickerDetailsHighlightsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.cellHeightChanged = { [weak self] newHeight in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.highlights] = newHeight
                    tableView.endUpdates()
                }
            }
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
                wsrHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell, withOffset: 10)
                wsrHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell, withOffset: -28)
            }
            return cell
        case .recommended:
            let cell: TickerDetailsRecommendedViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            
            NotificationCenter.default.publisher(for: NotificationManager.tickerScrollNotification).sink { _ in
            } receiveValue: { notif in
                if let transform = notif.userInfo?["transform"] as? CGAffineTransform {
                    cell.setTransform(transform)
                }
            }.store(in: &cancellable)
            
            return cell
        case .news:
            let cell: TickerDetailsNewsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.cellHeightChanged = { [weak self] newHeight in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.news] = newHeight
                    tableView.endUpdates()
                }
            }
            cell.tickerInfo = ticker
            return cell
        case .alternativeStocks:
            let cell: TickerDetailsAlternativeStocksViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.cellHeightChanged = { [weak self] newHeight in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.alternativeStocks] = newHeight
                    tableView.endUpdates()
                }
            }
            cell.tickerInfo = ticker
            cell.delegate = self
            return cell
        case .upcomingEvents:
            let cell: TickerDetailsUpcomingViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.cellHeightChanged = { [weak self] newHeight in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.upcomingEvents] = newHeight
                    tableView.endUpdates()
                }
            }
            cell.tickerInfo = ticker
            return cell
        case .watchlist:
            let cell: TickerDetailsWatchlistViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch Row(rawValue: indexPath.row)! {
        case .recommended:
            cancellable.removeAll()
            break
        default:
            break
        }
    }
}

extension TickerDetailsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)!
        return cellHeights[row] ?? 0.0
    }
}


extension TickerDetailsDataSource: ScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod) {
        delegate?.loadingState(started: true)
        ticker.chartRange = period
        ticker.loadNewChartData {[weak self] in
            self?.delegate?.loadingState(started: false)
        }
    }
}

extension TickerDetailsDataSource: TickerDetailsAlternativeStocksViewCellDelegate {
    
    func altStockPressed(stock: AltStockTicker) {
        delegate?.altStockPressed(stock: stock)
    }
    
    func comparePressed(stock: AltStockTicker) {
        if let stockIndex = ticker.tickersToCompare.firstIndex(where: {$0.symbol == stock.symbol}) {
            ticker.tickersToCompare.remove(at: stockIndex)
        } else {
            ticker.tickersToCompare.append(stock)
        }
        GainyAnalytics.logEvent("ticker_alt_stock_compared", params: ["tickerSymbol" : stock.symbol ?? ""])
        delegate?.comparedStocksChanged()
    }
}

extension TickerDetailsDataSource: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let topOffset = scrollView.contentOffset.y
        if abs(lastOffset - topOffset) > 10 {
            lastOffset = topOffset
            let angle = -(topOffset * 0.5) * 2 * CGFloat(Double.pi / 180)
            NotificationCenter.default.post(name: NotificationManager.tickerScrollNotification, object: nil, userInfo: ["transform" : CGAffineTransform(rotationAngle: angle)])
        }
    }
}
