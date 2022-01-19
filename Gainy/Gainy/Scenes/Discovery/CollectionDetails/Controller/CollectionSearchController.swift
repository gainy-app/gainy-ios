//
//  CollectionSearchController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.08.2021.
//

import UIKit
import Apollo

enum SearchSection: Int, CaseIterable, Hashable {
    case loader = 0, stocks = 1, collections = 2, news = 3, suggestedCollection = 4
}

typealias SearchSource = UICollectionViewDiffableDataSource<SearchSection, AnyHashable>

final class CollectionSearchController: NSObject {
    
    weak var collectionView: UICollectionView?
    private var dataSource: SearchSource?
    var coordinator: MainCoordinator?
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    //UI updates
    var loading: ((Bool) -> Void)?
    var collectionsUpdated: (() -> Void)?
    var onShowCardDetails: (([RemoteTickerDetails], RemoteTickerDetails) -> Void)? = nil
    var onCollectionDelete: ((Int) -> Void)? = nil
    var onNewsClicked: ((URL) -> Void)? = nil
    
    var recommendedCollections: [RecommendedCollectionViewCellModel] {
        get {
            if searchText.isEmpty {
                return self.suggestedCollections
            }
            return []
        }
    }
    
    //Limits
    private let resultsLimit = 100
    private var localFavHash: String = UserProfileManager.shared.favHash
    
    init(collectionView: UICollectionView? = nil, callback: @escaping (([RemoteTickerDetails], RemoteTickerDetails) -> Void)) {
        self.collectionView = collectionView
        self.onShowCardDetails = callback
        super.init()
        
        self.reloadSuggestedCollections()
        
        if let collectionView = collectionView {
            
            //Registering the cells
            collectionView.register(UINib.init(nibName: "StockViewCell", bundle: nil), forCellWithReuseIdentifier: StockViewCell.cellIdentifier)
            collectionView.register(UINib.init(nibName: "NewsViewCell", bundle: nil), forCellWithReuseIdentifier: NewsViewCell.cellIdentifier)
            collectionView.register(UINib.init(nibName: "SearchLoadingCell", bundle: nil), forCellWithReuseIdentifier: SearchLoadingCell.cellIdentifier)
            collectionView.register(RecommendedCollectionViewCell.self)
            collectionView.register(UINib(nibName: "SearchCollectionHeaderView", bundle: nil),
                                    forSupplementaryViewOfKind: CollectionSearchController.sectionHeaderElementKind,
                                    withReuseIdentifier: SearchCollectionHeaderView.identifier)
            
            self.dataSource = SearchSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, object in
                switch self.sections[indexPath.section] {
                case .stocks:
                    let cell: StockViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    if self.stocks.count > 0 {
                        cell.ticker = self.stocks[indexPath.row] as? RemoteTickerDetails
                    }
                    return cell
                case .collections:
                    let cell: RecommendedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    if self.collections.count > 0, let collection = self.collections[indexPath.row] as? RemoteCollectionDetails {
                        
                        let buttonState: RecommendedCellButtonState = UserProfileManager.shared.favoriteCollections.contains(collection.id ?? 0)
                            ? .checked
                            : .unchecked
                        cell.tag = collection.id ?? 0
                        cell.configureWith(name: collection.name ?? "",
                                           imageUrl: collection.imageUrl ?? "",
                                           description: collection.description ?? "",
                                           stocksAmount: "\(collection.size ?? 0)",
                                           imageName: "",
                                           plusButtonState: buttonState)
                        
                        cell.onPlusButtonPressed = { [weak self] in                            
                            self?.mutateFavouriteCollections(senderCell: cell, isAdded: true, collectionID: collection.id ?? 0)
                        }
                        
                        cell.onCheckButtonPressed = { [weak self] in
                            self?.mutateFavouriteCollections(senderCell: cell, isAdded: false, collectionID: collection.id ?? 0)
                        }
                    }
                    return cell
                case .news:
                    let cell: NewsViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    if self.news.count > 0 {
                        cell.news = self.news[indexPath.row] as? DiscoverNewsQuery.Data.FetchNewsDatum
                    }
                    return cell
                case .loader:
                    let cell: SearchLoadingCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.activityIndicator.startAnimating()
                    return cell
                case .suggestedCollection:
                    let cell: RecommendedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    if self.recommendedCollections.count > 0 {
                        let collection = self.recommendedCollections[indexPath.row]
                        let buttonState: RecommendedCellButtonState = UserProfileManager.shared.favoriteCollections.contains(collection.id)
                            ? .checked
                            : .unchecked
                        cell.tag = collection.id ?? 0
                        cell.configureWith(name: collection.name,
                                           imageUrl: collection.imageUrl,
                                           description: collection.description,
                                           stocksAmount:collection.stocksAmount,
                                           imageName: "",
                                           plusButtonState: buttonState)
                        cell.onPlusButtonPressed = { [weak self] in
                            
                            self?.mutateFavouriteCollections(senderCell: cell, isAdded: true, collectionID: collection.id)
                        }
                        
                        cell.onCheckButtonPressed = { [weak self] in
                            
                            self?.mutateFavouriteCollections(senderCell: cell, isAdded: false, collectionID: collection.id)
                        }
                    }
                    return cell
                }
            })
            
