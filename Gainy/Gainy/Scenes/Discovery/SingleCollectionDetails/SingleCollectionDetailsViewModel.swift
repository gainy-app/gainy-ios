//
//  SingleCollectionDetailsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.10.2021.
//

import UIKit
import Combine

protocol SingleCollectionDetailsViewModelDelegate: AnyObject {
    func addStockPressed(source: SingleCollectionDetailsViewModel)
    func tickerPressed(source: SingleCollectionDetailsViewModel, ticker: RemoteTickerDetails)
    func sortingPressed(source: SingleCollectionDetailsViewModel, model: CollectionDetailViewCellModel, cell: CollectionDetailsViewCell)
}

final class SingleCollectionDetailsViewModel: NSObject {
    
    weak var delegate: SingleCollectionDetailsViewModelDelegate?
    private enum CollectionDetailSection: Int, CaseIterable {
        case collectionWithCards
    }
    
    let collectionId: Int
    
    init(collectionId: Int) {
        self.collectionId = collectionId
    }
    
    init(model: CollectionDetailViewCellModel) {
        self.collectionId = Constants.CollectionDetails.compareCollectionID
        self.collectionDetailsModels = [model]
    }
    
    private var isCompareView: Bool {
        collectionId == Constants.CollectionDetails.compareCollectionID
    }
    
    func initCollectionView(collectionView: UICollectionView) {
        self.dataSource = UICollectionViewDiffableDataSource<CollectionDetailSection, CollectionDetailViewCellModel>(
            collectionView: collectionView
        ) {[weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = (self?.collectionId ?? 0 != Constants.CollectionDetails.compareCollectionID ? self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            ) : self?.compareSections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            ))
            
            if let cell = cell as? CollectionDetailsViewCell {
                cell.tag = modelItem.id
                cell.onCardPressed = {[weak self]  ticker in
                    guard let self = self else {return}
                    self.delegate?.tickerPressed(source: self, ticker: ticker)
                }
                cell.onSortingPressed = { [weak self] in
                    guard let self = self else {return}
                    self.delegate?.sortingPressed(source: self, model: modelItem, cell: cell)
                }
                cell.onAddStockPressed = { [weak self] in
                    guard let self = self else {return}
                    self.delegate?.addStockPressed(source: self)
                }
            }
            return cell
        }
    }
    
    //MARK: - Updates
    
    
    var loadingPublisher: AnyPublisher<Bool, Error> {
        loadingSubject.eraseToAnyPublisher()    }
    
    private let loadingSubject = PassthroughSubject<Bool,Error>()
    
    
    //MARK: - Models
    private var collectionDetailsModels: [CollectionDetailViewCellModel] = []
    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailSection, CollectionDetailViewCellModel>?
    
    var haveCollection: Bool {
        collectionDetailsModels.count > 0
    }
    
    //MARK: - Collection Layout
    
    
    private lazy var sections: [SectionLayout] = [
        HorizontalFlowSectionLayout()
    ]
    
    lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()
    
    
    private lazy var compareSections: [SectionLayout] = [
        HorizontalCompareFlowSectionLayout()
    ]
    
    lazy var customCompareLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.compareSections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()
    
    //MARK: - Loading
    
    func loadCollectionDetails(_ completed: (() -> Void)? = nil) {
        if isCompareView {
            if var snapshot = dataSource?.snapshot() {
                if snapshot.sectionIdentifiers.count > 0 {
                    snapshot.deleteSections([.collectionWithCards])
                }
                snapshot.appendSections([.collectionWithCards])
                snapshot.appendItems(collectionDetailsModels, toSection: .collectionWithCards)
                
                dataSource?.apply(snapshot, animatingDifferences: false)
            }
            completed?()
        } else {
            loadingSubject.send(true)
            Network.shared.apollo.fetch(query: FetchSelectedCollectionsQuery(ids: [collectionId])) { [weak self] result in
                switch result {
                case .success(let graphQLResult):
                    guard let collections = graphQLResult.data?.collections.compactMap({$0.fragments.remoteCollectionDetails}) else {
                        //Going back
                        self?.loadingSubject.send(false)
                        return
                    }
                    let selectedCollections = collections
                    DispatchQueue.main.async {
                        self?.convertToModels(selectedCollections)
                        self?.loadingSubject.send(false)
                        completed?()
                    }
                    
                case .failure(let error):
                    dprint("Failure when making GraphQL request. Error: \(error)")
                    self?.convertToModels([])
                    self?.loadingSubject.send(false)
                    completed?()
                }
            }
        }
    }
    
    fileprivate func convertToModels(_ collection: [RemoteCollectionDetails]) {
        let yourCollections = collection
            .map { CollectionDetailsDTOMapper.mapAsCollectionFromYourCollections($0) }
        
        collectionDetailsModels = yourCollections
            .map { CollectionDetailsViewModelMapper.map($0) }
        
        //Append items
        
        if var snapshot = dataSource?.snapshot() {
            if snapshot.sectionIdentifiers.count > 0 {
                snapshot.deleteSections([.collectionWithCards])
            }
            snapshot.appendSections([.collectionWithCards])
            snapshot.appendItems(collectionDetailsModels, toSection: .collectionWithCards)
            
            dataSource?.apply(snapshot, animatingDifferences: false)
        }
        
        
    }
    
    
}
