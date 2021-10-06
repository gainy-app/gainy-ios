//
//  SingleCollectionDetailsViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.10.2021.
//

import UIKit
import Combine

final class SingleCollectionDetailsViewModel: NSObject {
          
    let collectionId: Int
    
    init(collectionId: Int, collectionView: UICollectionView) {
        self.collectionId = collectionId
        
        super.init()
        self.dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>(
            collectionView: collectionView
        ) {[weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )
            
            if let cell = cell as? CollectionDetailsViewCell {
                
                cell.tag = modelItem.id
                cell.onCardPressed = {[weak self]  ticker in
                    //self?.onShowCardDetails?(ticker)
                }
                cell.onSortingPressed = { [weak self] in
//                    guard let self = self else {return}
//                    guard self.presentedViewController == nil else {return}
//                        self.sortingVS.collectionId = modelItem.id
//                        self.sortingVS.collectionCell = cell
//                        self.currentCollectionToChange = modelItem.id
//                        GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
//                    self.present(self.fpc, animated: true, completion: nil)
                }
            }
            return cell
        }
    }
    
    //MARK: - Updates
    
    
    var loadingPublisher: AnyPublisher<Bool, Error> {
        loadingSubject.eraseToAnyPublisher()
    }
    
    private let loadingSubject = PassthroughSubject<Bool,Error>()
    
    
    //MARK: - Models
    private(set) var collectionDetails: RemoteCollectionDetails?
    private var collectionDetailsModels: [CollectionDetailViewCellModel] = []
    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>?
    
    //MARK: - Collection Layout
    
    private enum CollectionDetailsSection: Int, CaseIterable {
        case collectionWithCards
    }
    
    private lazy var sections: [SectionLayout] = [
        HorizontalFlowSectionLayout()
    ]
    
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()
    
    
    //MARK: - Loading
    
    fileprivate func loadCollectionDetails() {
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
                let collectionIDs = selectedCollections.compactMap(\.id)
                
                TickersLiveFetcher.shared.getMatchScores(collectionIds: collectionIDs) {
                    DispatchQueue.main.async {
                        self?.convertToModels(selectedCollections)
                        self?.loadingSubject.send(false)
                    }
                }
                
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                self?.convertToModels([])
                self?.loadingSubject.send(false)
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
