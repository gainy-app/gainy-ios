//
//  TickerDetailsDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import Combine
import SwiftUI

protocol TickerDetailsDataSourceDelegate: AnyObject {
    func altStockPressed(stock: AltStockTicker)
    func loadingState(started: Bool)
    func comparedStocksChanged(stock: AltStockTicker)
    func isStockCompared(stock: AltStockTicker) -> Bool
    func didRequestShowBrokersListForSymbol(symbol: String)
    func openCompareWithSelf(ticker: TickerInfo)
    func requestOpenCollection(withID id: Int)
    func wrongIndPressed()
}

final class TickerDetailsDataSource: NSObject {
    weak var delegate: TickerDetailsDataSourceDelegate?
    
    private let totalRows = 10
    
    
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
        super.init()
        self.populateInitialHeights()
    }
    
    //Notifs
    var cancellable = Set<AnyCancellable>()
    fileprivate var lastOffset: CGFloat = 0.0
    
    private var aboutMinHeight: CGFloat = 164.0 + 44.0
    private let chatHeight: CGFloat = 291.0 + 50
    
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
        updateWatchlistCellHeight()
    }
    private(set) var isAboutExpanded: Bool = false
    
    private func updateWatchlistCellHeight() {
        if UserProfileManager.shared.selectedBrokerToTrade != nil {
            cellHeights[.watchlist] = TickerDetailsWatchlistViewCell.cellHeightExpanded
        } else {
            cellHeights[.watchlist] = TickerDetailsWatchlistViewCell.cellHeight
        }
    }
    
    let ticker: TickerInfo
    var headerCell: TickerDetailsHeaderViewCell?
    
    enum Row: Int {
        case header = 0, chart, about, recommended, highlights, marketData, wsr, news, alternativeStocks, upcomingEvents, watchlist
    }
    
    //MARK: - Hosting controllers
    
    static var oldHostingTag: Int = -1
    static var hostingTag: Int = Int((arc4random() % 50) + 1)
    
    private let wsrModel: WSRViewModel = WSRViewModel.init(totalScore: 0, priceTarget: 0, progress: [])
    private lazy var wsrHosting: CustomHostingController<WSRView> = {
        let wsrHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: WSRView(viewModel: wsrModel))
        wsrHosting.view.tag = TickerDetailsDataSource.hostingTag
        return wsrHosting
    }()
    
    private(set) lazy var chartLoader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.color = .lightGray
        loader.hidesWhenStopped = true
        return loader
    }()
    
    func stopLoader() {
        chartLoader.stopAnimating()
        chartHosting.view.alpha = 1.0
    }
    
    private(set) var chartViewModel: ScatterChartViewModel!
    private lazy var chartHosting: CustomHostingController<ScatterChartView> = {
        
        chartViewModel = ScatterChartViewModel.init(ticker: ticker.ticker, localTicker: ticker, chartData: ticker.localChartData)
        var rootView = ScatterChartView(viewModel: chartViewModel,
                                        delegate: chartDelegate)
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: rootView)
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        return chartHosting
    }()
    
    
    //MARK: - Updating UI
    
    func updateChart() {
        chartViewModel.ticker = ticker.ticker
        chartViewModel.localTicker = ticker
        chartViewModel.chartData = ticker.localChartData
        wsrModel.totalScore = ticker.wsjData.rate
        wsrModel.priceTarget = ticker.wsjData.targetPrice
        wsrModel.progress = ticker.wsjData.detailedStats
    }
    
    func calculateHeights() {
        print(ticker.ticker.type ?? "")
        //Highlights
        if ticker.highlights.count > 0 {
            cellHeights[.highlights] = TickerDetailsHighlightsViewCell.cellHeight
        } else {
            cellHeights[.highlights] = 0.0
        }
        
        if ticker.news.count > 0 {
            cellHeights[.news] = TickerDetailsNewsViewCell.cellHeight
        } else {
            cellHeights[.news] = 0.0
        }
        
        if ticker.altStocks.count > 0 {
            cellHeights[.alternativeStocks] = TickerDetailsAlternativeStocksViewCell.cellHeight
        } else {
            cellHeights[.alternativeStocks] = 0.0
        }
        
        
        if ticker.upcomingEvents.count > 0 {
            cellHeights[.upcomingEvents] = 32.0 + 24.0 + 16.0 + CGFloat(ticker.upcomingEvents.count) * 44.0 + 16.0
        } else {
            cellHeights[.upcomingEvents] = 0.0
        }
        
        if ticker.wsrAnalystsCount > 0 {
            cellHeights[.wsr] = TickerDetailsWSRViewCell.cellHeight
        } else {
            cellHeights[.wsr] = 0.0
        }
        
        if ticker.isETF {
            cellHeights[.recommended] = 0.0
            cellHeights[.marketData] = 0.0
        }
    }
    
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
            headerCell = cell;
            return cell
        case .chart:
            let cell: TickerDetailsChartViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            if cell.addSwiftUIIfPossible(chartHosting.view, viewTag: TickerDetailsDataSource.hostingTag, oldTag: TickerDetailsDataSource.oldHostingTag) {
                chartHosting.view.autoSetDimension(.height, toSize: chatHeight)
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell)
                chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell)
                chartHosting.view.alpha = 0.0
            }
                cell.contentView.addSubview(chartLoader)
                chartLoader.translatesAutoresizingMaskIntoConstraints = false
                chartLoader.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor).isActive = true
                chartLoader.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor).isActive = true
            cell.contentView.bringSubviewToFront(chartLoader)
            return cell
        case .about:
            let cell: TickerDetailsAboutViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.delegate = self
            
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
            cell.isMoreSelected = self.isAboutExpanded
            cell.tickerInfo = ticker
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
            cell.isSkeletonable = false
            cell.tickerInfo = ticker
            wsrHosting.view.clipsToBounds = false
            if #available(iOS 15, *) {
                if cell.addSwiftUIIfPossible(wsrHosting.view, viewTag: TickerDetailsDataSource.hostingTag, oldTag: TickerDetailsDataSource.oldHostingTag) {
                    wsrHosting.view.autoSetDimension(.height, toSize: 179.0)
                    wsrHosting.view.autoPinEdge(.leading, to: .leading, of: cell, withOffset: 28)
                    wsrHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell, withOffset: 0)
                    wsrHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell, withOffset: -28)
                }
            } else {
                if cell.addSwiftUIIfPossible(wsrHosting.view, viewTag: TickerDetailsDataSource.hostingTag, oldTag: TickerDetailsDataSource.oldHostingTag) {
                    wsrHosting.view.autoSetDimension(.height, toSize: 179.0)
                    wsrHosting.view.autoPinEdge(.leading, to: .leading, of: cell, withOffset: 28)
                    wsrHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell, withOffset: -40)
                    wsrHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell, withOffset: -28)
                }
            }
            wsrModel.totalScore = ticker.wsjData.rate
            wsrModel.priceTarget = ticker.wsjData.targetPrice
            wsrModel.progress = ticker.wsjData.detailedStats
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
            
            cell.cellHeightChanged = { [weak self] newHeight in
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.recommended] = max(168.0, newHeight)
                    tableView.endUpdates()
                }
            }
            
            return cell
        case .news:
            let cell: TickerDetailsNewsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .alternativeStocks:
            let cell: TickerDetailsAlternativeStocksViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            cell.delegate = self
            return cell
        case .upcomingEvents:
            let cell: TickerDetailsUpcomingViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .watchlist:
            let cell: TickerDetailsWatchlistViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            cell.delegate = self
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
        if row == .about {
            print(cellHeights[row] ?? 0.0)
        }
        return cellHeights[row] ?? 0.0
    }
}


