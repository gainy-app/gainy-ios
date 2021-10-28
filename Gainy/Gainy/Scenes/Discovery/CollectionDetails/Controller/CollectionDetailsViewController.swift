import Foundation
import UIKit
import PureLayout
import FloatingPanel
import Firebase

private enum CollectionDetailsSection: Int, CaseIterable {
    case collectionWithCards
}

final class CollectionDetailsViewController: BaseViewController, CollectionDetailsViewControllerProtocol {    
    // MARK: Internal
    
    // MARK: Properties
    
    weak var authorizationManager: AuthorizationManager?
    var viewModel: CollectionDetailsViewModelProtocol?
    var coordinator: MainCoordinator?
    
    var onDiscoverCollections: ((Bool) -> Void)?
    var onShowCardDetails: ((RemoteTickerDetails) -> Void)?
    
    //Panel
    private var fpc: FloatingPanelController!
    private var currentCollectionToChange: Int = 0
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    //Analytics
    var collectionID: Int {
        let visibleRect = CGRect(origin: collectionDetailsCollectionView.contentOffset, size: collectionDetailsCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionDetailsCollectionView.indexPathForItem(at: visiblePoint) {
            return viewModel?.collectionDetails[visibleIndexPath.row].id ?? 0
        } else {
            // Let it be not found, -1 is reserved for my collection (watchlist)
            return -404
        }
    }
    
    fileprivate func handleLoginEvent() {
        NotificationCenter.default.publisher(for: Notification.Name.didReceiveFirebaseAuthToken).sink { _ in
        } receiveValue: {[weak self] notification in
            if let token = notification.object as? String {
                if let profileID = UserProfileManager.shared.profileID {
                    
                    let discoverShownForProfileKey = String(profileID) + "DiscoverCollectionsShownKey"
                    let shown = UserDefaults.standard.bool(forKey: discoverShownForProfileKey)
                    if !shown {
                        UserDefaults.standard.set(true, forKey: discoverShownForProfileKey)
                        self?.onDiscoverCollections?(true)
                        return
                    }
                    
                    if UserProfileManager.shared.favoriteCollections.isEmpty {
                        self?.onDiscoverCollections?(false)
                    } else {
                        if self?.searchCollectionView.alpha ?? 0.0 == 0.0 {
                            self?.getRemoteData(loadProfile: true) {
                                DispatchQueue.main.async {
                                    self?.initViewModels()
                                    self?.centerInitialCollectionInTheCollectionView()
                                }
                            }
                        }
                    }
                }
            }
        }.store(in: &cancellables)
    }
    
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
        
        discoverCollectionsButton.setImage(UIImage(named: "discover-collections"), for: .normal)
        discoverCollectionsButton.addTarget(self,
                                            action: #selector(discoverCollectionsButtonTapped),
                                            for: .touchUpInside)
        
        navigationBarContainer.addSubview(discoverCollectionsButton)
        discoverCollectionsBtn = discoverCollectionsButton
        let searchTextView = UITextField(
            frame: CGRect(
                x: 16,
                y: 24,
                width: navigationBarContainer.bounds.width - (16 + 16 + 32 + 20),
                height: 40
            )
        )
        
        searchTextView.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        searchTextView.textColor = UIColor(named: "mainText")
        searchTextView.layer.cornerRadius = 16
        searchTextView.isUserInteractionEnabled = true
        searchTextView.placeholder = "Search anything"
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
        
        searchTextView.leftView = searchIconContainerView
        searchTextView.leftViewMode = .always
        searchTextView.rightViewMode = .whileEditing
        searchTextView.backgroundColor = UIColor.Gainy.lightBack
        searchTextView.returnKeyType = .done
        
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
        searchTextView.rightView = btnFrame
        
        searchTextView.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        searchTextView.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        searchTextView.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchTextView.delegate = self
        navigationBarContainer.addSubview(searchTextView)
        self.searchTextView = searchTextView
        
        view.addSubview(navigationBarContainer)
        
        let navigationBarTopOffset =
        navigationBarContainer.frame.origin.y + navigationBarContainer.bounds.height
        
        collectionDetailsCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: navigationBarTopOffset,
                width: view.bounds.width,
                height: view.bounds.height - navigationBarTopOffset
            ),
            collectionViewLayout: customLayout
        )
        view.addSubview(collectionDetailsCollectionView)
        collectionDetailsCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        collectionDetailsCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        collectionDetailsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        collectionDetailsCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        collectionDetailsCollectionView.register(CollectionDetailsViewCell.self)
        
        collectionDetailsCollectionView.backgroundColor = .clear
        collectionDetailsCollectionView.showsVerticalScrollIndicator = false
        collectionDetailsCollectionView.dragInteractionEnabled = true
        collectionDetailsCollectionView.bounces = false
        
        collectionDetailsCollectionView.dataSource = dataSource
        
        dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>(
            collectionView: collectionDetailsCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )
            
            if let cell = cell as? CollectionDetailsViewCell {
                cell.tag = modelItem.id
                cell.onCardPressed = {[weak self]  ticker in
                    self?.onShowCardDetails?(ticker)
                }
                cell.onSortingPressed = { [weak self] in
                    guard let self = self else {return}
                    guard self.presentedViewController == nil else {return}
                    
                        self.sortingVS.collectionId = modelItem.id
                        self.sortingVS.collectionCell = cell
                        self.currentCollectionToChange = modelItem.id
                        GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                    
                    self.present(self.fpc, animated: true, completion: nil)
                }
            }
            return cell
        }
        
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
        searchController = CollectionSearchController.init(collectionView: searchCollectionView, callback: {[weak self] ticker in
            self?.onShowCardDetails?(ticker)
        })
        searchController?.collectionsUpdated = { [weak self] in
            self?.getRemoteData(loadProfile: true) {
                DispatchQueue.main.async { [weak self] in
                    self?.initViewModels()
                    self?.centerInitialCollectionInTheCollectionView()
                }
            }
        }
        searchController?.onCollectionDelete = {[weak self] collectionId in
            self?.deleteItem(collectionId)
        }
        
        searchController?.coordinator = coordinator
        handleLoginEvent()
        setupPanel()
        
        CollectionsManager.shared.newCollectionsPublisher
            .receive(on: RunLoop.main)
            .sink {[unowned self] result in
            switch result {
            case .fetched(let model):
                self.addNewCollections([model])
                break
            case .deleted(let model):
                self.deleteCollections([model])
                break
            case .fetchedFailed:
                break
            }
        }.store(in: &self.cancellables)
        
        TickerLiveStorage.shared.matchScoreClearedPublisher
            .receive(on: RunLoop.main)
            .sink {[unowned self] _ in
            dprint("Reloading visible cells after MS clear")
            if var snapshot = self.dataSource?.snapshot() {
                if snapshot.itemIdentifiers.count > 0 {
                    let ids =  self.collectionDetailsCollectionView.indexPathsForVisibleItems.compactMap({$0.row}).compactMap({snapshot.itemIdentifiers[$0]})
                    snapshot.reloadItems(ids)
                }
                self.dataSource?.apply(snapshot, animatingDifferences: false)
            }
        }.store(in: &self.cancellables)
    }
    
    private func appendNewCollectionsFromModels(_ models: [CollectionDetailViewCellModel]) {
        
        let collections = models.filter { item in
            item.id >= 0
        }
        if collections.count > 0 {
            self.viewModel?.collectionDetails.append(contentsOf: collections)
            if var snapshot = self.dataSource?.snapshot() {
                if snapshot.indexOfSection(.collectionWithCards) != nil {
                    if let last = snapshot.itemIdentifiers(inSection: .collectionWithCards).last {
                        snapshot.insertItems(collections, afterItem: last)
                    } else {
                        snapshot.appendItems(collections,
                                             toSection: .collectionWithCards)
                    }
                    self.dataSource?.apply(snapshot, animatingDifferences: false)
                }
            }
        }
    }
    
    private func appendWatchlistCollectionsFromModels(_ models: [CollectionDetailViewCellModel]) {
        
        let watchlistCollections = models.filter { item in
            item.id < 0
        }
        if let firstItem = watchlistCollections.first {
            deleteCollections(watchlistCollections)
            self.viewModel?.collectionDetails.insert(firstItem, at: 0)
            if var snapshot = self.dataSource?.snapshot() {
                if snapshot.indexOfSection(.collectionWithCards) != nil {
                    if let first = snapshot.itemIdentifiers(inSection: .collectionWithCards).first {
                        snapshot.insertItems(watchlistCollections, beforeItem: first)
                    } else {
                        snapshot.appendItems(watchlistCollections,
                                             toSection: .collectionWithCards)
                    }
                    self.dataSource?.apply(snapshot, animatingDifferences: false)
                }
            }
        }
    }
    
    private func addNewCollections(_ models: [CollectionDetailViewCellModel]) {
        
        self.appendNewCollectionsFromModels(models)
        self.appendWatchlistCollectionsFromModels(models)
    }
    
    private func deleteCollections(_ models: [CollectionDetailViewCellModel]) {
        self.viewModel?.collectionDetails.removeAll(where: { item in
            models.contains(item)
        })
        if var snapshot = self.dataSource?.snapshot() {
            if snapshot.indexOfSection(.collectionWithCards) != nil {
                snapshot.deleteItems(models)
                self.dataSource?.apply(snapshot, animatingDifferences: false)
            }
        }
    }
    
    public func cancelSearchAsNeeded() {
        
        if searchCollectionView.alpha > 0.0 {
            textFieldClear()
        }
    }
    
    @objc func textFieldClear() {
        searchTextView?.text = ""
        searchController?.searchText = searchTextView?.text ?? ""
        searchController?.clearAll()
        
        searchTextView?.resignFirstResponder()
        
        let oldFrame = CGRect(
            x: 16,
            y: 24,
            width: self.view.bounds.width - (16 + 16 + 32 + 20),
            height: 40
        )
        UIView.animate(withDuration: 0.3) {
            self.collectionDetailsCollectionView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.discoverCollectionsBtn?.alpha = 1.0
            self.searchTextView?.frame = oldFrame
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        searchController?.searchText = text
        
        if text.count > 0 {
            searchTextView?.clearButtonMode = .always
            searchTextView?.clearButtonMode = .whileEditing
        } else {
            searchTextView?.clearButtonMode = .never
        }
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_started", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        searchController?.searchText =  ""
        UIView.animate(withDuration: 0.3) {
            self.collectionDetailsCollectionView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
            self.discoverCollectionsBtn?.alpha = 0.0
            self.searchTextView?.frame = CGRect(
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
        HorizontalFlowSectionLayout(),
    ]
    
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()
    
    private var collectionDetailsCollectionView: UICollectionView!
    private var searchCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, CollectionDetailViewCellModel>()
    
    private var searchController: CollectionSearchController?
    private var discoverCollectionsBtn: UIButton?
    private var searchTextView: UITextField?
    
    // MARK: Functions
    
    private func getRemoteData(loadProfile: Bool = false, completion: @escaping () -> Void) {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            return
        }
        guard let profileID = UserProfileManager.shared.profileID else {
            
            if let authorizationManager = self.authorizationManager {
                authorizationManager.refreshAuthorizationStatus { status in
                    if status == .authorizedFully {
                        guard UserProfileManager.shared.profileID != nil else {
                            completion()
                            return
                        }
                        self.getRemoteData(completion: completion)
                    } else {
                        completion()
                        return
                    }
                }
                return
            }
            completion()
            return
        }
        
        if (loadProfile) {
            showNetworkLoader()
            Network.shared.apollo.clearCache()
            UserProfileManager.shared.fetchProfile { success in
                
                guard success == true else {
                    NotificationManager.shared.showError("Sorry... No Collections to display.")
                    completion()
                    self.hideLoader()
                    return
                }
                
                self.getRemoteData(completion: completion)
            }
            return
        }
        
        
        //Using Cache
        guard !CollectionsManager.shared.haveUnfetchedItems else {
            showNetworkLoader()
            fetchFailedCollections {
                DispatchQueue.main.async { [weak self] in
                    self?.centerInitialCollectionInTheCollectionView()
                }
            }
            return
        }
        
        guard CollectionsManager.shared.collections.isEmpty else {
            self.hideLoader()
            completion()
            return
        }
        
        showNetworkLoader()
        Network.shared.apollo.fetch(query: FetchSelectedCollectionsQuery(ids: UserProfileManager.shared.favoriteCollections)) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let collections = graphQLResult.data?.collections.compactMap({$0.fragments.remoteCollectionDetails}) else {
                    //Going back
                    self?.hideLoader()
                    completion()
                    return
                }
                CollectionsManager.shared.collections = collections.reorder(by: UserProfileManager.shared.favoriteCollections)

                DispatchQueue.main.async {
                    self?.initViewModelsFromData()
                    self?.hideLoader()
                    CollectionsManager.shared.loadWatchlistCollection {
                    }
                    completion()
                }
                
                //Paging
                self?.viewModel?.collectionOffset = CollectionsManager.shared.collections.count + 1
                self?.viewModel?.hasMorePages = (collections.count == 20)
                
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                self?.initViewModelsFromData()
                completion()
                self?.hideLoader()
            }
        }
    }
    
    private func fetchFailedCollections(completion: @escaping () -> Void) {
        showNetworkLoader()
        Network.shared.apollo.fetch(query: FetchSelectedCollectionsQuery(ids: Array(CollectionsManager.shared.failedToLoad))) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                guard let collections = graphQLResult.data?.collections.compactMap({$0.fragments.remoteCollectionDetails}) else {
                    //Going back
                    self?.hideLoader()
                    completion()
                    return
                }
                CollectionsManager.shared.collections.append(contentsOf: collections)
                CollectionsManager.shared.collections = CollectionsManager.shared.collections.reorder(by: UserProfileManager.shared.favoriteCollections)
                
                DispatchQueue.main.async {
                    
                    let newModels = CollectionsManager.shared.convertToModel(collections)
                    self?.addNewCollections(newModels)
                    
                    completion()
                    self?.hideLoader()
                }
                
            case .failure(let error):
                dprint("Failure when making GraphQL request. Error: \(error)")
                completion()
                self?.hideLoader()
            }
        }
    }
    
    @objc
    private func discoverCollectionsButtonTapped() {
        GainyAnalytics.logEvent("discover_collections_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        onDiscoverCollections?(false)
    }
    
    // TODO: 1: implement class to have navBarContainer view
    private func createNavigationBarContainer() -> UIView {
        UIView()
    }
    
    func centerInitialCollectionInTheCollectionView() {
        guard let snap = dataSource?.snapshot() else {return}
        guard viewModel?.initialCollectionIndex ?? 0 < viewModel?.collectionDetails.count ?? 0 else {return}
        let initialItemToShow = viewModel?.initialCollectionIndex ?? 0
        
        if snap.sectionIdentifiers.count > 0 {
            collectionDetailsCollectionView.scrollToItem(at: IndexPath(item: initialItemToShow, section: 0),
                                                         at: .centeredHorizontally,
                                                         animated: false)
        }
    }
    
    func currentBackgroundImageFrame() -> CGRect {
        
        let initialItemToShow = viewModel?.initialCollectionIndex ?? 0
        if let cell: CollectionDetailsViewCell = collectionDetailsCollectionView.cellForItem(at: IndexPath(item: initialItemToShow, section: 0)) as? CollectionDetailsViewCell {
            let horizontalView = cell.collectionHorizontalView
            return self.view.convert(horizontalView.frame, from: horizontalView)
        } else {
            return CGRect.zero
        }
    }
    
    private func initViewModelsFromData() {
        var array = CollectionsManager.shared.collections
        
        if let watchlist = CollectionsManager.shared.watchlistCollection {
            array.insert(watchlist, at: 0)
        }
        viewModel?.collectionDetails = CollectionsManager.shared.convertToModel(array)
    }
    
    private func initViewModels() {
        if var snapshot = dataSource?.snapshot() {
            if snapshot.sectionIdentifiers.count > 0 {
                snapshot.deleteSections([.collectionWithCards])
            }
            snapshot.appendSections([.collectionWithCards])
            snapshot.appendItems(viewModel?.collectionDetails ?? [],
                                 toSection: .collectionWithCards)
            
            dataSource?.apply(snapshot, animatingDifferences: false)
        }
    }
    
    private lazy var sortingVS = SortCollectionDetailsViewController.instantiate(.popups)
    private func setupPanel() {
        fpc = FloatingPanelController()
        fpc.layout = MyFloatingPanelLayout()
        let appearance = SurfaceAppearance()
        
        // Define corner radius and background color
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        
        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        
        // Set a content view controller.
        sortingVS.delegate = self
        fpc.set(contentViewController: sortingVS)
        fpc.isRemovalInteractionEnabled = true
        
        // Add and show the views managed by the `FloatingPanelController` object to self.view.
        //fpc.addPanel(toParent: self)
    }
    
    class MyFloatingPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 333.0, edge: .bottom, referenceGuide: .safeArea),
            ]
        }
        
        func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
            switch state {
            case .full,
                    .half,
                    .tip: return 0.3
            default: return 0.0
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadCollectionIfNeeded()
    }
    
    private func reloadCollectionIfNeeded() {
        if Auth.auth().currentUser != nil {
            
            if let profileID = UserProfileManager.shared.profileID {
                
                let discoverShownForProfileKey = String(profileID) + "DiscoverCollectionsShownKey"
                let shown = UserDefaults.standard.bool(forKey: discoverShownForProfileKey)
                                
                if UserProfileManager.shared.favoriteCollections.isEmpty {
                    self.onDiscoverCollections?(false)
                } else {
                    getRemoteData(loadProfile: true) {
                        DispatchQueue.main.async { [weak self] in
                            self?.initViewModels()
                            self?.centerInitialCollectionInTheCollectionView()
                            
                            if !shown {
                                UserDefaults.standard.set(true, forKey: discoverShownForProfileKey)
                                self?.onDiscoverCollections?(true)
                                return
                            }
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Swap Items
    
    func swapItemsAt(_ sourceId: Int, destId: Int) {
        
        CollectionsManager.shared.collections.swapIDs(sourceId, destId)
        viewModel?.collectionDetails.swapIDs(sourceId, destId)
        guard var snapshot = dataSource?.snapshot() else {return}
        
        guard let sourceItem = snapshot.itemIdentifiers(inSection: .collectionWithCards).first(where: { anyHashable in
            if let model = anyHashable as? CollectionDetailViewCellModel {
                return model.id == sourceId
            }
            return false
        }) else {return}
        
        guard let destItem = snapshot.itemIdentifiers(inSection: .collectionWithCards).first(where: { anyHashable in
            if let model = anyHashable as? CollectionDetailViewCellModel {
                return model.id == destId
            }
            return false
        }) else {return}
        
        snapshot.moveItem(sourceItem, beforeItem: destItem)
        dataSource?.apply(snapshot)
    }
    
    //MARK: - Delete Items
    
    func deleteItem(_ sourceItemID: Int) {
        //Sources delete
        CollectionsManager.shared.collections.removeAll(where: {$0.id == sourceItemID})
        viewModel?.collectionDetails.removeAll(where: {$0.id == sourceItemID})
        
        guard var snapshot = dataSource?.snapshot() else {return}
        guard snapshot.sectionIdentifiers.contains(.collectionWithCards) else {return}
        if let sourceItem = snapshot.itemIdentifiers(inSection: .collectionWithCards).first(where: { anyHashable in
            if let model = anyHashable as? CollectionDetailViewCellModel {
                return model.id == sourceItemID
            }
            return false
        }) {
            snapshot.deleteItems([sourceItem])
            dataSource?.apply(snapshot)
        }
    }
}

extension CollectionDetailsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension CollectionDetailsViewController: SortCollectionDetailsViewControllerDelegate {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String) {
        GainyAnalytics.logEvent("sorting_changed", params: ["collectionID": currentCollectionToChange, "sorting" : sorting, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        self.fpc.dismiss(animated: true, completion: nil)
    }
}

extension CollectionDetailsViewController: FloatingPanelControllerDelegate {
    
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            
            if let prevY = floatingPanelPreviousYPosition {
                shouldDismissFloatingPanel = prevY < vc.surfaceLocation.y
            }
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
            let maxY = vc.surfaceLocation(for: .tip).y
            vc.surfaceLocation = CGPoint(x: loc.x, y: max(loc.y, minY))
            floatingPanelPreviousYPosition = max(loc.y, minY)
        }
    }
    
    func floatingPanelDidEndDragging(_ fpc: FloatingPanelController, willAttract attract: Bool) {
        if shouldDismissFloatingPanel {
            self.fpc.dismiss(animated: true, completion: nil)
        }
    }
}
