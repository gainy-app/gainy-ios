//
//  HoldingsDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit
import SkeletonView
import Apollo
import SwiftDate

protocol HoldingsDataSourceDelegate: AnyObject {
    func stockSelected(source: HoldingsDataSource, stock: RemoteTickerDetailsFull)
    func chartsForRangeRequested(range: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel)
    func requestOpenCollection(withID id: Int)
    func scrollChanged(_ offsetY: CGFloat)
    
    func onSortButtonTapped()
    func onSettingsButtonTapped()
    
    func onConnectButtonTapped()
}

final class HoldingsDataSource: NSObject {
    
    weak var delegate: HoldingsDataSourceDelegate?
    
    private var userClosedReauth: Bool = false
    private var needReauth: Bool {
        if userClosedReauth {
            return false
        }
        
        let result = UserProfileManager.shared.linkedPlaidAccounts.compactMap { item in
            item.needReauthSince
        }.count > 0
        
        return result
    }
    
    private var sectionsCount: Int {
        
        return self.needReauth ? 3 : 2
    }
    
    private var cellHeights: [Int: CGFloat] = [:]
    private var expandedCells: Set<String> = Set<String>()
    private weak var tableView: UITableView?
    private let refreshControl = LottieRefreshControl()
    
    var chartRange: ScatterChartView.ChartPeriod = .d1
    var settings: PortfolioSettings?
    var originalHoldings: [HoldingViewModel] = []
    var holdings: [HoldingViewModel] = [] {
        didSet {
            guard holdings.count > 0 else {return}
            expandedCells.removeAll()
            for ind in 0..<holdings.count {
                cellHeights[ind] = holdings[ind].heightForState(range: chartRange, isExpaned: false)
            }
        }
    }
    var profileGains: [ScatterChartView.ChartPeriod: PortfolioChartGainsViewModel] = [:]
    
    
    func sortAndFilterHoldingsBy(_ settings: PortfolioSettings) {
        self.settings = settings
        holdings = originalHoldings.sortedAndFilter(by: settings, chartRange: self.chartRange)
    }
    
    //MARK: - Charts
    private let chartHeight: CGFloat = 360.0
    
    private static let emptyData: [Float] = []
    var chartViewModel: HoldingChartViewModel = HoldingChartViewModel.init(balance: 0.0, rangeGrow: 0.0, rangeGrowBalance: 0.0, spGrow: 0.0, chartData: ChartData(points: HoldingsDataSource.emptyData), sypChartData: ChartData(points: HoldingsDataSource.emptyData))
    private lazy var chartHosting: CustomHostingController<PortfolioScatterChartView> = {
        var rootView = PortfolioScatterChartView(viewModel: chartViewModel,
                                                 delegate: chartDelegate)
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: rootView)
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        return chartHosting
    }()
    
    
    //MARK: - Updating UI
    
    func updateChart() {
        //        chartViewModel.ticker = ticker.ticker
        //        chartViewModel.localTicker = ticker
        //        chartViewModel.chartData = ticker.localChartData
    }
    
    private lazy var chartDelegate: HoldingScatterChartDelegate = {
        let delegateObject =  HoldingScatterChartDelegate()
        delegateObject.delegate = self
        return delegateObject
    }()
    
}

extension HoldingsDataSource: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HoldingsSkeletonTableViewCell.cellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.dequeueReusableCell(withIdentifier: HoldingsSkeletonTableViewCell.cellIdentifier, for: indexPath) as? HoldingsSkeletonTableViewCell
        cell?.isSkeletonable = true
        cell?.contentView.subviews[0].subviews.forEach({
            $0.isSkeletonable = true
            $0.skeletonCornerRadius = 6
            if let lbl =  $0 as? UILabel {
                lbl.linesCornerRadius = 6
            }
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == self.sectionsCount - 1 {
            return holdings.count
        }
        
        if section == 0 {
            return 2
        }
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView = tableView
        if indexPath.section == self.sectionsCount - 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HoldingTableViewCell.cellIdentifier, for: indexPath) as! HoldingTableViewCell
            cell.delegate = self
            cell.setModel(holdings[indexPath.row], chartRange)
            cell.isExpanded = expandedCells.contains(holdings[indexPath.row].name)
            cell.cellHeightChanged = {[weak self] model in
                guard let self = self else {return}
                if let _ = self.holdings.first(where: {$0 == model}) {
                    
                    if self.expandedCells.contains(model.name) {
                        self.expandedCells.remove(model.name)
                    } else {
                        self.expandedCells.insert(model.name)
                    }
                    
                    tableView.beginUpdates()
                    self.cellHeights[indexPath.row] = model.heightForState(range: self.chartRange,
                                                                           isExpaned: self.expandedCells.contains(model.name))
                    tableView.endUpdates()
                    
                    cell.isExpanded = self.expandedCells.contains(model.name)
                }
            }
            return cell
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: HoldingChartTableViewCell.cellIdentifier, for: indexPath) as! HoldingChartTableViewCell
                if cell.addSwiftUIIfPossible(chartHosting.view) {
                    chartHosting.view.autoSetDimension(.height, toSize: chartHeight)
                    chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell)
                    chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell, withOffset: 0)
                    chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell)
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: HoldingsSettingsTableViewCell.cellIdentifier, for: indexPath) as! HoldingsSettingsTableViewCell
                cell.updateButtons()
                cell.delegate = self
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HoldingNeedReconnectPlaidTableViewCell.cellIdentifier, for: indexPath) as! HoldingNeedReconnectPlaidTableViewCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.delegate = self
            return cell
        }
    }
}

