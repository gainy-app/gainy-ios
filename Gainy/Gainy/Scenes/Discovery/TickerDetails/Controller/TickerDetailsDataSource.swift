//
//  TickerDetailsDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import Combine
import SwiftUI
import Kingfisher
import GainyAPI
import GainyCommon

protocol TickerDetailsDataSourceDelegate: AnyObject {
    func altStockPressed(stock: AltStockTicker)
    func loadingState(started: Bool)
    func comparedStocksChanged(stock: AltStockTicker)
    func isStockCompared(stock: AltStockTicker) -> Bool
    func didRequestShowBrokersListForSymbol(symbol: String)
    func openCompareWithSelf(ticker: TickerInfo)
    func requestOpenCollection(withID id: Int)
    func wrongIndPressed(isTicked: Bool)
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell)
    func collectionSelected(collection: RemoteCollectionDetails)
    func onboardPressed()
    func reload()
}

final class TickerDetailsDataSource: NSObject {
    weak var delegate: TickerDetailsDataSourceDelegate?
    
    private var historyConfigurators: ListCellConfigurationWithCallBacks?
    private var currentPositionConfigurator: ListCellConfigurationWithCallBacks?
    private var ttfPositionConfigurator: ListCellConfigurationWithCallBacks?
    
    init(ticker: TickerInfo) {
        self.ticker = ticker
        super.init()
        self.populateInitialHeights()
        self.updateConfigurators()
    }
    
    //Notifs
    var cancellable = Set<AnyCancellable>()
    fileprivate var lastOffset: CGFloat = 0.0
    
    private var aboutMinHeight: CGFloat = 164.0 + 44.0
    private let chatHeight: CGFloat = 291.0 + 50 + 100.0 + 60
    
    private var cellHeights: [Row: CGFloat] = [:]
    private func populateInitialHeights() {
        cellHeights[.header] = TickerDetailsHeaderViewCell.cellHeight
        cellHeights[.about] = aboutMinHeight
        cellHeights[.chart] = chatHeight
        cellHeights[.highlights] = 0.0
        cellHeights[.marketData] = ticker.hideMetrics ? 0.0 : TickerDetailsMarketDataViewCell.cellHeight
        cellHeights[.wsr] = ticker.hideMetrics ? 0.0 : TickerDetailsWSRViewCell.cellHeight
        if UserProfileManager.shared.isOnboarded {
            cellHeights[.recommended] = ticker.hideRecommendations ? 0.0 : TickerDetailsRecommendedViewCell.cellHeight
        } else {
            cellHeights[.recommended] = TickerDetailsNoRecommendationsViewCell.cellHeight
        }
        cellHeights[.news] = TickerDetailsNewsViewCell.cellHeight
        cellHeights[.alternativeStocks] = ticker.isCrypto ? 0.0 : TickerDetailsAlternativeStocksViewCell.cellHeight
        cellHeights[.upcomingEvents] = TickerDetailsUpcomingViewCell.cellHeight
        cellHeights[.ttf] = 168
        cellHeights[.ttfHistory] = 56
        cellHeights[.currentPosition] = 56
        updateWatchlistCellHeight()
    }
    private(set) var isAboutExpanded: Bool = false
    
    private func updateWatchlistCellHeight() {
        if UserProfileManager.shared.selectedBrokerToTrade != nil {
            cellHeights[.watchlist] = TickerDetailsWatchlistViewCell.cellHeightExpanded
        } else {
            cellHeights[.watchlist] = ticker.isIndex ? 0.0 : TickerDetailsWatchlistViewCell.cellHeight
        }
    }
    
    let ticker: TickerInfo
    var headerCell: TickerDetailsHeaderViewCell?
    
    var cancellOrderPressed: ((TradingHistoryFrag) -> Void)?
    
    enum Row: Int, CaseIterable {
        case header = 0, chart, ttf, currentPosition, ttfHistory, about, recommended, highlights, marketData, wsr, news, alternativeStocks, upcomingEvents, watchlist
        
