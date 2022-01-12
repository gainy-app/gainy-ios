import AppsFlyerLib
import Foundation
import UIKit
import MBProgressHUD
import PureLayout
import SwiftUI
import Firebase

enum DiscoverCollectionsSection: Int, CaseIterable {
    case watchlist
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
        
        view.backgroundColor = UIColor.Gainy.white
        let navigationBarContainer = UIView(
            frame: CGRect(
                x: 0,
                y: view.safeAreaInsets.top + 36,
                width: view.bounds.width,
                height: 80
            )
        )
        navigationBarContainer.backgroundColor = UIColor.Gainy.white
        
        let discoverCollectionsButton = UIButton(
            frame: CGRect(
                x: navigationBarContainer.bounds.width - (32 + 20),
                y: 28,
                width: 32,
                height: 32
            )
        )
        
        discoverCollectionsButton.setImage(UIImage(named: "collection-details"), for: .normal)
        discoverCollectionsButton.addTarget(self,
                                            action: #selector(discoverCollectionsButtonTapped),
                                            for: .touchUpInside)
        
        navigationBarContainer.addSubview(discoverCollectionsButton)
        showCollectionDetailsBtn = discoverCollectionsButton
        let searchTextField = UITextField(
            frame: CGRect(
                x: 16,
                y: 24,
                width: navigationBarContainer.bounds.width - (16 + 16 + 32 + 20),
                height: 40
            )
        )
        
