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
    func tickerSortCollectionsPressed()
    func tickerSortWLPressed()
    func topTickerTapped(symbol: String)
    func balanceTapped()
    func collectionMoved(from fromIndex: Int, to toIndex: Int)
    func collectionDeleted()
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
    private let sectionsCount = 4
    
    enum Section: Int {
        case index = 0, collections, watchlist, articles
        
        var name: String {
            switch self {
            case .index:
                return ""
            case .collections:
                return "Updates in your TTFs"
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
    private var watchlistExpanded = false
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
            //cell.bottomDots.isHidden = (viewModel?.gains == nil)
            cell.delegate = self
            return cell
        case .watchlist:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeWatchlistTableViewCell.cellIdentifier, for: indexPath) as! HomeWatchlistTableViewCell
            cell.heightUpdated = {[weak self] newHeight in
                UIView.setAnimationsEnabled(false)
                self?.tableView?.beginUpdates()
                self?.cellHeights[.watchlist] = newHeight
                self?.tableView?.endUpdates()
                UIView.setAnimationsEnabled(true)
            }
            cell.sortingPressed = {[weak self] in
                self?.sortWatchlistTapped()
            }
            cell.expandPressed = {[weak self] in
                self?.watchlistExpanded = !cell.expandBtn.isSelected
            }
            cell.expandBtn.isSelected = !watchlistExpanded
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
        
        if section == .collections && (viewModel?.favCollections.isEmpty ?? true) {
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
        if sectionType == .watchlist {
            let view: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 24.0))
            view.backgroundColor = UIColor.clear
            return view
        }
        
        let headerLabel = UILabel()
        headerLabel.textColor = UIColor(named: "mainText")!
        headerLabel.font = .proDisplaySemibold(20)
        headerLabel.text = sectionType.name
        
        let subHeaderLabel = UILabel()
        subHeaderLabel.textColor = UIColor(named: "mainText")!
        subHeaderLabel.font = .proDisplayMedium(16)
        subHeaderLabel.text = "Tap to see details, drag&drop to organise,\nswipe left to delete"
        subHeaderLabel.numberOfLines = 2
        
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 40.0))
        headerView.backgroundColor = .clear
        
        headerView.addSubview(headerLabel)
        
        //headerLabel.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 20, left: 24, bottom: 16, right: 180))
        if section == Section.collections.rawValue {
            headerLabel.autoPinEdge(.top, to: .top, of: headerView)
            headerLabel.autoPinEdge(.right, to: .right, of: headerView)
        } else {
            headerLabel.autoPinEdge(.bottom, to: .bottom, of: headerView, withOffset: -16)
            headerLabel.autoPinEdge(.right, to: .right, of: headerView, withOffset: -180)
        }
        headerLabel.autoPinEdge(.left, to: .left, of: headerView, withOffset: 24)
        
        headerLabel.autoAlignAxis(.horizontal, toSameAxisOf: headerLabel)
        
        if section == Section.collections.rawValue {
            headerView.addSubview(subHeaderLabel)
            subHeaderLabel.autoPinEdge(.top, to: .bottom, of: headerLabel, withOffset: 16)
            subHeaderLabel.autoPinEdge(.left, to: .left, of: headerView, withOffset: 24)
            subHeaderLabel.autoPinEdge(.right, to: .right, of: headerView, withOffset: -20)
        }
        
        let buttonWithLabel: (ResponsiveButton, UILabel) = self.newSortByButton()
        let button = buttonWithLabel.0
        let sortLabel = buttonWithLabel.1
        if section == Section.watchlist.rawValue {
            button.addTarget(self, action: #selector(sortWatchlistTapped), for: .touchUpInside)
            let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(Constants.CollectionDetails.watchlistCollectionID)
            sortLabel.text = settings.sortingText()
            sortLabel.sizeToFit()
        } else if section == Section.collections.rawValue, let profileID = UserProfileManager.shared.profileID {
            button.addTarget(self, action: #selector(sortCollectionsTapped), for: .touchUpInside)
            let settings: CollectionsSortingSettings = CollectionsSortingSettingsManager.shared.getSettingByID(profileID)
            if UserProfileManager.shared.collectionsReordered {
                sortLabel.text = "Custom"
            } else {
                sortLabel.text = settings.sorting.title
            }
            sortLabel.sizeToFit()
        }
        
        if section != Section.articles.rawValue {
            headerView.addSubview(button)
            
            if section == Section.collections.rawValue {
                button.autoPinEdge(.bottom, to: .bottom, of: headerView, withOffset: -16)
                button.autoPinEdge(.left, to: .left, of: headerView, withOffset: 24)
            } else {
                button.autoPinEdge(.right, to: .right, of: headerView, withOffset: -24.0)
                button.autoAlignAxis(.horizontal, toSameAxisOf: headerLabel)
            }
            
            button.autoSetDimension(.height, toSize: 24.0)
            button.sizeToFit()
        }
        return headerView
    }
    
    @objc private func sortCollectionsTapped() {
        
        delegate?.tickerSortCollectionsPressed()
    }
    
    @objc private func sortWatchlistTapped() {
        
        delegate?.tickerSortWLPressed()
    }
    
    func newSortByButton() -> (ResponsiveButton, UILabel) {
        let button = ResponsiveButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.cornerCurve = .continuous
        button.fillRemoteButtonBack()
        
        let reorderIconImageView = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 16, height: 16)
        )
        reorderIconImageView.image = UIImage(named: "reorder")
        button.addSubview(reorderIconImageView)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        reorderIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        
        let sortByLabel = UILabel(
            frame: CGRect(x: 0, y: 0, width: 36, height: 16)
        )
        
        sortByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        sortByLabel.textColor = UIColor.Gainy.grayNotDark
        sortByLabel.numberOfLines = 1
        sortByLabel.textAlignment = .center
        sortByLabel.text = "Sort by"
        
        button.addSubview(sortByLabel)
        sortByLabel.autoSetDimensions(to: CGSize.init(width: 36, height: 16))
        sortByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        sortByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        
        let textLabel = UILabel(
            frame: CGRect(x: 0, y: 0, width: 77, height: 16)
        )
        
        textLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        textLabel.textColor = UIColor.Gainy.grayNotDark
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = "Watchlist"
        textLabel.minimumScaleFactor = 0.1
        button.addSubview(textLabel)
        textLabel.autoSetDimension(.height, toSize: 16)
        textLabel.autoPinEdge(.left, to: .right, of: sortByLabel, withOffset: 2.0)
        textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        textLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        textLabel.sizeToFit()
        
        return (button, textLabel)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == Section.index.rawValue {
            return 0.0
        } else {
            let sectionType = Section(rawValue: section)!
            if sectionType == .collections {
                if (viewModel?.favCollections.isEmpty ?? true) {
                    return 0.0
                } else {
                    return 60.0 + 48.0 + 32.0
                }
            }
            if sectionType == .watchlist {
                return 24.0
            }
            
            return 60.0
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
    func collectionMoved(collection: RemoteShortCollectionDetails, from fromIndex: Int, to toIndex: Int) {
        delegate?.collectionMoved(from: fromIndex, to: toIndex)
    }
    func collectionDeleted(collection: RemoteShortCollectionDetails, collectionID: Int) {
        delegate?.collectionDeleted()
    }
}

extension HomeDataSource: HomeWatchlistTableViewCellDelegate {
    func tickerSelected(ticker: RemoteTicker) {
        delegate?.tickerSelected(ticker: ticker)
    }
}

extension HomeDataSource: HomeIndexesTableViewCellDelegate {
    func tickerTapped(cell: HomeIndexesTableViewCell?, symbol: String) {
        delegate?.topTickerTapped(symbol: symbol)
    }
    
    func balanceTapped(cell: HomeIndexesTableViewCell?) {
        delegate?.balanceTapped()
    }
}