            dataSource?.supplementaryViewProvider = { (view, kind, indexPath) in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: CollectionSearchController.sectionHeaderElementKind, withReuseIdentifier: SearchCollectionHeaderView.identifier, for: indexPath) as? SearchCollectionHeaderView
                switch self.sections[indexPath.section] {
                case .suggestedCollection:
                    headerView?.headerLbl.text = "RECOMMENDED COLLECTIONS (\(min(self.resultsLimit, self.suggestedCollections.count)))"
                case .stocks:
                    headerView?.headerLbl.text = "STOCKS (\(min(self.resultsLimit, self.stocks.count)))"
                case .collections:
                    headerView?.headerLbl.text = "SUGGESTED COLLECTIONS (\(min(self.resultsLimit, self.collections.count)))"
                case .news:
                    headerView?.headerLbl.text = "NEWS (\(min(self.resultsLimit, self.news.count)))"
                case .loader:
                    break
                }
                return headerView
            }
        }
    }
    
    //MARK: - Vars
    
    //SearchTickersQuery.Data.Ticker
    private var stocks: [AnyHashable] = []
    //SearchCollectionDetailsQuery.Data.AppCollection
    private var collections: [AnyHashable] = []
    //DiscoverNewsQuery.Data.FetchNewsDatum
    private var news: [AnyHashable] = []
    //
    
    private var suggestedCollections: [RecommendedCollectionViewCellModel] = []

    //Search
    private var searchBlock: DispatchWorkItem?
    
    //MARK: - API Calls
    
    private var networkCalls: [Cancellable] = []
    private var sections: [SearchSection] = []
    
    var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                //Cancel old requests
                networkCalls.forEach({$0.cancel()})
                networkCalls.removeAll()
                
                loading?(true)
                clearAll()
                
                //Search for new
                if searchBlock != nil {
                    searchBlock?.cancel()
                    searchBlock = nil
                }
                searchBlock = DispatchWorkItem.init { [weak self] in
                    guard let self = self else {return}
                    guard !self.searchText.isEmpty else {
                        return
                    }
                    
                    print("Searching \(Date())")
                    self.searchQuery(self.searchText)
                    GainyAnalytics.logEvent("collections_search_term", params: ["term" : self.searchText, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                }                
                DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5, execute: searchBlock!)
            } else {
                //Fetch recommended collections for the empty search term
                searchQuery(searchText)
            }
        }
    }
    
    func reloadSuggestedCollections() {
        
        UserProfileManager.shared.getProfileCollections(loadProfile: true) { success in
            if success {
                self.suggestedCollections = UserProfileManager.shared
                    .recommendedCollections
                    .map { CollectionViewModelMapper.map($0) }
            }
        }
    }
    
    func clearAll() {        
        self.stocks.removeAll()
        self.collections.removeAll()
        self.news.removeAll()
        runOnMain{
            self.performClearAll()
        }
    }
    
    func performClearAll() {
        
        if var snapshot = self.dataSource?.snapshot() {
            
            self.sections.removeAll()
            snapshot.deleteSections(snapshot.sectionIdentifiers)
            
            if !snapshot.sectionIdentifiers.contains(.loader) {
                snapshot.appendSections([.loader])
                self.sections.append(.loader)
            }
            if snapshot.itemIdentifiers(inSection: .loader).count == 0 {
                snapshot.appendItems(["loader"], toSection: .loader)
            }
            
            self.dataSource?.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    private let searchQueue = DispatchQueue.init(label: "CollectionSearchController.searchQuery")
    private func searchQuery(_ text: String) {
        dprint("SEARCH STARTED")
        clearAll()
        
        if text.count == 0 {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
                self.loading?(true)
                self.collectionView?.delegate = self
                if var snapshot = self.dataSource?.snapshot() {
                    
                    if snapshot.indexOfSection(.loader) != nil {
                        if snapshot.itemIdentifiers(inSection: .loader).count > 0 {
                            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .loader))
                        }
                    }
                    
                    if self.recommendedCollections.count > 0 {
                        
                        if !snapshot.sectionIdentifiers.contains(.suggestedCollection) {
                            snapshot.appendSections([.suggestedCollection])
                        }
                        self.sections.append(.suggestedCollection)
                        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .suggestedCollection))
                        snapshot.appendItems(Array(self.recommendedCollections.prefix(self.resultsLimit)), toSection: .suggestedCollection)
                    }
                    
                    self.collectionView?.collectionViewLayout = CollectionSearchController.createLayout(self.sections)
                    self.dataSource?.apply(snapshot, animatingDifferences: true)
                }
                self.loading?(false)
            }
            
            return
        }
        let dispatchGroup = DispatchGroup()
        
        //Searching for tickers
        dispatchGroup.enter()
        let tickersQuery = SearchTickersAlgoliaQuery.init(text: text)
        networkCalls.append(Network.shared.apollo.fetch(query: tickersQuery){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                let mappedTickers = (graphQLResult.data?.searchTickers ?? []).compactMap({$0?.ticker.fragments.remoteTickerDetails})
                self?.stocks = mappedTickers
                
                for tickLivePrice in mappedTickers.compactMap({$0.realtimeMetrics}) {
                    TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
                }
                dispatchGroup.leave()
                
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        })
        
        //Searching for news
        dispatchGroup.enter()
        let newsQuery = DiscoverNewsQuery.init(symbol: text)
        networkCalls.append(Network.shared.apollo.fetch(query: newsQuery){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                self?.news = (graphQLResult.data?.fetchNewsData ?? []).uniqued()
                dispatchGroup.leave()
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        })
        
        // Searching for collections
        dispatchGroup.enter()
        let collectionsQuery = SearchCollectionDetailsAlgoliaQuery.init(text: text)
        networkCalls.append(Network.shared.apollo.fetch(query: collectionsQuery){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                let mappedCollections = (graphQLResult.data?.searchCollections ??  []).compactMap({$0?.collection.fragments.remoteCollectionDetails})
                self?.collections = mappedCollections
                
//                for tickLivePrice in mappedCollections.compactMap({$0.tickerCollections.compactMap({$0.ticker?.fragments.remoteTickerDetails.realtimeMetrics})}).flatMap({$0}) {
//                    TickerLiveStorage.shared.setSymbolData(tickLivePrice.symbol ?? "", data: tickLivePrice)
//                }
                
                dispatchGroup.leave()
                break
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        })
        
        dispatchGroup.notify(queue: searchQueue) {
            dprint("SEARCH ENDED")
            dprint("\(self.stocks.count) \(self.collections.count) \(self.news.count)")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
                self.collectionView?.delegate = self
                if var snapshot = self.dataSource?.snapshot() {
                    
                    if snapshot.indexOfSection(.loader) != nil {
                        if snapshot.itemIdentifiers(inSection: .loader).count > 0 {
                            snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .loader))
                        }
                    }
                    
                    if self.stocks.count > 0 {
                        
                        if !snapshot.sectionIdentifiers.contains(.stocks) {
                            snapshot.appendSections([.stocks])
                        }
                        self.sections.append(.stocks)
                        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .stocks))
                        snapshot.appendItems(Array(self.stocks.prefix(self.resultsLimit)), toSection: .stocks)
                    }
                    
                    if self.collections.count > 0 {
                        if !snapshot.sectionIdentifiers.contains(.collections) {
                            snapshot.appendSections([.collections])
                        }
                        self.sections.append(.collections)
                        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .collections))
                        snapshot.appendItems(Array(self.collections.prefix(self.resultsLimit)), toSection: .collections)
                    }
                    
                    if self.news.count > 0 {
                        if !snapshot.sectionIdentifiers.contains(.news) {
                            snapshot.appendSections([.news])
                        }
                        self.sections.append(.news)
                        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .news))
                        snapshot.appendItems(Array(self.news.prefix(self.resultsLimit)), toSection: .news)
                    }
                    self.collectionView?.collectionViewLayout = CollectionSearchController.createLayout(self.sections)
                    self.dataSource?.apply(snapshot, animatingDifferences: true)
                }
                self.loading?(false)
            }
        }
    }
    
}