        searchTextField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        searchTextField.textColor = UIColor(named: "mainText")
        searchTextField.layer.cornerRadius = 16
        searchTextField.isUserInteractionEnabled = true
        searchTextField.placeholder = "Search anything"
        let searchIconContainerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 14 + 24 + 6,
                height: 24
            )
        )
        
        let searchIconImageView = UIImageView(
            frame: CGRect(
                x: 14,
                y: 0,
                width: 24,
                height: 24
            )
        )
        
        searchIconContainerView.addSubview(searchIconImageView)
        searchIconImageView.contentMode = .center
        searchIconImageView.backgroundColor = UIColor.Gainy.lightBack
        searchIconImageView.image = UIImage(named: "search")
        
        searchTextField.leftView = searchIconContainerView
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .whileEditing
        searchTextField.backgroundColor = UIColor.Gainy.lightBack
        searchTextField.returnKeyType = .done
        
        let btnFrame = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24 + 12, height: 24))
        let clearBtn = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 24,
                height: 24
            )
        )
        clearBtn.setImage(UIImage(named: "search_clear"), for: .normal)
        clearBtn.addTarget(self, action: #selector(textFieldClear), for: .touchUpInside)
        btnFrame.addSubview(clearBtn)
        searchTextField.rightView = btnFrame
        
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchTextField.delegate = self
        navigationBarContainer.addSubview(searchTextField)
        self.searchTextField = searchTextField
        
        view.addSubview(navigationBarContainer)
        
        let navigationBarTopOffset =
        navigationBarContainer.frame.origin.y + navigationBarContainer.bounds.height
        
        discoverCollectionsCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: customLayout
        )
        view.addSubview(discoverCollectionsCollectionView)
        discoverCollectionsCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        discoverCollectionsCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        discoverCollectionsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        discoverCollectionsCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
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
                    NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure you want to delete this Collection?", cancelTitle: "No", actions: [yesAction])
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
                cell.tag = modelItem.id
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
                let headerViewModel = indexPath.section == DiscoverCollectionsSection.watchlist.rawValue
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
        
        
        searchCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: navigationBarTopOffset,
                width: view.bounds.width,
                height: view.bounds.height - navigationBarTopOffset
            ),
            collectionViewLayout: CollectionSearchController.createLayout([.loader])
        )
        view.addSubview(searchCollectionView)
        searchCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        searchCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        searchCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        searchCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        searchCollectionView.backgroundColor = .clear
        searchCollectionView.showsVerticalScrollIndicator = false
        searchCollectionView.dragInteractionEnabled = true
        searchCollectionView.bounces = false
        searchCollectionView.alpha = 0.0
        searchController = CollectionSearchController.init(collectionView: searchCollectionView, callback: {[weak self] tickers, ticker in
            if let index = tickers.firstIndex(where: {$0.symbol == ticker.symbol}) {
                self?.coordinator?.showCardsDetailsViewController(tickers.compactMap({TickerInfo(ticker: $0)}), index: index)
            }
        })
        searchController?.collectionsUpdated = { [weak self] in
            self?.getRemoteData(loadProfile: true ) {
                DispatchQueue.main.async { [weak self] in
                    self?.initViewModels()
                    self?.hideLoader()
                }
            }
        }
        searchController?.onCollectionDelete = {[weak self] collectionId in
            
            // TODO: Double check if this needed or not - looks like colletion is already removed here
            // self?.removeFromYourCollection(itemId: collectionId, yourCollectionItemToRemove: )
        }
        searchController?.onNewsClicked = {[weak self] newsUrl in
            if let self = self {
                WebPresenter.openLink(vc: self, url: newsUrl)
            }
        }
        
        searchController?.coordinator = coordinator
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
            let frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y - discoverCollectionsCollectionView.contentOffset.y + discoverCollectionsCollectionView.frame.origin.y, width: cell.frame.width, height: cell.frame.height)
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
            button.autoPinEdge(toSuperviewSafeArea: ALEdge.bottom, withInset: 32.0)
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
            self.goToCollectionDetails(at: 1)
        } else {
            NotificationManager.shared.showMessage(title: "", text: "Please, in order to proceed, add at least one recommended collection to your collections.", cancelTitle: "Ok", actions: [])
        }
    }
    
    public func cancelSearchAsNeeded() {
        if searchCollectionView.alpha > 0.0 {
            textFieldClear()
        }
    }
    
    @objc func textFieldClear() {
        searchTextField?.text = ""
        searchController?.searchText = searchTextField?.text ?? ""
        searchController?.clearAll()
        
        searchTextField?.resignFirstResponder()
        
        let oldFrame = CGRect(
            x: 16,
            y: 24,
            width: self.view.bounds.width - (16 + 16 + 32 + 20),
            height: 40
        )
        UIView.animate(withDuration: 0.3) {
            self.discoverCollectionsCollectionView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.showCollectionDetailsBtn?.alpha = 1.0
            self.searchTextField?.frame = oldFrame
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        searchController?.searchText = text
        
        if text.count > 0 {
            searchTextField?.clearButtonMode = .always
            searchTextField?.clearButtonMode = .whileEditing
        } else {
            searchTextField?.clearButtonMode = .never
        }
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_started", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        searchController?.searchText =  ""
        UIView.animate(withDuration: 0.3) {
            self.discoverCollectionsCollectionView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
            self.showCollectionDetailsBtn?.alpha = 0.0
            self.searchTextField?.frame = CGRect(
                x: 16,
                y: 24,
                width: self.view.bounds.width - (16 + 16),
                height: 40
            )
        }
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_ended", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
    }
    
    
    // MARK: Private
    
    // MARK: Properties
    
    private lazy var sections: [SectionLayout] = [
        WatchlistSectionLayout(),
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
    
    
    private var searchCollectionView: UICollectionView!
    private var searchController: CollectionSearchController?
    private var showCollectionDetailsBtn: UIButton?
    private var searchTextField: UITextField?
    
    // MARK: Functions
    
    @objc
    private func discoverCollectionsButtonTapped() {
        GainyAnalytics.logEvent("discover_collection_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        
        // TODO: Go back to source collection
        self.goToCollectionDetails(at: 0)
    }
    
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
        showNetworkLoader()
        
        DispatchQueue.global(qos:.utility).async {
            CollectionsManager.shared.loadNewCollectionDetails(collectionItemToAdd.id) {
                runOnMain {
                    self.hideLoader()
                }
            }
        }
        
        UserProfileManager.shared.addFavouriteCollection(yourCollectionItem.id) { success in
            
            self.viewModel?.yourCollections.append(yourCollectionItem)
            UserProfileManager.shared.recommendedCollections[indexRow].isInYourCollections = true
            
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
                snapshot.deleteItems([collectionItemToAdd])
                self.viewModel?.addedRecs[collectionItemToAdd.id] = collectionItemToAdd
                
                self.dataSource?.apply(snapshot, animatingDifferences: true)
            }
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
                
                if let indexOfRecommendedItemToDelete = UserProfileManager.shared.recommendedCollections
                    .firstIndex(where: { $0.id == yourCollectionItemToRemove.id }) {
                    UserProfileManager.shared.recommendedCollections[indexOfRecommendedItemToDelete].isInYourCollections = false
                    
                    if var itemToReload  = snapshot.itemIdentifiers(inSection: .recommendedCollections).first(where: {
                        if let item = $0 as? RecommendedCollectionViewCellModel {
                            return item.id == itemId
                        }
                        return false
                    }) as? RecommendedCollectionViewCellModel {
                        snapshot.reloadItems([itemToReload])
                    }
                }
                
                snapshot.deleteItems([deleteItems])
                
                if let recColl = viewModel?.addedRecs[yourCollectionItemToRemove.id] {
                    snapshot.appendItems([recColl], toSection: .recommendedCollections)
                    viewModel?.addedRecs.removeValue(forKey: yourCollectionItemToRemove.id)
                }
                dataSource?.apply(snapshot, animatingDifferences: true)
                onItemDelete?(DiscoverCollectionsSection.yourCollections, itemId)
            }
            
        }
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
                
        onSwapItems?(sourceItem?.id ?? 0, destItem?.id ?? 0)
        
        let fromIndex = sourceIndexPath.row
        let toIndex = destinationIndexPath.row
        UserProfileManager.shared.favoriteCollections.move(from: fromIndex, to: toIndex)
        UserProfileManager.shared.yourCollections.move(from: fromIndex, to: toIndex)
        
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
            snap.deleteSections([.watchlist, .yourCollections, .recommendedCollections])
        }
        snap.appendSections([.watchlist, .yourCollections, .recommendedCollections])
        snap.appendItems(viewModel?.watchlistCollections ?? [], toSection: .watchlist)
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
        
        
        if let watchlist = CollectionsManager.shared.watchlistCollection,  viewModel?.watchlistCollections.count == 0 {
            let watchDTO: YourCollectionViewCellModel = CollectionViewModelMapper.map(CollectionDTOMapper.map(watchlist))
            viewModel?.watchlistCollections.insert(watchDTO, at: 0)
        }
        
        var recColls: [RecommendedCollectionViewCellModel] = []
        
        for (_, val) in UserProfileManager.shared.recommendedCollections.enumerated() {
            if val.isInYourCollections {
                viewModel?.addedRecs[val.id] = CollectionViewModelMapper.map(val)
            } else {
                recColls.append(CollectionViewModelMapper.map(val))
            }
        }
        
        for (_, val) in UserProfileManager.shared.yourCollections.enumerated() {
            viewModel?.addedRecs[val.id] = CollectionViewModelMapper.map(val)
        }
    
        viewModel?.recommendedCollections = recColls
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

extension DiscoverCollectionsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 240, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 0)
    }
}


extension DiscoverCollectionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == DiscoverCollectionsSection.watchlist.rawValue {
            self.goToCollectionDetails(at: 0)
        }
        else if indexPath.section == DiscoverCollectionsSection.yourCollections.rawValue {
            //TO-Do: - Serhii plz check this
            //GainyAnalytics.logEvent("your_collection_pressed", params: ["collectionID": UserProfileManager.shared.yourCollections[indexPath.row].id, "type" : "yours", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
            let index = indexPath.row
            let increment = (viewModel?.watchlistCollections.count ?? 0) > 0 ? 1 : 0
            self.goToCollectionDetails(at: index + increment)
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
            if indexPath.row == 0 {
                return []
            }
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
        
        guard destination.section == DiscoverCollectionsSection.yourCollections.rawValue,
              destination.row > 0 else {
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

