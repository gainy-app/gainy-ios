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
}

final class HoldingsDataSource: NSObject {
    
    weak var delegate: HoldingsDataSourceDelegate?
    
    private let sectionsCount = 2
    
    private var cellHeights: [Int: CGFloat] = [:]
    private var expandedCells: Set<String> = Set<String>()
    private weak var tableView: UITableView?
    
    var chartRange: ScatterChartView.ChartPeriod = .d1
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
        holdings = originalHoldings.sortedAndFilter(by: settings)
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
        if section == 0 {
            return 1
        } else {
            return holdings.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView = tableView
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HoldingChartTableViewCell.cellIdentifier, for: indexPath)
            if cell.addSwiftUIIfPossible(chartHosting.view) {
                chartHosting.view.autoSetDimension(.height, toSize: chartHeight)
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell, withOffset: 0)
                chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell)
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HoldingTableViewCell.cellIdentifier, for: indexPath) as! HoldingTableViewCell
            cell.setModel(holdings[indexPath.row], chartRange)
            cell.isExpanded = expandedCells.contains(holdings[indexPath.row].name)
            cell.cellHeightChanged = {[weak self] model in
                guard let self = self else {return}
                if let index = self.holdings.first(where: {$0 == model}) {
                    
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
    }
}

extension HoldingsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.sk.isSkeletonActive ? 252.0 : chartHeight
        } else {
            return cellHeights[indexPath.row] ?? 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let stock = holdings[indexPath.row].rawTicker {
            delegate?.stockSelected(source: self, stock: stock)
        }
    }
}

extension HoldingsDataSource: HoldingScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod, viewModel: HoldingChartViewModel) {
        chartRange = period
        if let rangeData = profileGains[period] {
            viewModel.chartData = rangeData.chartData
            viewModel.rangeGrow = rangeData.rangeGrow
            viewModel.rangeGrowBalance = rangeData.rangeGrowBalance
            viewModel.spGrow = rangeData.spGrow
            viewModel.sypChartData = rangeData.sypChartData
        }
        
        tableView?.reloadSections(IndexSet.init(integer: 1), with: .automatic)
    }
    
    func comparePressed() {
        
    }
}

