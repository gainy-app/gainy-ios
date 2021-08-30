//
//  CollectionSearchController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.08.2021.
//

import UIKit
import Apollo

enum SearchSection: Int, CaseIterable, Hashable {
    case loader = 0, stocks = 1, collections = 2, news = 3
}

typealias SearchSource = UICollectionViewDiffableDataSource<SearchSection, AnyHashable>

final class CollectionSearchController: NSObject {
    
    weak var collectionView: UICollectionView?
    private var dataSource: SearchSource?
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    //UI updates
    var loading: ((Bool) -> Void)?
    var onShowCardDetails: ((DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker) -> Void)? = nil
    
    //Limits
    private let resultsLimit = 100
    
    init(collectionView: UICollectionView? = nil, callback: @escaping ((DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker) -> Void)) {
        self.collectionView = collectionView
        self.onShowCardDetails = callback
        super.init()
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
                    cell.ticker = self.stocks[indexPath.row] as? SearchTickersQuery.Data.Ticker
                    return cell
                case .collections:
                    let cell: RecommendedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    if self.collections.count > 0, let collection = self.collections[indexPath.row] as? SearchCollectionDetailsQuery.Data.AppCollection {
                        cell.configureWith(name: collection.name,
                                           imageUrl: collection.imageUrl,
                                           description: collection.description ?? "",
                                           stocksAmount: "\(collection.collectionSymbolsAggregate.aggregate?.count ?? 0)",
                                           imageName: "",
                                           plusButtonState: .unchecked)
                    }
                    return cell
                case .news:
                    let cell: NewsViewCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.news = self.news[indexPath.row] as? DiscoverNewsQuery.Data.FetchNewsDatum
                    return cell
                case .loader:
                    let cell: SearchLoadingCell = collectionView.dequeueReusableCell(for: indexPath)
                    cell.activityIndicator.startAnimating()
                    return cell
                }
            })
            
            dataSource?.supplementaryViewProvider = { (view, kind, indexPath) in
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: CollectionSearchController.sectionHeaderElementKind, withReuseIdentifier: SearchCollectionHeaderView.identifier, for: indexPath) as? SearchCollectionHeaderView
                switch self.sections[indexPath.section] {
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
    
    //MARK: - API Calls
    
    private var networkCalls: [Cancellable] = []
    private var sections: [SearchSection] = []
    
    var searchText: String = "" {
        didSet {
            if !searchText.isEmpty {
                //Cancel old requests
                networkCalls.forEach({$0.cancel()})
                networkCalls.removeAll()
                
                //Search for new
                searchQuery(searchText)
            }
        }
    }
    
    func clearAll() {
        DispatchQueue.main.async {
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
        self.stocks.removeAll()
        self.collections.removeAll()
        self.news.removeAll()
    }
    
    private let searchQueue = DispatchQueue.init(label: "CollectionSearchController.searchQuery")
    private func searchQuery(_ text: String) {
        print("SEARCH STARTED")
        clearAll()
        
        loading?(true)
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        networkCalls.append(Network.shared.apollo.fetch(query: DiscoverNewsQuery.init(symbol: text)){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                self?.news = graphQLResult.data?.fetchNewsData ?? []
                dispatchGroup.leave()
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        })
        
        dispatchGroup.enter()
        networkCalls.append(Network.shared.apollo.fetch(query: SearchTickersQuery.init(text: "%\(text)%") ){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                self?.stocks = graphQLResult.data?.tickers ?? []
                dispatchGroup.leave()
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        })
        
        dispatchGroup.enter()
        networkCalls.append(Network.shared.apollo.fetch(query: SearchCollectionDetailsQuery.init(text: "%\(text)%") ){[weak self] result in
            switch result {
            case .success(let graphQLResult):
                self?.collections = graphQLResult.data?.appCollections ?? []
                dispatchGroup.leave()
                break
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                dispatchGroup.leave()
                break
            }
        })
        
        dispatchGroup.notify(queue: searchQueue) {
            print("SEARCH ENDED")
            print("\(self.stocks.count) \(self.collections.count) \(self.news.count)")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
                self.collectionView?.delegate = self
                if var snapshot = self.dataSource?.snapshot() {
                    
                    if snapshot.itemIdentifiers(inSection: .loader).count > 0 {
                        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .loader))
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

extension SearchTickersQuery.Data.Ticker: Hashable {
    public static func == (lhs: SearchTickersQuery.Data.Ticker, rhs: SearchTickersQuery.Data.Ticker) -> Bool {
        lhs.symbol == rhs.symbol
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.symbol)
    }
}

extension SearchCollectionDetailsQuery.Data.AppCollection: Hashable {
    public static func == (lhs: SearchCollectionDetailsQuery.Data.AppCollection, rhs: SearchCollectionDetailsQuery.Data.AppCollection) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

extension DiscoverNewsQuery.Data.FetchNewsDatum: Hashable {
    public static func == (lhs: DiscoverNewsQuery.Data.FetchNewsDatum, rhs: DiscoverNewsQuery.Data.FetchNewsDatum) -> Bool {
        lhs.datetime == rhs.datetime
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.datetime)
    }
}

extension CollectionSearchController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.sections[indexPath.section] {
        case .stocks:
            if let ticker = self.stocks[indexPath.row] as? SearchTickersQuery.Data.Ticker {
                let tickerMap = DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker.init(symbol: ticker.symbol, name: ticker.name, description: ticker.description, tickerFinancials: ticker.tickerFinancials.map({
                    DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker.TickerFinancial.init(peRatio: $0.peRatio, marketCapitalization: $0.marketCapitalization, highlight: $0.highlight, priceChangeToday: $0.priceChangeToday, currentPrice: $0.currentPrice, dividentGrowth: $0.dividentGrowth, symbol: $0.symbol, createdAt: $0.createdAt)
                }))
                onShowCardDetails?(tickerMap)
            }
            break
        case .collections:
            break
        case .news:
            break
        case .loader:
            break
        }
    }
}

