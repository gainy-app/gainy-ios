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
    
    weak var authorizationManager: AuthorizationManager?
    var viewModel: DiscoverCollectionsViewModelProtocol?
    weak var coordinator: MainCoordinator?
    
    var onGoToCollectionDetails: ((Int) -> Void)?
    var onRemoveCollectionFromYourCollections: (() -> Void)?
    var onSwapItems: ((Int, Int) -> Void)?
    var onItemDelete: ((DiscoverCollectionsSection, Int) -> Void)?
    var showNextButton: Bool = false
    
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
        discoverCollectionsCollectionView.contentInset = .init(top: 0, left: 0, bottom: (showNextButton ? 87.0 : 45.0), right: 0)
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
                    title: "Recommended collections",
                    description: "All collections are sorted by relevancy based on your profile and goals "
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
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        showNetworkLoader()
        getRemoteData(loadProfile: true ) {
            DispatchQueue.main.async { [weak self] in
                self?.initViewModels()
                self?.hideLoader()
            }
        }
    }
    
    public func snapshotForYourCollectionCell(at index: Int) -> UIImage? {
        
        if let cell = discoverCollectionsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
            return cell.asImage()
        }
        
        return nil
    }
    
    public func frameForYourCollectionCell(at index: Int) -> CGRect {
        
        if let cell = discoverCollectionsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
            let frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y - discoverCollectionsCollectionView.contentOffset.y, width: cell.frame.width, height: cell.frame.height)
            return frame
        }
        
        return CGRect.zero
    }
    
    public func hideYourCollectionCell(at index: Int) {
        
        if let cell = discoverCollectionsCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) {
            cell.isHidden = true
        }
    }
    
    /// Model to cahnge bottom view
    private var bottomViewModel: CollectionsBottomViewModel?
    private var bottomViewButton: BorderButton?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /// Bottom action view adding
    fileprivate func addBottomView() {
        
        bottomViewModel = CollectionsBottomViewModel.init(actionTitle: "See\nrecommendations", actionIcon: "check_icon")
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
    
    fileprivate func addBottomButton() {
        
        bottomViewButton = BorderButton.newAutoLayout()
        if let button = bottomViewButton {
            view.addSubview(button)
            button.autoSetDimension(ALDimension.height, toSize: 60.0)
            button.autoPinEdge(toSuperviewEdge: ALEdge.leading, withInset: 32.0)
            button.autoPinEdge(toSuperviewEdge: ALEdge.trailing, withInset: 32.0)
            button.autoPinEdge(toSuperviewSafeArea: ALEdge.bottom, withInset: 0.0)
            button.borderColor = UIColor.clear
            button.setTitle("Next", for: .normal)
            button.backgroundColor = UIColor(hexString: "#0062FF", alpha: 1.0)
            button.setTitleColor(UIColor.white, for: .normal)
            button.addTarget(self, action: #selector(bottomButtonTapped(_:)),
                             for: .touchUpInside)
            button.cornerRadius = 20.0
            button.titleLabel?.font = UIFont.proDisplaySemibold(16.0)
        }
    }
    
    @objc private func bottomButtonTapped(_: UIButton) {
        
        let yourCollectionsCount = discoverCollectionsCollectionView.numberOfItems(inSection: DiscoverCollectionsSection.yourCollections.rawValue)
        if yourCollectionsCount > 0 {
            self.goToCollectionDetails(at: 0)
        } else {
            NotificationManager.shared.showMessage(title: "", text: "Please, in order to proceed, add at least one recommended collection to your collections.", cancelTitle: "Ok", actions: [])
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
        
        //Prefetching
        CollectionsManager.shared.loadNewCollectionDetails(collectionItemToAdd.id)
        
        showNetworkLoader()
        UserProfileManager.shared.addFavouriteCollection(yourCollectionItem.id) { success in
            
            self.viewModel?.yourCollections.append(yourCollectionItem)
            self.viewModel?.recommendedCollections[indexRow] = updatedRecommendedItem
            UserProfileManager.shared.recommendedCollections[indexRow].isInYourCollections = true
            
            self.hideLoader()
            UserProfileManager.shared.yourCollections.append(
                Collection(id: yourCollectionItem.id,
                           image: yourCollectionItem.image,
                           imageUrl: yourCollectionItem.imageUrl,
                           name: yourCollectionItem.name,
                           description: yourCollectionItem.description,
                           stocksAmount: Int(yourCollectionItem.stocksAmount)!,
                           isInYourCollections: true)
            )
            
            if var snapshot = self.dataSource?.snapshot() {
                snapshot.appendItems([yourCollectionItem], toSection: .yourCollections)
                
                if var itemToReload = snapshot.itemIdentifiers(inSection: .recommendedCollections).first(where: {
                    if let item = $0 as? RecommendedCollectionViewCellModel {
                        return item.id == collectionItemToAdd.id
                    }
                    return false
                }) as? RecommendedCollectionViewCellModel {
                    snapshot.reloadItems([itemToReload])
                }
                
                self.dataSource?.apply(snapshot, animatingDifferences: true)
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
    }
    
    private func removeFromYourCollection(itemId: Int, yourCollectionItemToRemove: YourCollectionViewCellModel, removeFavourite : Bool = true) {
        
        if let delIndex = UserProfileManager.shared.favoriteCollections.firstIndex(of: itemId) {
            if removeFavourite {
                showNetworkLoader()
                UserProfileManager.shared.removeFavouriteCollection(itemId) { success in
                    self.hideLoader()
                    self.removeFromYourCollection(itemId: itemId, yourCollectionItemToRemove: yourCollectionItemToRemove, removeFavourite: false)
                }
            }
        }
        
        viewModel?.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        UserProfileManager.shared.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        
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
                UserProfileManager.shared.recommendedCollections[indexOfRecommendedItemToDelete].isInYourCollections = false
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
                    UserProfileManager.shared.recommendedCollections[indexOfRecommendedItemToDelete].isInYourCollections = false
                    snapshot.reloadItems([reloadItem])
                }
                
                snapshot.deleteItems([deleteItems])
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
        onSwapItems?(sourceItem?.id ?? 0, destItem?.id ?? 0)
        
        UserProfileManager.shared.favoriteCollections.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        UserProfileManager.shared.yourCollections.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
        
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
        if showNextButton {
            addBottomButton()
        }
        hideLoader()
    }
    
    private func goToCollectionDetails(at collectionPosition: Int) {
        
        onGoToCollectionDetails?(collectionPosition)
    }
    
    private func initViewModelsFromData() {
        viewModel?.yourCollections = UserProfileManager.shared
            .yourCollections
            .map { CollectionViewModelMapper.map($0) }
        viewModel?.recommendedCollections = UserProfileManager.shared
            .recommendedCollections
            .map { CollectionViewModelMapper.map($0) }
    }
    
    private func getRemoteData(loadProfile: Bool = false, completion: @escaping () -> Void) {
        
        guard haveNetwork else {
            completion()
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        
        UserProfileManager.shared.getProfileCollections(loadProfile: loadProfile) { success in
            
            guard success == true  else {
                self.initViewModels()
                completion()
                return
            }
            
            self.initViewModelsFromData()
            completion()
        }
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == DiscoverCollectionsSection.yourCollections.rawValue {
            GainyAnalytics.logEvent("your_collection_pressed", params: ["collectionID": UserProfileManager.shared.yourCollections[indexPath.row].id, "type" : "yours", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
            self.goToCollectionDetails(at: indexPath.row)
        } else {
            if let recColl = viewModel?.recommendedCollections[indexPath.row] {
                coordinator?.showCollectionDetails(collectionID: recColl.id, delegate: self)
            }
            GainyAnalytics.logEvent("your_collection_pressed", params: ["collectionID": UserProfileManager.shared.recommendedCollections[indexPath.row].id, "type" : "recommended", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        }
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

extension DiscoverCollectionsViewController : SingleCollectionDetailsViewControllerDelegate {
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        guard let snapshot = dataSource?.snapshot() else {return}
        
        if isAdded {
            if let index = snapshot.itemIdentifiers(inSection: .recommendedCollections).firstIndex(where: {
                if let model = $0 as? RecommendedCollectionViewCellModel {
                    return model.id == collectionID
                }
                return false
            }) {
                if let rightModel = snapshot.itemIdentifiers(inSection: .recommendedCollections)[index] as? RecommendedCollectionViewCellModel {
                    addToYourCollection(collectionItemToAdd: rightModel, indexRow: index)
                }
            }
        } else {
            if let index = snapshot.itemIdentifiers(inSection: .yourCollections).firstIndex(where: {
                if let model = $0 as? YourCollectionViewCellModel {
                    return model.id == collectionID
                }
                return false
            }) {
                if let rightModel = snapshot.itemIdentifiers(inSection: .yourCollections)[index] as? YourCollectionViewCellModel {
                    removeFromYourCollection(itemId: collectionID, yourCollectionItemToRemove: rightModel)
                }
            }
        }
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        
    }
}

