import AppsFlyerLib
import Foundation
import UIKit
import MBProgressHUD
import PureLayout
import SwiftUI
import Firebase

enum DiscoverCollectionsSection: Int, CaseIterable {
    case yourCollections
    case recommendedCollections
}

final class DiscoverCollectionsViewController: BaseViewController, DiscoverCollectionsViewControllerProtocol {
    // MARK: Internal
    
    // MARK: Properties
    
    // TODO: Borysov - remove this when profile is saved to CoreData
    @UserDefault<Int>("currentProfileID")
    private(set) var currentProfileID: Int?
    
    var viewModel: DiscoverCollectionsViewModelProtocol?
    
    var onGoToCollectionDetails: ((Int) -> Void)?
    var onRemoveCollectionFromYourCollections: (() -> Void)?
    var onSwapItems: ((Int, Int) -> Void)?
    var onItemDelete: ((DiscoverCollectionsSection, Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discoverCollectionsCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: customLayout
        )
        view.addSubview(discoverCollectionsCollectionView)
        discoverCollectionsCollectionView.autoPinEdge(.top, to: .top, of: view)
        discoverCollectionsCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        discoverCollectionsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        discoverCollectionsCollectionView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        discoverCollectionsCollectionView.registerSectionHeader(YourCollectionsHeaderView.self)
        discoverCollectionsCollectionView.registerSectionHeader(RecommendedCollectionsHeaderView.self)
        
        discoverCollectionsCollectionView.register(YourCollectionViewCell.self)
        discoverCollectionsCollectionView.register(RecommendedCollectionViewCell.self)
        
        discoverCollectionsCollectionView.backgroundColor = UIColor.Gainy.white
        discoverCollectionsCollectionView.showsVerticalScrollIndicator = false
        discoverCollectionsCollectionView.dragInteractionEnabled = true
        
        
        discoverCollectionsCollectionView.delegate = self
        
        discoverCollectionsCollectionView.dragDelegate = self
        discoverCollectionsCollectionView.dropDelegate = self
        
        dataSource = UICollectionViewDiffableDataSource<DiscoverCollectionsSection, AnyHashable>(
            collectionView: discoverCollectionsCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )
            
            switch (cell, modelItem) {
            case let (cell as YourCollectionViewCell, modelItem as YourCollectionViewCellModel):
                cell.tag = modelItem.id
                cell.onDeleteButtonPressed = { [weak self] in
                    let yesAction = UIAlertAction.init(title: "Yes", style: .default) { action in
                        GainyAnalytics.logEvent("your_collection_deleted", params: ["collectionID": modelItem.id,  "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
                        self?.removeFromYourCollection(itemId: modelItem.id, yourCollectionItemToRemove: modelItem)
                    }
                    NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure want to delete this Collection?", cancelTitle: "No", actions: [yesAction])
                }
                
                cell.onCellLifted = { [weak self] in
                    self?.indexOfCellBeingDragged = indexPath.row
                    self?.impactOccured()
                }
                
                cell.onCellStopDragging = { [weak self] in
                    if let dragCellIndex = self?.indexOfCellBeingDragged, dragCellIndex == indexPath.row {
                        self?.indexOfCellBeingDragged = nil
                    }
                }
                
                cell.delegate = cell
                
            case let (cell as RecommendedCollectionViewCell, modelItem as RecommendedCollectionViewCellModel):
                cell.onPlusButtonPressed = { [weak self] in
                    cell.isUserInteractionEnabled = false
                    
                    cell.setButtonChecked()
                    self?.addToYourCollection(collectionItemToAdd: modelItem, indexRow: indexPath.row)
                    
                    cell.isUserInteractionEnabled = true
                    GainyAnalytics.logEvent("add_to_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
                }
                
                cell.onCheckButtonPressed = { [weak self] in
                    cell.isUserInteractionEnabled = false
                    
                    cell.setButtonUnchecked()
                    // TODO: create a func removeFromYourCollection(collectionToRemove: recommendedCollectionItem)
                    let yourCollectionItem = YourCollectionViewCellModel(
                        id: modelItem.id,
                        image: modelItem.image,
                        imageUrl: modelItem.imageUrl,
                        name: modelItem.name,
                        description: modelItem.description,
                        stocksAmount: modelItem.stocksAmount,
                        recommendedIdentifier: modelItem
                    )
                    self?.removeFromYourCollection(itemId: modelItem.id, yourCollectionItemToRemove: yourCollectionItem)
                    
                    cell.isUserInteractionEnabled = true
                    GainyAnalytics.logEvent("remove_from_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
                }
            default:
                break
            }
            
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerViewModel = indexPath.section == DiscoverCollectionsSection.yourCollections.rawValue
                ? CollectionHeaderViewModel(
                    title: "Your collections",
                    description: "Tap to view, swipe to edit or drag & drop to reorder.\nAdd Recommended collections from below to browse them."
                )
                : CollectionHeaderViewModel(
                    title: "Collections you might like",
                    description: "Tap on collection for preview, or tap on plus icon to add to your discovery"
                )
                
                return self?.sections[indexPath.section].header(
                    collectionView: collectionView,
                    indexPath: indexPath,
                    viewModel: headerViewModel
                )
            default:
                return nil
            }
        }
        discoverCollectionsCollectionView.dataSource = dataSource
        if Auth.auth().currentUser != nil {
            showNetworkLoader()
            getRemoteData {
                DispatchQueue.main.async { [weak self] in
                    self?.initViewModels()
                    self?.hideLoader()
                }
            }
        }
        NotificationCenter.default.publisher(for: Notification.Name.didReceiveFirebaseAuthToken).sink {[weak self] _ in
        } receiveValue: {[weak self] notification in
            if let token = notification.object as? String {
                self?.showNetworkLoader()
                self?.getRemoteData {
                    DispatchQueue.main.async {
                        self?.initViewModels()
                        self?.hideLoader()
                    }
                }
            }
        }.store(in: &cancellables)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// Model to cahnge bottom view
    private var bottomViewModel: CollectionsBottomViewModel?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// Bottom action view adding
    fileprivate func addBottomView() {
        
        bottomViewModel = CollectionsBottomViewModel.init(actionTitle: "Add custom\ncollection", actionIcon: "plus_icon")
        let bottomView = CollectionsBottomView(model: bottomViewModel!)
        let hosting = CustomHostingController.init(shouldShowNavigationBar: false, rootView: bottomView)
        addChild(hosting)
        hosting.view.frame = CGRect.init(x: 0, y: 0, width: 50, height: 94)
        hosting.view.backgroundColor = .clear
        view.addSubview(hosting.view)
        hosting.view.autoPinEdge(.leading, to: .leading, of: view)
        hosting.view.autoPinEdge(.trailing, to: .trailing, of: view)
        hosting.view.autoSetDimension(.height, toSize: 94)
        hosting.view.autoPinEdge(.bottom, to: .bottom, of: view)
        hosting.didMove(toParent: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    
    // MARK: Private
    
    // MARK: Properties
    
    private lazy var sections: [SectionLayout] = [
        YourCollectionsSectionLayout(),
        RecommendedCollectionsSectionLayout(),
    ]
    
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()
    
    private var discoverCollectionsCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<DiscoverCollectionsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<DiscoverCollectionsSection, AnyHashable>()
    
    private var indexOfCellBeingDragged: Int?
    
    // MARK: Functions
    
    private func addToYourCollection(collectionItemToAdd: RecommendedCollectionViewCellModel, indexRow: Int) {
        let updatedRecommendedItem = RecommendedCollectionViewCellModel(
            id: collectionItemToAdd.id,
            image: collectionItemToAdd.image,
            imageUrl: collectionItemToAdd.imageUrl,
            name: collectionItemToAdd.name,
            description: collectionItemToAdd.description,
            stocksAmount: collectionItemToAdd.stocksAmount,
            isInYourCollections: true
        )
        
        let yourCollectionItem = YourCollectionViewCellModel(
            id: collectionItemToAdd.id,
            image: collectionItemToAdd.image,
            imageUrl: collectionItemToAdd.imageUrl,
            name: collectionItemToAdd.name,
            description: collectionItemToAdd.description,
            stocksAmount: collectionItemToAdd.stocksAmount,
            recommendedIdentifier: updatedRecommendedItem
        )
        
        viewModel?.yourCollections.append(yourCollectionItem)
        viewModel?.recommendedCollections[indexRow] = updatedRecommendedItem
        DummyDataSource.recommendedCollections[indexRow].isInYourCollections = true
        
        
        DemoUserContainer.shared.favoriteCollections.append(yourCollectionItem.id)
        DummyDataSource.yourCollections.append(
            Collection(id: yourCollectionItem.id,
                       image: yourCollectionItem.image,
                       imageUrl: yourCollectionItem.imageUrl,
                       name: yourCollectionItem.name,
                       description: yourCollectionItem.description,
                       stocksAmount: Int(yourCollectionItem.stocksAmount)!,
                       isInYourCollections: true)
        )
        
        if var snapshot = dataSource?.snapshot() {
            snapshot.appendItems([yourCollectionItem], toSection: .yourCollections)
            
            if var itemToReload  = snapshot.itemIdentifiers(inSection: .recommendedCollections).first(where: {
                if let item = $0 as? RecommendedCollectionViewCellModel {
                    return item.id == collectionItemToAdd.id
                }
                   return false
            }) as? RecommendedCollectionViewCellModel {
                snapshot.reloadItems([itemToReload])
            }
            
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
        
        AppsFlyerLib.shared().logEvent(
            AFEvent.addToYourCollections,
            withValues: [
                AFParameter.collectionName:
                    collectionItemToAdd.name,
                AFParameter.itemsInYourCollectionsAfterAdding:
                    "\(self.viewModel?.yourCollections.count ?? 0)",
                AFParameter.itemsInRecommendedAfterAdding:
                    "\(self.viewModel?.recommendedCollections.count ?? 0)",
            ]
        )
    }
    
    private func removeFromYourCollection(itemId: Int, yourCollectionItemToRemove: YourCollectionViewCellModel) {
        
        if let delIndex = DemoUserContainer.shared.favoriteCollections.firstIndex(of: itemId) {
            DemoUserContainer.shared.favoriteCollections.remove(at: delIndex)
        }
        
        viewModel?.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        DummyDataSource.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        
        guard var snapshot = dataSource?.snapshot() else {return}
        if let recommendedItem = yourCollectionItemToRemove.recommendedIdentifier {
            
            
            let reloadItem = RecommendedCollectionViewCellModel(
                id: recommendedItem.id,
                image: recommendedItem.image,
                imageUrl: recommendedItem.imageUrl,
                name: recommendedItem.name,
                description: recommendedItem.description,
                stocksAmount: recommendedItem.stocksAmount,
                isInYourCollections: true
            )
            
            let updatedRecommendedItem = RecommendedCollectionViewCellModel(
                id: recommendedItem.id,
                image: recommendedItem.image,
                imageUrl: recommendedItem.imageUrl,
                name: recommendedItem.name,
                description: recommendedItem.description,
                stocksAmount: recommendedItem.stocksAmount,
                isInYourCollections: false
            )
            
            if let indexOfRecommendedItemToDelete = viewModel?
                .recommendedCollections
                .firstIndex(where: { $0.id == yourCollectionItemToRemove.id }) {
                viewModel?.recommendedCollections[indexOfRecommendedItemToDelete] = updatedRecommendedItem
                DummyDataSource.recommendedCollections[indexOfRecommendedItemToDelete].isInYourCollections = false
            }
            
            snapshot.deleteItems([yourCollectionItemToRemove])
            if var itemToReload  = snapshot.itemIdentifiers(inSection: .recommendedCollections).first(where: {
                if let item = $0 as? RecommendedCollectionViewCellModel {
                    return item.id == itemId
                }
                   return false
            }) as? RecommendedCollectionViewCellModel {
                snapshot.reloadItems([itemToReload])
            }
            dataSource?.apply(snapshot, animatingDifferences: true)
            
            onItemDelete?(DiscoverCollectionsSection.recommendedCollections ,itemId)
        } else {
            if let deleteItems = snapshot.itemIdentifiers(inSection: .yourCollections).first { AnyHashable in
                if let model = AnyHashable as? YourCollectionViewCellModel {
                    return model.id == itemId
                }
                return false
            } {
                
                let reloadItem = RecommendedCollectionViewCellModel(
                    id: yourCollectionItemToRemove.id,
                    image: yourCollectionItemToRemove.image,
                    imageUrl: yourCollectionItemToRemove.imageUrl,
                    name: yourCollectionItemToRemove.name,
                    description: yourCollectionItemToRemove.description,
                    stocksAmount: yourCollectionItemToRemove.stocksAmount,
                    isInYourCollections: true
                )
                
                let updatedRecommendedItem = RecommendedCollectionViewCellModel(
                    id: yourCollectionItemToRemove.id,
                    image: yourCollectionItemToRemove.image,
                    imageUrl: yourCollectionItemToRemove.imageUrl,
                    name: yourCollectionItemToRemove.name,
                    description: yourCollectionItemToRemove.description,
                    stocksAmount: yourCollectionItemToRemove.stocksAmount,
                    isInYourCollections: false
                )
                
                if let indexOfRecommendedItemToDelete = viewModel?
                    .recommendedCollections
                    .firstIndex(where: { $0.id == yourCollectionItemToRemove.id }) {
                    viewModel?.recommendedCollections[indexOfRecommendedItemToDelete] = updatedRecommendedItem
                    DummyDataSource.recommendedCollections[indexOfRecommendedItemToDelete].isInYourCollections = false
                }
                
                snapshot.deleteItems([deleteItems])
                snapshot.reloadItems([reloadItem])
                dataSource?.apply(snapshot, animatingDifferences: true)
                onItemDelete?(DiscoverCollectionsSection.yourCollections, itemId)
            }
            
        }
        
        AppsFlyerLib.shared().logEvent(
            AFEvent.removeFromYourCollections,
            withValues: [
                AFParameter.collectionName:
                    yourCollectionItemToRemove.name,
                AFParameter.itemsInYourCollectionsAfterRemoval:
                    "\(self.viewModel?.yourCollections.count ?? 0)",
                AFParameter.itemsInRecommendedAfterRemoval:
                    "\(self.viewModel?.recommendedCollections.count ?? 0)",
            ]
        )
    }
    
    private func reorderItems(
        dropCoordinator: UICollectionViewDropCoordinator,
        destinationIndexPath: IndexPath
    ) {
        guard var snapshot = dataSource?.snapshot() else {return}
        let draggedItems = dropCoordinator.items
        guard let item = draggedItems.first, let sourceIndexPath = item.sourceIndexPath else {
            return
        }
        
        let sourceItem = snapshot.itemIdentifiers(inSection: .yourCollections)[sourceIndexPath.row] as? YourCollectionViewCellModel
        let destItem = snapshot.itemIdentifiers(inSection: .yourCollections)[destinationIndexPath.row] as? YourCollectionViewCellModel
        
        GainyAnalytics.logEvent("your_collection_reordered", params: ["sourceCollectionID": sourceItem?.id ?? 0, "destCollectionID" : destItem?.id ?? 0, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        
        let dragDirectionIsTopBottom = sourceIndexPath.row < destinationIndexPath.row
        
        
        // TODO: keeping local order, make it more robust and flexible
        //onSwapItems?(sourceItem?.id ?? 0, destItem?.id ?? 0)
        DemoUserContainer.shared.favoriteCollections.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        DummyDataSource.yourCollections.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
        if dragDirectionIsTopBottom {
            snapshot.moveItem(sourceItem, afterItem: destItem)
        } else {
            snapshot.moveItem(sourceItem, beforeItem: destItem)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: true)
        dropCoordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
    
    private func initViewModels() {
        
        guard let dataSource = dataSource else {return}
        
        var snap = dataSource.snapshot()
        if snap.sectionIdentifiers.count > 0 {
            snap.deleteSections([.yourCollections, .recommendedCollections])
        }
        snap.appendSections([.yourCollections, .recommendedCollections])
        snap.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
        snap.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)
        dataSource.apply(snap, animatingDifferences: true)
        discoverCollectionsCollectionView.reloadData()
        addBottomView()
        hideLoader()
    }
    
    private func goToCollectionDetails(at collectionPosition: Int) {
        onGoToCollectionDetails?(collectionPosition)
    }
    
    private func initViewModelsFromData() {
        viewModel?.yourCollections = DummyDataSource
            .yourCollections
            .map { CollectionViewModelMapper.map($0) }
        viewModel?.recommendedCollections = DummyDataSource
            .recommendedCollections
            .map { CollectionViewModelMapper.map($0) }
    }
    
    private func getRemoteData(completion: @escaping () -> Void) {
        
        guard DummyDataSource.recommendedCollections.count == 0 else {
            initViewModelsFromData()
            completion()
            return
        }
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        guard let profileID = self.currentProfileID else {
            return
        }
        
        showNetworkLoader()
        Network.shared.apollo.fetch(query: FetchRecommendedCollectionsQuery(profileId: profileID)) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let graphQLResult):
                
                guard let collections = graphQLResult.data?.getRecommendedCollections?.compactMap({$0?.collection.fragments.remoteShortCollectionDetails}) else {
                    NotificationManager.shared.showError("Sorry... No Collections to display.")
                    self.hideLoader()
                    completion()
                    return
                }
                DummyDataSource.recommendedCollections = collections.map {
                    CollectionDTOMapper.map($0)
                }
                DummyDataSource.yourCollections = collections.filter({DemoUserContainer.shared.favoriteCollections.contains($0.id ?? 0)}).map {
                    CollectionDTOMapper.map($0)
                }.reorder(by: DemoUserContainer.shared.favoriteCollections)
                
                
                self.initViewModelsFromData()
                completion()
                
            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                self.initViewModels()
                completion()
            }
        }
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == 0 else {return}
        var position = 0
        if indexPath.section == DiscoverCollectionsSection.recommendedCollections.rawValue {
            position = collectionView.numberOfItems(
                inSection: DiscoverCollectionsSection.yourCollections.rawValue
            )
            GainyAnalytics.logEvent("your_collection_pressed", params: ["collectionID": DummyDataSource.recommendedCollections[indexPath.row].id, "type" : "yours", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        } else {
            GainyAnalytics.logEvent("your_collection_pressed", params: ["collectionID": DummyDataSource.yourCollections[indexPath.row].id, "type" : "recommended", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        }
        position += indexPath.row
        
        self.goToCollectionDetails(at: indexPath.row)
        
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDragDelegate {
    func collectionView(
        _: UICollectionView,
        itemsForBeginning _: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        switch indexPath.section {
        case DiscoverCollectionsSection.yourCollections.rawValue:
            let item = viewModel!.yourCollections[indexPath.row]
            // swiftlint:disable legacy_objc_type
            let itemProvider = NSItemProvider(object: item.name as NSString)
            // swiftlint:enable legacy_objc_type
            let dragItem = UIDragItem(itemProvider: itemProvider)
            
            // TODO: Consider assigning a value to the localObject property of each drag item.
            // This step is optional but makes it faster to drag and drop content within the same app.
            
            return [dragItem]
        default:
            return []
        }
    }
    
    func collectionView(
        _: UICollectionView,
        dragSessionIsRestrictedToDraggingApplication _: UIDragSession
    ) -> Bool {
        true
    }
    
    func collectionView(
        _: UICollectionView,
        dragPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width - (16 + 16),
                height: 92
            ),
            cornerRadius: 8
        )
        previewParams.visiblePath = path
        
        return previewParams
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDropDelegate {
    func collectionView(_: UICollectionView,
                        performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        if coordinator.proposal.operation == .move {
            reorderItems(dropCoordinator: coordinator,
                         destinationIndexPath: destinationIndexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath _: IndexPath?) -> UICollectionViewDropProposal {
        let dragItemLocation = session.location(in: collectionView)
        var dragItemIndexPath: IndexPath?
        
        collectionView.performUsingPresentationValues {
            dragItemIndexPath = collectionView.indexPathForItem(at: dragItemLocation)
        }
        
        guard let destination = dragItemIndexPath else {
            return UICollectionViewDropProposal(
                operation: .cancel,
                intent: .unspecified
            )
        }
        
        guard destination.section == DiscoverCollectionsSection.yourCollections.rawValue else {
            return UICollectionViewDropProposal(
                operation: .cancel,
                intent: .unspecified
            )
        }
        
        return UICollectionViewDropProposal(
            operation: .move,
            intent: .insertAtDestinationIndexPath
        )
    }
    
    func collectionView(
        _: UICollectionView,
        dropPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width - (16 + 16),
                height: 92
            ),
            cornerRadius: 8
        )
        previewParams.visiblePath = path
        
        return previewParams
    }
}