extension CollectionSearchController {
    /// - Tag: Adaptive
    static func createLayout(_ sections: [SearchSection]) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let firstSectionRowHeight: CGFloat = 68.0
            let layoutKind =  sections[sectionIndex]
            
            //WARNING: A lot of hardcoded values for cells
            if layoutKind == .loader {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                     heightDimension: .absolute(100)))
                item.contentInsets = .zero
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: NSCollectionLayoutDimension.absolute(100))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .zero
                return section
            }
            if layoutKind == .stocks {
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                     heightDimension: .absolute(firstSectionRowHeight)))
                item.contentInsets = .init(top: 0, leading: 23, bottom: 0, trailing: 0)
                let item1 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                      heightDimension: .absolute(firstSectionRowHeight)))
                item1.contentInsets = .init(top: 0, leading: 23, bottom: 0, trailing: 0)
                let item2 = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                      heightDimension: .absolute(firstSectionRowHeight)))
                item2.contentInsets = .init(top: 0, leading: 23, bottom: 0, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                       heightDimension: NSCollectionLayoutDimension.absolute(firstSectionRowHeight * 3.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item, item1, item2])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .zero
                section.orthogonalScrollingBehavior = .groupPaging
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(14.0)),
                    elementKind: CollectionSearchController.sectionHeaderElementKind,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
            
            if layoutKind == .collections {
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(109),
                                                      heightDimension: .absolute(144))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(109),
                                                       heightDimension: NSCollectionLayoutDimension.absolute(144))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .zero
                section.orthogonalScrollingBehavior = .continuous
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(16.0 + 12.0 + 16.0)),
                    elementKind: CollectionSearchController.sectionHeaderElementKind,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
            
            if layoutKind == .suggestedCollection {
                let defaultOffset = 16.0
                let width = (UIScreen.main.bounds.width - defaultOffset * 3.0) / 3.0
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width),
                                                      heightDimension: .absolute(144))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: NSCollectionLayoutDimension.absolute(144))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
                section.orthogonalScrollingBehavior = .none
                
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .estimated(16.0 + 12.0 + 16.0)),
                    elementKind: CollectionSearchController.sectionHeaderElementKind,
                    alignment: .top)
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                  heightDimension: .absolute(136))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 2)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                   heightDimension: NSCollectionLayoutDimension.absolute(136))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .zero
            section.orthogonalScrollingBehavior = .continuous
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(16.0 + 12.0 + 16.0)),
                elementKind: CollectionSearchController.sectionHeaderElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        return layout
    }
}


