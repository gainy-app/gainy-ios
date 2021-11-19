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
    
    var holdings: [GetPlaidHoldingsQuery.Data.GetPortfolioHolding] = [] {
        didSet {
            guard holdings.count > 0 else {return}
            for ind in 0..<holdings.count {
                cellHeights[ind] = HoldingTableViewCell.heightWithEvents
            }
        }
    }
    var transactions: [GetPlaidTransactionsQuery.Data.GetPortfolioTransaction] = []
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
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HoldingTableViewCell.cellIdentifier, for: indexPath) as! HoldingTableViewCell
            cell.holding = holdings[indexPath.row]
            cell.cellHeightChanged = {[weak self] newHeight in
                tableView.beginUpdates()
                self?.cellHeights[indexPath.row] = newHeight
                tableView.endUpdates()
            }
            return cell
        }
    }
}

extension HoldingsDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.sk.isSkeletonActive ? 252.0 : 44.0
        } else {
            return cellHeights[indexPath.row] ?? 0.0
        }
    }
}