extension HoldingsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == self.sectionsCount - 1 {
            return cellHeights[indexPath.row] ?? 0.0
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return tableView.sk.isSkeletonActive ? 252.0 : 426.0 - 8.0 - 48.0
            } else {
                return tableView.sk.isSkeletonActive ? 252.0 : 24.0 + 48.0
            }
        } else {
            return 120.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == (self.sectionsCount - 1) else {return}
        if let stock = holdings[indexPath.row].rawTicker {
            let symbol = stock.fragments.remoteTickerDetails.symbol ?? ""
            guard !symbol.hasSuffix(".CC") else {
                return
            }
            delegate?.stockSelected(source: self, stock: stock)
            GainyAnalytics.logEvent("portfolio_ticker_pressed", params: [
                "tickerSymbol" : stock.fragments.remoteTickerDetails.symbol,
                "tickerName" : stock.fragments.remoteTickerDetails.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "HoldingsViewController"])
        }
    }
}

extension HoldingsDataSource: HoldingScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel) {
        chartRange = period
        if let settings = self.settings {
            self.sortAndFilterHoldingsBy(settings)
        }
        if let rangeData = profileGains[period] {
            
            
            if !rangeData.chartData.onlyPoints().isEmpty && !rangeData.sypChartData.onlyPoints().isEmpty  {
                viewModel.min = Double(min(rangeData.sypChartData.onlyPoints().min() ?? 0.0, rangeData.chartData.onlyPoints().min() ?? 0.0))
                viewModel.max = Double(max(rangeData.sypChartData.onlyPoints().max() ?? 0.0, rangeData.chartData.onlyPoints().max() ?? 0.0))
            }
            
            if rangeData.sypChartData.onlyPoints().isEmpty {
                viewModel.min = rangeData.chartData.onlyPoints().min() ?? 0.0
                viewModel.max = rangeData.chartData.onlyPoints().max() ?? 0.0
            }
            
            //            if viewModel.lastDayPrice != 0.0 && period == .d1 {
            //                viewModel.min = min(Double(viewModel.min ?? 0.0), Double(viewModel.lastDayPrice))
            //                viewModel.max = max(Double(viewModel.max ?? 0.0), Double(viewModel.lastDayPrice))
            //            }
            
            viewModel.chartData = rangeData.chartData
            viewModel.rangeGrow = rangeData.rangeGrow
            viewModel.rangeGrowBalance = rangeData.rangeGrowBalance
            viewModel.spGrow = rangeData.spGrow
            viewModel.sypChartData = rangeData.sypChartData
        } else {
            //Load for this range
            delegate?.chartsForRangeRequested(range: period,
                                              viewModel: viewModel)
        }
        
        tableView?.reloadSections(IndexSet.init(integer: 1), with: .automatic)
    }
    
    func comparePressed() {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollChanged(scrollView.contentOffset.y)
    }
}

extension HoldingsDataSource: HoldingTableViewCellDelegate {
    
    func requestOpenCollection(withID id: Int) {
        
        self.delegate?.requestOpenCollection(withID: id)
    }
}

extension HoldingsDataSource: HoldingsSettingsTableViewCellDelegate {
    func onSortButtonTapped() {
        delegate?.onSortButtonTapped()
    }
    
    func onSettingsButtonTapped() {
        delegate?.onSettingsButtonTapped()
    }
}

extension HoldingsDataSource: HoldingNeedReconnectPlaidTableViewCellDelegate {
    func onConnectButtonTapped() {
        delegate?.onConnectButtonTapped()
    }
    
    func onCloseButtonTapped() {
        userClosedReauth = true
        tableView?.reloadData()
    }
}