extension CollectionSearchController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.sections[indexPath.section] {
        case .stocks:
            if let ticker = self.stocks[indexPath.row] as? RemoteTickerDetails {
                GainyAnalytics.logEvent("collections_search_ticker_pressed", params: ["tickerSymbol" : ticker.symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                onShowCardDetails?(stocks.compactMap({$0 as? RemoteTickerDetails}), ticker)
            }
            break
        case .collections:
            if let collection = self.collections[indexPath.row] as? RemoteCollectionDetails{
                GainyAnalytics.logEvent("collections_search_collection_pressed", params: ["collectionId" : collection.id, "ec" : "CollectionDetails"])
                localFavHash = UserProfileManager.shared.favHash
                coordinator?.showCollectionDetails(collectionID: collection.id ?? 0, delegate:  self)
            }
            break
        case .suggestedCollection:
            let collection = self.recommendedCollections[indexPath.row]
            GainyAnalytics.logEvent("coll_search_rec_coll_pressed", params: ["collectionId" : collection.id, "ec" : "CollectionDetails"])
            localFavHash = UserProfileManager.shared.favHash
            coordinator?.showCollectionDetails(collectionID: collection.id, delegate:  self)
            
            break
        case .news:
            if let news = self.news[indexPath.row] as? DiscoverNewsQuery.Data.FetchNewsDatum {
                if let url = URL(string: GainyAnalytics.shared.addInfoToURLString(news.url ?? "")) {
                    onNewsClicked?(url)
                    GainyAnalytics.logEvent("collections_search_news_pressed", params: ["newsID" : news.title, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                }
            }
            break
        case .loader:
            break
        }
    }
}

extension CollectionSearchController: SingleCollectionDetailsViewControllerDelegate {
    
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        
        self.mutateFavouriteCollections(senderCell: nil, isAdded: isAdded, collectionID: collectionID)
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        compareHashes()
    }
    
    fileprivate func compareHashes() {
        if UserProfileManager.shared.favHash != localFavHash {
            collectionsUpdated?()
        }
    }
    
    private func mutateFavouriteCollections(senderCell: RecommendedCollectionViewCell? = nil, isAdded: Bool, collectionID: Int) {
        
        if isAdded {
            if !UserProfileManager.shared.favoriteCollections.contains(collectionID) {
                UserProfileManager.shared.addFavouriteCollection(collectionID) { success in
                    if let cell = senderCell {
                        cell.setButtonChecked(isChecked: success)
                    }
                    self.collectionsUpdated?()
                }
                CollectionsManager.shared.loadNewCollectionDetails(collectionID) {
                    
                }
            }
        } else {
            if let _ = UserProfileManager.shared.favoriteCollections.firstIndex(of: collectionID) {
                UserProfileManager.shared.removeFavouriteCollection(collectionID) { success in
                    if let cell = senderCell {
                        cell.setButtonChecked(isChecked: !success)
                    }
                    self.collectionsUpdated?()
                }
                onCollectionDelete?(collectionID)
            }
        }
    }
}