        static func getSection(isPurchase: Bool, haveHistory: Bool) -> [Row] {
            switch(isPurchase, haveHistory) {
            case (true, true):
                return Row.allCases
            case (false, true):
                return [.header, .chart, .currentPosition, .ttfHistory, .about, .recommended, .highlights, .marketData, .wsr, .news, .alternativeStocks, .upcomingEvents, .watchlist]
            case (true, false):
                return [.header, .chart, .ttf, .about, .recommended, .highlights, .marketData, .wsr, .news, .alternativeStocks, .upcomingEvents, .watchlist]
            default:
                return [.header, .chart, .about, .recommended, .highlights, .marketData, .wsr, .news, .alternativeStocks, .upcomingEvents, .watchlist]
            }
        }
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
        chartViewModel.isLoading = false
    }
    
    private(set) var chartViewModel: ScatterChartViewModel!
    private lazy var chartHosting: CustomHostingController<ScatterChartView> = {
        
        chartViewModel = ScatterChartViewModel.init(ticker: ticker.ticker, localTicker: ticker, chartData: ticker.localChartData, medianData: ticker.localMedianData)
        var rootView = ScatterChartView(viewModel: chartViewModel,
                                        delegate: chartDelegate)
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: rootView)
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        return chartHosting
    }()
    
    
    //MARK: - Updating UI
    
    func updateConfigurators() {
        self.ttfPositionConfigurator = nil
        self.historyConfigurators = nil
        self.currentPositionConfigurator = nil
        if let status = ticker.tradeStatus {
            let configurator = TTFPositionTableConfigurator(model: status)
            ttfPositionConfigurator = configurator
        }
        if ticker.isPurchased, let tradeHistory = ticker.tradeHistory {
            if let firstLine = tradeHistory.lines.first,
               firstLine.tags.contains(where: { $0 == "pending".uppercased() }) {
                let configurator = CurrentPositionTableCellConfigurator(model: firstLine, position: (true, !tradeHistory.hasHistory))
                configurator.didTapCancel = {[weak self] history in
                    self?.cancellOrderPressed?(history)
                }
                self.currentPositionConfigurator = configurator
            }
        }
        if let tradeHistory = ticker.tradeHistory, let firstLine = ticker.tradeHistory?.lines.first, !tradeHistory.lines.isEmpty {
            let historyConfigurator = HistoryTableCellConfigurator(
                model: tradeHistory.lines,
                position: (
                    !firstLine.tags.contains(where: { $0 == "pending".uppercased() } ),
                    true))
            self.historyConfigurators = historyConfigurator
        }
    }
    
    func updateChart() {
        if !ticker.localChartData.onlyPoints().isEmpty && !ticker.localMedianData.onlyPoints().isEmpty  {
            chartViewModel.min = Double(min(ticker.localMedianData.onlyPoints().min() ?? 0.0, ticker.localChartData.onlyPoints().min() ?? 0.0))
            chartViewModel.max = Double(max(ticker.localMedianData.onlyPoints().max() ?? 0.0, ticker.localChartData.onlyPoints().max() ?? 0.0))
        }
        
        if ticker.localMedianData.onlyPoints().isEmpty {
            chartViewModel.min = ticker.localChartData.onlyPoints().min() ?? 0.0
            chartViewModel.max = ticker.localChartData.onlyPoints().max() ?? 0.0
        }
        chartViewModel.lastDayPrice = Float(ticker.ticker.realtimeMetrics?.previousDayClosePrice ?? 0.0)
        if chartViewModel.lastDayPrice != 0.0 && ticker.chartRange == .d1 {
            chartViewModel.min = min(Double(chartViewModel.min ?? 0.0), Double(chartViewModel.lastDayPrice))
            chartViewModel.max = max(Double(chartViewModel.max ?? 0.0), Double(chartViewModel.lastDayPrice))
        }
        
        chartViewModel.relatedCollection1DGain = ticker.medianCollection?.metrics?.relativeDailyChange ?? 0.0
        chartViewModel.ticker = ticker.ticker
        chartViewModel.localTicker = ticker
        chartViewModel.chartData = ticker.localChartData
        chartViewModel.medianData = ticker.localMedianData
        chartViewModel.compareTTFName = ticker.medianCollection?.name ?? ""
        wsrModel.totalScore = ticker.wsjData.rate
        wsrModel.priceTarget = ticker.wsjData.targetPrice
        wsrModel.progress = ticker.wsjData.detailedStats
    }
    
    func calculateHeights() {
        print(ticker.ticker.type ?? "")
        //Highlights
        updateConfigurators()
        cellHeights[.header] = ticker.name.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - (24.0 + 72.0), font: .proDisplayBold(24)) + 72.0 + 32.0
        
        if ticker.highlights.count > 0 {
            cellHeights[.highlights] = 0.0
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
        
        if UserProfileManager.shared.isOnboarded {
            if ticker.hideRecommendations {
                cellHeights[.recommended] = 0.0
            }
        } else {
            cellHeights[.recommended] = TickerDetailsNoRecommendationsViewCell.cellHeight
        }
        
        if ticker.isETF || ticker.isCrypto || ticker.isIndex {
            
            cellHeights[.marketData] = 0.0
        }
        
        if ticker.isCrypto {
            cellHeights[.upcomingEvents] = 0.0
            cellHeights[.alternativeStocks] = 0.0
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
        print("foo")
        return Row.getSection(isPurchase: ticker.isPurchased, haveHistory: ticker.haveHistory).count
//        return Row.getSection(isPurchase: false, haveHistory: false).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = Row.getSection(isPurchase: ticker.isPurchased, haveHistory: ticker.haveHistory)[indexPath.row]
        switch item {
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
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell.contentView)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell.contentView)
                chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell.contentView)
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
                let headerSkip = (self?.ticker.hideRecommendations ?? false)  ? -84.0 : 0.0
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    self?.cellHeights[.about] = max(((self?.aboutMinHeight ?? 208.0) + headerSkip), newHeight)
                    tableView.endUpdates()
                }
            }
            cell.minHeightUpdated = { [weak self] minHeight in
                DispatchQueue.main.async {
                    let headerSkip = (self?.ticker.hideRecommendations ?? false) ? -84.0 : 0.0
                    self?.aboutMinHeight = max(minHeight, (self?.aboutMinHeight ?? 0.0) + headerSkip)
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
                    wsrHosting.view.autoPinEdge(.leading, to: .leading, of: cell.contentView, withOffset: 28)
                    wsrHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell.contentView, withOffset: 0)
                    wsrHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell.contentView, withOffset: -28)
                }
            } else {
                if cell.addSwiftUIIfPossible(wsrHosting.view, viewTag: TickerDetailsDataSource.hostingTag, oldTag: TickerDetailsDataSource.oldHostingTag) {
                    wsrHosting.view.autoSetDimension(.height, toSize: 179.0)
                    wsrHosting.view.autoPinEdge(.leading, to: .leading, of: cell.contentView, withOffset: 28)
                    wsrHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell.contentView, withOffset: -40)
                    wsrHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell.contentView, withOffset: -28)
                }
            }
            wsrModel.totalScore = ticker.wsjData.rate
            wsrModel.priceTarget = ticker.wsjData.targetPrice
            wsrModel.progress = ticker.wsjData.detailedStats
            return cell
        case .recommended:
            if UserProfileManager.shared.isOnboarded {
                let cell: TickerDetailsRecommendedViewCell = tableView.dequeueReusableCell(for: indexPath)
                cell.tickerInfo = ticker
                
                NotificationCenter.default.publisher(for: NotificationManager.tickerScrollNotification).sink { _ in
                } receiveValue: { notif in
                    if let transform = notif.userInfo?["transform"] as? CGAffineTransform {
                        cell.setTransform(transform)
                    }
                }.store(in: &cancellable)
                
                if !ticker.isIndex && !ticker.isCrypto {
                    cell.cellHeightChanged = { [weak self] newHeight in
                        DispatchQueue.main.async {
                            tableView.beginUpdates()
                            self?.cellHeights[.recommended] = max(168.0, newHeight)
                            tableView.endUpdates()
                        }
                    }
                }
                cell.delegate = self
                
                return cell
            } else {
                let cell: TickerDetailsNoRecommendationsViewCell = tableView.dequeueReusableCell(for: indexPath)
                NotificationCenter.default.publisher(for: NotificationManager.tickerScrollNotification).sink { _ in
                } receiveValue: { notif in
                    if let transform = notif.userInfo?["transform"] as? CGAffineTransform {
                        cell.setTransform(transform)
                    }
                }.store(in: &cancellable)
                cell.checkInAction = { [weak self] in
                    self?.delegate?.onboardPressed()
                }
                return cell
            }
        case .news:
            let cell: TickerDetailsNewsViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            return cell
        case .alternativeStocks:
            let cell: TickerDetailsAlternativeStocksViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.tickerInfo = ticker
            cell.delegate = self
            cell.contentView.clipsToBounds = false
            cell.clipsToBounds = false
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
        case .ttf:
            if let configurator = ttfPositionConfigurator {
                let cell = tableView.dequeueReusableCell(withIdentifier: configurator.cellIdentifier, for: indexPath)
                configurator.setupCell(cell, isSkeletonable:  tableView.isSkeletonable)
                return cell
            }
            return UITableViewCell()
        case .ttfHistory:
            if let historyConfigurator = historyConfigurators as? HistoryCellConfigurator {
                historyConfigurator.cellHeightChanged = { [weak self] newHeight in
                    DispatchQueue.main.async {
                        tableView.beginUpdates()
                        historyConfigurator.isToggled = !historyConfigurator.isToggled
                        self?.cellHeights[.ttfHistory] = newHeight
                        tableView.endUpdates()
                    }
                }
                let cell = tableView.dequeueReusableCell(withIdentifier: historyConfigurator.cellIdentifier, for: indexPath)
                historyConfigurator.setupCell(cell, isSkeletonable: tableView.isSkeletonable)
                return cell
            }
            return UITableViewCell()
        case .currentPosition:
            if let configurator = currentPositionConfigurator {
                let cell = tableView.dequeueReusableCell(withIdentifier: configurator.cellIdentifier, for: indexPath)
                configurator.setupCell(cell, isSkeletonable:  tableView.isSkeletonable)
                return cell
            }
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let item = Row.getSection(isPurchase: ticker.isPurchased, haveHistory: ticker.haveHistory)[indexPath.row]
        switch item {
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
        let row = Row.getSection(isPurchase: ticker.isPurchased, haveHistory: ticker.haveHistory)[indexPath.row]
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
        chartViewModel.isLoading = true
        ticker.loadNewChartData(period: period) {[weak self] in
            guard let self = self else {return}
            
            if !self.ticker.localChartData.onlyPoints().isEmpty && !self.ticker.localMedianData.onlyPoints().isEmpty {
                self.chartViewModel.min = Double(min(self.ticker.localMedianData.onlyPoints().min() ?? 0.0, self.ticker.localChartData.onlyPoints().min() ?? 0.0))
                self.chartViewModel.max = Double(max(self.ticker.localMedianData.onlyPoints().max() ?? 0.0, self.ticker.localChartData.onlyPoints().max() ?? 0.0))
            }
            
            if self.ticker.localMedianData.onlyPoints().isEmpty {
                self.chartViewModel.min = self.ticker.localChartData.onlyPoints().min() ?? 0.0
                self.chartViewModel.max = self.ticker.localChartData.onlyPoints().max() ?? 0.0
            }
            
            if self.chartViewModel.lastDayPrice != 0.0 && self.ticker.chartRange == .d1 {
                self.chartViewModel.min = min(Double(self.chartViewModel.min ?? 0.0), Double(self.chartViewModel.lastDayPrice))
                self.chartViewModel.max = max(Double(self.chartViewModel.max ?? 0.0), Double(self.chartViewModel.lastDayPrice))
            }
            
            self.chartViewModel.localTicker = self.ticker
            self.chartViewModel.chartData = self.ticker.localChartData
            self.chartViewModel.medianData = self.ticker.localMedianData
            self.delegate?.loadingState(started: false)
            self.chartViewModel.isLoading = false
            print("Thread \(Date()) loaded")
        }
    }
    func comparePressed() {
        delegate?.openCompareWithSelf(ticker: self.ticker)
    }
}

extension TickerDetailsDataSource: TickerDetailsAlternativeStocksViewCellDelegate {
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        delegate?.wlPressed(stock: stock, cell: cell)
    }
    
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
    func aboutExtended(isExtended: Bool) {
        self.isAboutExpanded = isExtended
    }
    func collectionSelected(collection: RemoteCollectionDetails) {
        delegate?.collectionSelected(collection: collection)
    }
}

extension TickerDetailsDataSource: TickerDetailsRecommendedViewCellDelegate {
    func requestOpenCollection(withID id: Int) {
        //self.delegate?.requestOpenCollection(withID: id)
    }
    
    func wrongIndPressed(isTicked: Bool) {
        self.delegate?.wrongIndPressed(isTicked: isTicked)
    }
}
