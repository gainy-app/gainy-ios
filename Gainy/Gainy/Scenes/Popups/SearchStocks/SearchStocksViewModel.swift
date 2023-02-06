//
//  SearchStocksViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.11.2021.
//

import UIKit
import Apollo
import GainyAPI

protocol SearchStocksViewModelDelegate: AnyObject {
    func stockSelected(source: SearchStocksViewModel, stock: RemoteTickerDetails)
}

final class SearchStocksViewModel: NSObject {
    
    
    weak var delegate: SearchStocksViewModelDelegate?
    
    enum SearchSection: Int, CaseIterable, Hashable {
        case stocks = 0
    }
    
    private let tableView: UITableView
    private let dataSource: UITableViewDiffableDataSource<SearchSection, RemoteTickerDetails>!
        
    init(tableView: UITableView, dataSource: UITableViewDiffableDataSource<SearchStocksViewModel.SearchSection, RemoteTickerDetails>? = nil) {
        self.tableView = tableView
        weak var selfWorkaround: SearchStocksViewModel?
        self.dataSource = UITableViewDiffableDataSource<SearchSection, RemoteTickerDetails>.init(tableView: tableView, cellProvider: {tableView, indexPath, section in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchStockTableViewCell.cellIdentifier, for: indexPath) as! SearchStockTableViewCell
            cell.stock = selfWorkaround?.stocks[indexPath.row]
            return cell
        })
        super.init()
        selfWorkaround = self
    }
    
    //UI updates
    var loading: ((Bool) -> Void)?
    
    //Limits
    private let resultsLimit = 100
        
    //MARK: - Data Fetching
    
    private var stocks: [RemoteTickerDetails] = []
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
                    GainyAnalytics.logEvent("compare_stock_search_term", params: ["term" : self.searchText, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                }
                DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 0.5, execute: searchBlock!)
            }
        }
    }
    
    
    func clearAll() {
        self.stocks.removeAll()
        runOnMain{
            self.performClearAll()
        }
    }
    
    func performClearAll() {
        
    var snapshot = self.dataSource.snapshot()
        snapshot.deleteSections(snapshot.sectionIdentifiers)
    self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    private let searchQueue = DispatchQueue.init(label: "SearchStocksViewModel.searchQuery")
    private func searchQuery(_ text: String) {
        dprint("SEARCH STARTED")
        clearAll()
        
        let dispatchGroup = DispatchGroup()
        if text.count <= 3 {
            dispatchGroup.enter()
            networkCalls.append(Network.shared.apollo.fetch(query: SearchTickersQuery.init(text: "%\(text)%") ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    
                    let mappedTickers = (graphQLResult.data?.tickers ?? []).compactMap({$0.fragments.remoteTickerDetails})
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
        } else if text.contains(" ") {
            dispatchGroup.enter()
            networkCalls.append(Network.shared.apollo.fetch(query: SearchTickersWithSpaceQuery.init(text: "%\(text)%") ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    
                    let mappedTickers = (graphQLResult.data?.tickers ?? []).compactMap({$0.fragments.remoteTickerDetails})
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
        } else {
            dispatchGroup.enter()
            networkCalls.append(Network.shared.apollo.fetch(query: SearchTickersNoSpaceQuery.init(text: "%\(text)%") ){[weak self] result in
                switch result {
                case .success(let graphQLResult):
                    
                    let mappedTickers = (graphQLResult.data?.tickers ?? []).compactMap({$0.fragments.remoteTickerDetails})
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
        }
        
        dispatchGroup.notify(queue: searchQueue) {
            dprint("SEARCH ENDED")
            dprint("\(self.stocks.count)")
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                
                self.tableView.delegate = self
                var snapshot = self.dataSource.snapshot()
                    
                    if self.stocks.count > 0 {
                        
                        if !snapshot.sectionIdentifiers.contains(.stocks) {
                            snapshot.appendSections([.stocks])
                        }
                        self.sections.append(.stocks)
                        snapshot.deleteItems(snapshot.itemIdentifiers(inSection: .stocks))
                        snapshot.appendItems(Array(self.stocks.prefix(self.resultsLimit)), toSection: .stocks)
                    }                    
                  
                    self.dataSource.apply(snapshot, animatingDifferences: true)
                
                self.loading?(false)
            }
        }
    }
}

extension SearchStocksViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.stockSelected(source: self, stock: stocks[indexPath.row])
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch self.sections[indexPath.section] {
//        case .stocks:
//            if let ticker = self.stocks[indexPath.row] as? RemoteTickerDetails {
//                GainyAnalytics.logEvent("collections_search_ticker_pressed", params: ["tickerSymbol" : ticker.symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
//                onShowCardDetails?(ticker)
//            }
//            break
//        case .collections:
//            if let collection = self.collections[indexPath.row] as? RemoteCollectionDetails{
//                GainyAnalytics.logEvent("collections_search_collection_pressed", params: ["collectionId" : collection.id, "ec" : "CollectionDetails"])
//                localFavHash = UserProfileManager.shared.favHash
//                coordinator?.showCollectionDetails(collectionID: collection.id ?? 0, delegate:  self)
//            }
//            break
//        case .suggestedCollection:
//            let collection = self.recommendedCollections[indexPath.row]
//            GainyAnalytics.logEvent("collections_search_recommended_collection_pressed", params: ["collectionId" : collection.id, "ec" : "CollectionDetails"])
//            localFavHash = UserProfileManager.shared.favHash
//            coordinator?.showCollectionDetails(collectionID: collection.id, delegate:  self)
//
//            break
//        case .news:
//            if let news = self.news[indexPath.row] as? DiscoverNewsQuery.Data.FetchNewsDatum {
//                if let url = URL(string: GainyAnalytics.shared.addInfoToURLString(news.url ?? "")) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                    GainyAnalytics.logEvent("collections_search_news_pressed", params: ["newsID" : news.title, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
//                }
//            }
//            break
//        case .loader:
//            break
//        }
//    }
}
