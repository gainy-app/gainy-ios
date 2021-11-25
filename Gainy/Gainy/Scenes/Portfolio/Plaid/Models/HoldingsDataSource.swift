//
//  HoldingsDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit
import SkeletonView
import Apollo

final class HoldingsDataSource: NSObject {
    private let sectionsCount = 2
    
    private var cellHeights: [Int: CGFloat] = [:]
    private var expandedCells: Set<String> = Set<String>()
    
    var chartRange: ScatterChartView.ChartPeriod = .d1
    var holdings: [HoldingViewModel] = [] {
        didSet {
            guard holdings.count > 0 else {return}
            expandedCells.removeAll()
            for ind in 0..<holdings.count {
                cellHeights[ind] = holdings[ind].heightForState(range: chartRange, isExpaned: false)
            }
        }
    }
    
    //MARK: - Charts
    private let cellHeight: CGFloat = 360.0
    
    private(set) var chartViewModel: HoldingChartViewModel!
    private lazy var chartHosting: CustomHostingController<PortfolioScatterChartView> = {
        
        chartViewModel = HoldingChartViewModel.init(balance: 156225, rangeName: "Today", rangeGrow: 12.05, rangeGrowBalance: 2228.50, spGrow: 1.13, chartData: ChartData.init(points: [32, 45, 56, 32, 20, 15, 25, 35, 45, 60, 50, 40]))
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
    
    private lazy var chartDelegate: ScatterChartDelegate = {
        let delegateObject =  ScatterChartDelegate()
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HoldingChartTableViewCell.cellIdentifier, for: indexPath)
            if cell.addSwiftUIIfPossible(chartHosting.view) {
                chartHosting.view.autoSetDimension(.height, toSize: cellHeight)
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell)
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
            return tableView.sk.isSkeletonActive ? 252.0 : cellHeight
        } else {
            return cellHeights[indexPath.row] ?? 0.0
        }
    }
}

extension HoldingsDataSource: ScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod) {
        
    }
}