extension TickerDetailsDataSource: ScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod) {
        delegate?.loadingState(started: true)
        ticker.chartRange = period
        ticker.loadNewChartData(period: period) {[weak self] in
            guard let self = self else {return}
            self.chartViewModel.localTicker = self.ticker
            self.chartViewModel.chartData = self.ticker.localChartData
            self.delegate?.loadingState(started: false)
        }
    }
    func comparePressed() {
        delegate?.openCompareWithSelf(ticker: self.ticker)
    }
}

extension TickerDetailsDataSource: TickerDetailsAlternativeStocksViewCellDelegate {
    func isStockCompared(stock: AltStockTicker) -> Bool {
        delegate?.isStockCompared(stock: stock) ?? false
    }
    
    
    func altStockPressed(stock: AltStockTicker) {
        delegate?.altStockPressed(stock: stock)
    }
    
    func comparePressed(stock: AltStockTicker) {        
        GainyAnalytics.logEvent("ticker_alt_stock_compared", params: ["tickerSymbol" : stock.symbol ?? ""])
        delegate?.comparedStocksChanged(stock: stock)
    }
}

extension TickerDetailsDataSource: TickerDetailsWatchlistViewCellDelegate {
    
    func didRequestShowBrokersListForSymbol(symbol: String) {
        
        self.delegate?.didRequestShowBrokersListForSymbol(symbol: symbol)
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

extension TickerDetailsDataSource: TickerDetailsAboutViewCellDelegate {
    
    func requestOpenCollection(withID id: Int) {
        
        self.delegate?.requestOpenCollection(withID: id)
    }
    
    func aboutExtended(isExtended: Bool) {
        self.isAboutExpanded = isExtended
    }
    
    func wrongIndPressed() {
        delegate?.wrongIndPressed()
    }
}
