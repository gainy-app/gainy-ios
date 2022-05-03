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
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell)
    func articlePressed(article: WebArticle)
    func collectionSelected(collection: RemoteShortCollectionDetails)
    func tickerSelected(ticker: RemoteTicker)
}

final class HomeDataSource: NSObject {
    
    init(viewModel: HomeViewModel) {
        cellHeights[.index] = HomeIndexesTableViewCell.cellHeight
        self.viewModel = viewModel
    }
    
    private weak var viewModel: HomeViewModel?
    
    //MARK: - Delegate
    weak var delegate: HomeDataSourceDelegate?
    
    //MARK: - Sections
    private let sectionsCount = 5
    
    enum Section: Int {
        case index = 0, collections, watchlist, articles
        
        var name: String {
            switch self {
            case .index:
                return ""
            case .collections:
                return "Updates in TTF"
            case .watchlist:
                return "Watchlist"
            case .articles:
                return "Articles for you"
            }
        }
    }
    
    private var articles: [WebArticle] = []
    
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
            return viewModel?.articles.count ?? 0
        } else {
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableView.sk.isSkeletonActive ? 1 : sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView = tableView
        
        switch Section(rawValue: indexPath.section)! {
        case .index:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeIndexesTableViewCell.cellIdentifier, for: indexPath) as! HomeIndexesTableViewCell
            cell.updateIndexes(models: indexes)
            cell.gains = viewModel?.gains
            return cell
        case .watchlist:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWatchlistTableViewCell.cellIdentifier, for: indexPath) as! HomeWatchlistTableViewCell
            cell.heightUpdated = {[weak self] newHeight in
                self?.tableView?.beginUpdates()
                self?.cellHeights[.watchlist] = newHeight
                self?.tableView?.endUpdates()
            }
            cell.watchlist = viewModel?.watchlist ?? []
            cell.delegate = self
            return cell
        case .articles:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeArticlesTableViewCell.cellIdentifier, for: indexPath) as! HomeArticlesTableViewCell
            cell.article = viewModel?.articles[indexPath.row]
            return cell
        case .collections:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeCollectionsTableViewCell.cellIdentifier, for: indexPath) as! HomeCollectionsTableViewCell
            cell.heightUpdated = {[weak self] newHeight in
                self?.tableView?.beginUpdates()
                self?.cellHeights[.collections] = newHeight
                self?.tableView?.endUpdates()
            }
            cell.collections = viewModel?.favCollections ?? []
            cell.delegate = self
            return cell
        }
    }
}

extension HomeDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView.sk.isSkeletonActive {
            return HomeSkeletonTableViewCell.cellHeight
        }
        let section = Section(rawValue: indexPath.section)!
        if section == .index {
            return viewModel?.gains == nil ? HomeIndexesTableViewCell.smallCellHeight : HomeIndexesTableViewCell.cellHeight
        }
        if section == .watchlist && (viewModel?.watchlist.isEmpty ?? true) {
            return 0.0
        }
        return cellHeights[Section(rawValue: indexPath.section)!] ?? UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Section(rawValue: indexPath.section)! {
        case .index:
            break
        case .watchlist:
            break
        case .articles:
            if let article = viewModel?.articles[indexPath.row] {
                delegate?.articlePressed(article: article)
            }
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell:
    UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HomeArticlesTableViewCell {
            cell.coverImgView.kf.cancelDownloadTask()
        }
    }
    
    //MARK: - Headers
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionType = Section(rawValue: section)!
        if sectionType == .collections && (viewModel?.favCollections.isEmpty ?? true) {
            return nil
        }
        if sectionType == .watchlist && (viewModel?.watchlist.isEmpty ?? true) {
            return nil
        }
        
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor(named: "mainText")!
        headerLabel.font = .proDisplaySemibold(20)        
        headerLabel.text = Section(rawValue: section)!.name
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        headerView.addSubview(headerLabel)
        if section == Section.articles.rawValue || section == Section.watchlist.rawValue{
            headerLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 0, left: 24, bottom: 16, right: 24))
        } else {
            headerLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 0, left: 24, bottom: 16, right: 24))
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == Section.index.rawValue {
            return 0.0
        } else {
            let sectionType = Section(rawValue: section)!
            if sectionType == .collections && (viewModel?.favCollections.isEmpty ?? true) {
                return 0.0
            }
            if sectionType == .watchlist && (viewModel?.watchlist.isEmpty ?? true) {
                return 0.0
            }
            
            return 40.0
        }
    }
}

extension HomeDataSource: HomeTickersTableViewCellDelegate {
    
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        delegate?.wlPressed(stock: stock, cell: cell)
    }
}

extension HomeDataSource: HomeCollectionsTableViewCellDelegate {
    func collectionSelected(collection: RemoteShortCollectionDetails) {
        delegate?.collectionSelected(collection: collection)
    }
}

extension HomeDataSource: HomeWatchlistTableViewCellDelegate {
    func tickerSelected(ticker: RemoteTicker) {
        delegate?.tickerSelected(ticker: ticker)
    }
}

