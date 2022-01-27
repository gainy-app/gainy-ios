import Foundation
import UIKit
import PureLayout
import FloatingPanel
import Firebase
import SkeletonView
import SwiftDate

private enum CollectionDetailsSection: Int, CaseIterable {
    case collectionWithCards
}

final class CollectionDetailsViewController: BaseViewController, CollectionDetailsViewControllerProtocol {    
    // MARK: Internal
    private let barrierQueue = DispatchQueue(label: "CollectionsFetcherQueue", attributes: .concurrent)
    
    
    // MARK: Properties
    
    weak var authorizationManager: AuthorizationManager?
    var viewModel: CollectionDetailsViewModelProtocol?
    var coordinator: MainCoordinator?
    
    var onDiscoverCollections: ((Bool) -> Void)?
    var onShowCardDetails: (([RemoteTickerDetails], Int) -> Void)?
    
    //Panel
    private var fpc: FloatingPanelController!
    private var currentCollectionToChange: Int = 0
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    private var needTop20Reload = false
    
    //Analytics
    var collectionID: Int {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint), let collectionDetails = viewModel?.collectionDetails, collectionDetails.count > visibleIndexPath.row  {
            return collectionDetails[visibleIndexPath.row].id
        } else {
            // Let it be not found, -1 is reserved for the watchlist
            return -404
        }
    }
    
    fileprivate func handleNotificationsEvents() {
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
                                    self?.initViewModelsFromData()
                                    self?.initViewModels()
                                    self?.centerInitialCollectionInTheCollectionView()
                                }
                            }
                        }
                    }
                }
            }
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: Notification.Name.didChangeProfileInterests)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] notification in
                self?.needTop20Reload = true
            }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: Notification.Name.didChangeProfileCategories)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] notification in
                self?.needTop20Reload = true
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
        
        collectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: navigationBarTopOffset,
                width: view.bounds.width,
                height: view.bounds.height - navigationBarTopOffset
            ),
            collectionViewLayout: customLayout
        )
        collectionView.isSkeletonable = true
        view.addSubview(collectionView)
        collectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        collectionView.autoPinEdge(.leading, to: .leading, of: view)
        collectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        collectionView.register(CollectionDetailsViewCell.self)
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dragInteractionEnabled = true
        collectionView.bounces = false
        
        collectionView.dataSource = dataSource
        
        dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>(
            collectionView: collectionView
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
                    if !(ticker.name?.hasPrefix(Constants.CollectionDetails.demoNamePrefix) ?? false) {
                        if let model = self?.viewModel?.collectionDetails[indexPath.row] {
                            if let index = model.cards.firstIndex(where: {$0.tickerSymbol == ticker.symbol}) {
                                self?.onShowCardDetails?(model.cards.map(\.rawTicker), index)
                            }
                        }
                    }
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
                cell.onSettingsPressed = {[weak self]  ticker in
                    guard let self = self else {return}
                    self.coordinator?.showMetricsViewController(ticker:ticker, collectionID: modelItem.id, delegate: self)
                }
                cell.onNewCardsLoaded = { [weak self] newCards in
                    if var oldModel = self?.viewModel?.collectionDetails[indexPath.row] {
                        oldModel.addCards(newCards)
                        self?.viewModel?.collectionDetails[indexPath.row] = oldModel
                    }
                    
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
        searchController = CollectionSearchController.init(collectionView: searchCollectionView, callback: {[weak self] tickers, ticker in
            if let index = tickers.firstIndex(where: {$0.symbol == ticker.symbol}) {
                self?.onShowCardDetails?(tickers, index)
            }
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
        searchController?.onNewsClicked = {[weak self] newsUrl in
            if let self = self {
                WebPresenter.openLink(vc: self, url: newsUrl)
            }
        }
        
        searchController?.coordinator = coordinator
        handleNotificationsEvents()
        setupPanel()
        
        CollectionsManager.shared.newCollectionsPublisher
            .receive(on: RunLoop.main)
            .sink {[unowned self] result in
                switch result {
                case .fetched(let model):
                    barrierQueue.async(flags: .barrier) {
                        self.addNewCollections([model])
                    }
                    break
                case .deleted(let model):
                    barrierQueue.async(flags: .barrier) {
                        self.deleteCollections([model])
                    }
                    break
                case .updated(model: let model):
                    barrierQueue.async(flags: .barrier) {
                        self.updateCollections([model])
                    }
                    break
                case .fetchedFailed:
                    break
                }
            }.store(in: &self.cancellables)
        
        TickerLiveStorage.shared.matchScoreClearedPublisher
            .receive(on: RunLoop.main)
            .sink {[unowned self] _ in
                dprint("Reloading visible cells after MS clear")
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    if var snapshot = self.dataSource?.snapshot() {
                        if snapshot.itemIdentifiers.count > 0 {
                            let ids =  self.collectionView.indexPathsForVisibleItems.compactMap({$0.row}).compactMap({snapshot.itemIdentifiers[$0]})
                            snapshot.reloadItems(ids)
                        }
                        self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                            
                        })
                    }
                }
            }.store(in: &self.cancellables)
        
        addLoaders()
    }
    
    private func appendNewCollectionsFromModels(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        runOnMain {
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
                        self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                            completed?()
                        })
                    } else {
                        completed?()
                    }
                } else {
                    completed?()
                }
            } else {
                completed?()
            }
        }
    }
    
    private func appendWatchlistCollectionsFromModels(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        runOnMain {
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
                        self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                            completed?()
                        })
                    } else {
                        completed?()
                    }
                } else {
                    completed?()
                }
            } else {
                completed?()
            }
        }
    }
    
    private func addNewCollections(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        runOnMain {
            self.appendNewCollectionsFromModels(models) {
                self.appendWatchlistCollectionsFromModels(models) {
                    completed?()
                }
            }
        }
    }
    
    private func deleteCollections(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        runOnMain {
            self.viewModel?.collectionDetails.removeAll(where: { item in
                models.contains(item)
            })
            if var snapshot = self.dataSource?.snapshot() {
                if snapshot.indexOfSection(.collectionWithCards) != nil {
                    snapshot.deleteItems(models)
                    self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                        completed?()
                    })
                }
            }
        }
    }
    
    private func updateCollections(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        runOnMain {
            let mainDS = DispatchGroup()
            for model in models {
                if let modelIndex = self.viewModel?.collectionDetails.firstIndex(where: {$0.id == model.id}) {
                    self.viewModel?.collectionDetails[modelIndex] = model
                }
                if var snapshot = self.dataSource?.snapshot() {
                    
                    if let modelIndex = snapshot.itemIdentifiers(inSection: .collectionWithCards).firstIndex(where: {$0.id == model.id}) {
                        snapshot.deleteItems([snapshot.itemIdentifiers(inSection: .collectionWithCards)[modelIndex]])
                        snapshot.insertItems([model], afterItem: snapshot.itemIdentifiers(inSection: .collectionWithCards)[modelIndex > 1 ? modelIndex - 1 : 0])
                    }
                    mainDS.enter()
                    self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                        mainDS.leave()
                    })
                }
            }
            
            mainDS.notify(queue: DispatchQueue.main) {
                completed?()
            }
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
            self.collectionView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.discoverCollectionsBtn?.alpha = 1.0
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
            self.collectionView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
            self.discoverCollectionsBtn?.alpha = 0.0
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
        HorizontalFlowSectionLayout(),
    ]
    
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        layout.configuration.scrollDirection = .horizontal
        return layout
    }()
    
    private var collectionView: UICollectionView!
    private var searchCollectionView: UICollectionView!
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, CollectionDetailViewCellModel>()
    
    private var searchController: CollectionSearchController?
    private var discoverCollectionsBtn: UIButton?
    private var searchTextField: UITextField?
    
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
            fetchFailedCollections {
                DispatchQueue.main.async { [weak self] in
                    self?.centerInitialCollectionInTheCollectionView()
                }
            }
            return
        }
        
        if !CollectionsManager.shared.collections.isEmpty {
            if let lastLoadDate = CollectionsManager.shared.lastLoadDate {
                if Date() < lastLoadDate + 15.minutes {
                    self.hideLoader()
                    completion()
                    return
                }
            } else {
                self.hideLoader()
                completion()
                return
            }
        }
        CollectionsManager.shared.initialCollectionsLoading {[weak self] _ in
            DispatchQueue.main.async {
                self?.initViewModelsFromData()
                self?.hideLoader()
                completion()
            }
        }
    }
    
    private func fetchFailedCollections(completion: @escaping () -> Void) {
        showNetworkLoader()
        
        CollectionsManager.shared.reloadNewCollectionsDetails(Array(CollectionsManager.shared.failedToLoad)) {[weak self] collections in
            CollectionsManager.shared.collections.append(contentsOf: collections)
            if let index = UserProfileManager.shared.favoriteCollections.firstIndex(of: Constants.CollectionDetails.top20ID), UserProfileManager.shared.favoriteCollections.count > 1 {
                UserProfileManager.shared.favoriteCollections.swapAt(index, 0)
            }
            CollectionsManager.shared.collections = CollectionsManager.shared.collections.reorder(by: UserProfileManager.shared.favoriteCollections)
            
            CollectionsManager.shared.lastLoadDate = Date()
            DispatchQueue.main.async {
                
                let newModels = CollectionsManager.shared.convertToModel(collections)
                self?.addNewCollections(newModels) {
                    completion()
                    self?.hideLoader()
                }
            }
        }
    }
    
    @objc
    private func discoverCollectionsButtonTapped() {
        GainyAnalytics.logEvent("discover_collections_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        onDiscoverCollections?(false)
    }
    
    private func createNavigationBarContainer() -> UIView {
        UIView()
    }
    
    func centerInitialCollectionInTheCollectionView() {
        guard let snap = dataSource?.snapshot() else {return}
        guard viewModel?.initialCollectionIndex ?? 0 < viewModel?.collectionDetails.count ?? 0 else {
            if !(discoverCollectionsBtn?.isEnabled ?? false){
                if snap.sectionIdentifiers.count > 0 {
                    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                at: .centeredHorizontally,
                                                animated: false)
                }
            }
            return
        }
        let initialItemToShow = viewModel?.initialCollectionIndex ?? 0
        
        if snap.sectionIdentifiers.count > 0 {
            collectionView.scrollToItem(at: IndexPath(item: initialItemToShow, section: 0),
                                        at: .centeredHorizontally,
                                        animated: false)
        }
    }
    
    func currentBackgroundImageFrame() -> CGRect {
        
        let initialItemToShow = viewModel?.initialCollectionIndex ?? 0
        if let cell: CollectionDetailsViewCell = collectionView.cellForItem(at: IndexPath(item: initialItemToShow, section: 0)) as? CollectionDetailsViewCell {
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
            
            dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                
            })
        }
        searchTextField?.isEnabled = true
        discoverCollectionsBtn?.isEnabled = true
    }
    
    private func addLoaders() {
        if var snapshot = dataSource?.snapshot() {
            if snapshot.sectionIdentifiers.count > 0 {
                snapshot.deleteSections([.collectionWithCards])
            }
            snapshot.appendSections([.collectionWithCards])
            
            //Demo cells
            snapshot.appendItems(CollectionDetailsDTOMapper.loaderModels(),
                                 toSection: .collectionWithCards)
            
            dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                runOnMain {
                    self.centerInitialCollectionInTheCollectionView()
                }
            })
        }
        searchTextField?.isEnabled = false
        discoverCollectionsBtn?.isEnabled = false
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
        if self.needTop20Reload {
            TickerLiveStorage.shared.clearMatchData()
            CollectionsManager.shared.reloadTop20 {
                self.collectionView.reloadData()
            }
        } else {
            reloadCollectionIfNeeded()
        }
    }
    
    private func reloadCollectionIfNeeded() {
        if Auth.auth().currentUser != nil {
            self.reloadCollection()
        }
    }
    
    private func reloadCollection() {
        guard let profileID = UserProfileManager.shared.profileID else { return }
        guard !UserProfileManager.shared.favoriteCollections.isEmpty else {
            self.onDiscoverCollections?(false)
            return
        }
        
        getRemoteData(loadProfile: true) {
            DispatchQueue.main.async { [weak self] in
                self?.initViewModels()
                self?.centerInitialCollectionInTheCollectionView()
                self?.hideLoader()
                
                let discoverShownForProfileKey = String(profileID) + "DiscoverCollectionsShownKey"
                let shown = UserDefaults.standard.bool(forKey: discoverShownForProfileKey)
                if !shown {
                    UserDefaults.standard.set(true, forKey: discoverShownForProfileKey)
                    self?.onDiscoverCollections?(true)
                    return
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
        dataSource?.apply(snapshot, animatingDifferences: true, completion: {
            
        })
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
            dataSource?.apply(snapshot, animatingDifferences: true, completion: {
                
            })
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


extension CollectionDetailsViewController: MetricsViewControllerDelegate {
    
    func didDismissMetricsViewController() {
        
        self.collectionView.reloadData()
    }
}
