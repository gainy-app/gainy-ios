//
//  HomeDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import SkeletonView
import Apollo
import SwiftDate
import PureLayout

protocol HomeDataSourceDelegate: AnyObject {
    func altStockPressed(stock: AltStockTicker, isGainers: Bool)
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell)
    func articlePressed()
    func collectionSelected(collection: RemoteShortCollectionDetails)
}

final class HomeDataSource: NSObject {
    
    init(viewModel: HomeViewModel) {
        cellHeights[.index] = HomeIndexesTableViewCell.cellHeight
        cellHeights[.gainers] = HomeTickersTableViewCell.cellHeight
        cellHeights[.losers] = HomeTickersTableViewCell.cellHeight + 32.0
        cellHeights[.collections] = 376.0
        self.viewModel = viewModel
    }
    
    private weak var viewModel: HomeViewModel?
    
    //MARK: - Delegate
    weak var delegate: HomeDataSourceDelegate?
    
    //MARK: - Sections
    private let sectionsCount = 5
    
    enum Section: Int {
        case index = 0, collections, gainers, losers, articles
        
        var name: String {
            switch self {
            case .index:
                return ""
            case .collections:
                return "Updates in your collections"
            case .gainers:
                return "Top gainers in your collections"
            case .losers:
                return "Top loser in your collections"
            case .articles:
                return "Articles for you"
            }
        }
    }
    
    private var articles: [String] = []
    
    private var indexes: [HomeIndexViewModel] = []
    
    func updateIndexes(models: [HomeIndexViewModel]) {
        indexes = models
        if let cell = tableView?.visibleCells.first(where: {$0 is HomeIndexesTableViewCell}) as? HomeIndexesTableViewCell {
            cell.updateIndexes(models: models)
        }
    }
    
    //MARK: - Heights
    private var cellHeights: [Section: CGFloat] = [:]
    private var expandedCells: Set<String> = Set<String>()
    private weak var tableView: UITableView?
    private let refreshControl = LottieRefreshControl()

    //
}

extension HomeDataSource: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return HomeSkeletonTableViewCell.cellIdentifier
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.articles.rawValue {
            //return articles.count
            return 1
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView = tableView
        
        switch Section(rawValue: indexPath.section)! {
        case .index:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeIndexesTableViewCell.cellIdentifier, for: indexPath) as! HomeIndexesTableViewCell
            cell.updateIndexes(models: indexes)
            return cell
        case .gainers:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTickersTableViewCell.cellIdentifier, for: indexPath) as! HomeTickersTableViewCell
            cell.gainers = viewModel?.topGainers ?? []
            cell.delegate = self
            cell.isGainers = true
            return cell
        case .losers:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTickersTableViewCell.cellIdentifier, for: indexPath) as! HomeTickersTableViewCell
            cell.gainers = viewModel?.topLosers ?? []
            cell.delegate = self
            cell.isGainers = false
            return cell
        case .articles:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeArticlesTableViewCell.cellIdentifier, for: indexPath) as! HomeArticlesTableViewCell
            return cell
        case .collections:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionsTableViewCell.cellIdentifier, for: indexPath) as! HomeCollectionsTableViewCell
            cell.collections = viewModel?.favCollections ?? []
            return cell
        }
    }
}

extension HomeDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("\(indexPath.section) \(cellHeights[Section(rawValue: indexPath.section)!] ?? UITableView.automaticDimension)")
        return cellHeights[Section(rawValue: indexPath.section)!] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section)! {
        case .index:
            break
        case .gainers:
            break
        case .losers:
            break
        case .articles:
            delegate?.articlePressed()
            break
        default:
            break
        }
    }
    
    //MARK: - Headers
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor(named: "mainText")!
        headerLabel.font = .proDisplaySemibold(20)        
        headerLabel.text = Section(rawValue: section)!.name
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        headerView.addSubview(headerLabel)
        if section == Section.articles.rawValue {
            headerLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 0, left: 24, bottom: 16, right: 24))
        } else {
            headerLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 16, left: 24, bottom: 16, right: 24))
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == Section.index.rawValue {
            return 0.0
        } else {
            if section == Section.articles.rawValue {
                return 40.0
            } else {
                return 24.0 + 16.0 + 16
            }
        }
    }
}

extension HomeDataSource: HomeTickersTableViewCellDelegate {
    func altStockPressed(stock: AltStockTicker, cell: HomeTickersTableViewCell) {
        delegate?.altStockPressed(stock: stock, isGainers: cell.isGainers)
    }
    
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        delegate?.wlPressed(stock: stock, cell: cell)
    }
}

extension HomeDataSource: HomeCollectionsTableViewCellDelegate {
    func collectionSelected(collection: RemoteShortCollectionDetails) {
        delegate?.collectionSelected(collection: collection)
    }
}

