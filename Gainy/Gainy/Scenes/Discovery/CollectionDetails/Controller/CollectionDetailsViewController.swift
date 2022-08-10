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
    private var skipReload: Bool = false
    private var navigationBarContainer: UIView = UIView()
    private var blurViewHeightConstraint: NSLayoutConstraint?
    private var lastOffset: CGFloat = 0.0
    
    //Panel
    private var fpc: FloatingPanelController!
    private var currentCollectionToChange: Int = 0
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    private var needTop20Reload = false
    private var currentCollectionViewCell: CollectionDetailsViewCell?
    
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
                    
                    let isEmpty = UserProfileManager.shared.favoriteCollections.isEmpty
                    if isEmpty {
                        self?.onDiscoverCollections?(false)
                    } else {
                        if self?.searchCollectionView.alpha ?? 0.0 == 0.0 {
                            self?.getRemoteData(loadProfile: false) {
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
        
        let navBarFrame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top + 36,
            width: view.bounds.width,
            height: 110
        )
        let navigationBarContainerView = UIView(frame:navBarFrame)
        navigationBarContainerView.backgroundColor = .clear
        
        let navigationBarTopOffset =
        navigationBarContainerView.frame.origin.y + navigationBarContainerView.bounds.height
        
        let blurView = BlurEffectView()
        view.addSubview(blurView)
        
        blurView.autoPinEdge(toSuperviewEdge: .leading)
        blurView.autoPinEdge(toSuperviewEdge: .top)
        blurView.autoPinEdge(toSuperviewEdge: .trailing)
        self.blurViewHeightConstraint = blurView.autoSetDimension(.height, toSize: navigationBarTopOffset + 8.0)
        
        view.fillRemoteBack()
        
        
        let discoverCollectionsButton = UIButton(
            frame: CGRect(
                x: navigationBarContainerView.bounds.width - (32 + 20),
                y: 28,
                width: 32,
                height: 32
            )
        )
        
        discoverCollectionsButton.setImage(UIImage(named: "discover-collections"), for: .normal)
        discoverCollectionsButton.addTarget(self,
                                            action: #selector(discoverCollectionsButtonTapped),
                                            for: .touchUpInside)
        
        navigationBarContainerView.addSubview(discoverCollectionsButton)
        discoverCollectionsBtn = discoverCollectionsButton
        
        let count = self.viewModel?.collectionDetails.count ?? 0
        let pageControl = GainyPageControl.init(frame: CGRect.init(x: 24, y: 0, width: 200, height: 24), numberOfPages: count)
        pageControl.currentPage = self.currentCollectionID ?? 0
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hideForSinglePage = true
        navigationBarContainerView.addSubview(pageControl)
        pageControl.autoPinEdge(toSuperviewEdge: .left, withInset: 0.0)
        pageControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0.0)
        pageControl.autoSetDimension(.height, toSize: 24.0)
        self.pageControl = pageControl
        
        let favoriteButton = ResponsiveButton.newAutoLayout()
        favoriteButton.isSkeletonable = true
        favoriteButton.skeletonCornerRadius = 6
        let selectedImage = UIImage.init(named: "add_coll_from_wl")
        let normalImage = UIImage.init(named: "remove_coll_from_wl")
        favoriteButton.setImage(normalImage, for: .normal)
        favoriteButton.setImage(selectedImage, for: .selected)
        favoriteButton.isSelected = true
        favoriteButton.tintColor = UIColor.init(hexString: "#000000")
        navigationBarContainerView.addSubview(favoriteButton)
        favoriteButton.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
        favoriteButton.autoAlignAxis(ALAxis.horizontal, toSameAxisOf: pageControl)
        favoriteButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        self.favoriteButton = favoriteButton
        favoriteButton.showSkeleton()
        
        let compareButton = ResponsiveButton.newAutoLayout()
        compareButton.isSkeletonable = true
        compareButton.setImage(UIImage.init(named: "compare"), for: .normal)
        compareButton.setImage(UIImage.init(named: "compare"), for: .selected)
        navigationBarContainerView.addSubview(compareButton)
        compareButton.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
        compareButton.autoAlignAxis(ALAxis.horizontal, toSameAxisOf: pageControl)
        compareButton.autoPinEdge(.right, to: .left, of: favoriteButton, withOffset: -16.0)
        compareButton.addTarget(self, action: #selector(compareButtonTapped), for: .touchUpInside)
        compareButton.skeletonCornerRadius = 6
        self.compareButton = compareButton
        compareButton.showSkeleton()
        compareButton.isHidden = true
        compareButton.isUserInteractionEnabled = false
        
        let searchTextField = UITextField(
            frame: CGRect(
                x: 16,
                y: 24,
                width: navigationBarContainerView.bounds.width - (16 + 16 + 32 + 20),
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
        searchIconImageView.fillRemoteButtonBack()
        searchIconImageView.image = UIImage(named: "search")
        
        searchTextField.leftView = searchIconContainerView
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .whileEditing
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
        searchTextField.fillRemoteButtonBack()
        navigationBarContainerView.addSubview(searchTextField)
        self.searchTextField = searchTextField
        
        view.addSubview(navigationBarContainerView)
        navigationBarContainerView.setNeedsLayout()
        navigationBarContainerView.layoutIfNeeded()
        self.navigationBarContainer = navigationBarContainerView
        
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
        view.insertSubview(collectionView, at: 0)
        collectionView.autoPinEdge(.top, to: .top, of: view, withOffset: 0)
        collectionView.autoPinEdge(.leading, to: .leading, of: view)
        collectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)        
        collectionView.register(CollectionDetailsViewCell.self)
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dragInteractionEnabled = true
        collectionView.bounces = false
        collectionView.clipsToBounds = false
        collectionView.dataSource = dataSource
        collectionView.contentInsetAdjustmentBehavior = .never
        
        dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, CollectionDetailViewCellModel>(
            collectionView: collectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            var adjModel = modelItem
            if !Constants.CollectionDetails.loadingCellIDs.contains(modelItem.id) {
            if let oldModel = self?.viewModel?.collectionDetails[indexPath.row] {
                adjModel.setRange(oldModel.chartRange)
            }
            }
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: adjModel,
                position: indexPath.row
            )
            
            cell?.isSkeletonable = collectionView.isSkeletonable
            
            if collectionView.sk.isSkeletonActive {
                cell?.showAnimatedGradientSkeleton()
            } else {
                cell?.hideSkeleton()
            }
            
            if let cell = cell as? CollectionDetailsViewCell {
                cell.tag = modelItem.id
                cell.onScroll = {[weak self]  offset in
                    self?.updateNavigationBarAppearence(withOffset: offset)
                }
                
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
                    
                    self.currentCollectionViewCell = cell
                    self.sortingVS.collectionId = modelItem.id
                    self.currentCollectionToChange = modelItem.id
                    GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                    
                    self.present(self.fpc, animated: true, completion: nil)
                }
                cell.onSettingsPressed = {[weak self]  ticker in
                    guard let self = self else {return}
                    self.currentCollectionViewCell = cell
                    self.coordinator?.showMetricsViewController(ticker:ticker, collectionID: modelItem.id, delegate: self)
                }
                cell.onNewCardsLoaded = { [weak self] newCards in
                    if newCards.count == 0 {
                        return
                    }
                    
                    if var oldModel = self?.viewModel?.collectionDetails[indexPath.row] {
                        oldModel.addCards(newCards)
                        self?.viewModel?.collectionDetails[indexPath.row] = oldModel
                    }
                }
                cell.onRangeChange = { [weak self] range in
                    
                    if var oldModel = self?.viewModel?.collectionDetails[indexPath.row] {
                        oldModel.setRange(range)
                        self?.viewModel?.collectionDetails[indexPath.row] = oldModel
                    }
                }
                
                cell.onRefreshedCardsLoaded = { [weak self] newCards in
                    if newCards.count == 0 {
                        return
                    }                    
                    if var oldModel = self?.viewModel?.collectionDetails[indexPath.row] {
                        oldModel.cards = newCards
                        self?.viewModel?.collectionDetails[indexPath.row] = oldModel
                    }
                }
                cell.onPurhaseShow = { [weak self] in
                    self?.coordinator?.showPurchaseView()
                }
                
                cell.investButtonPressed = { [weak self] in
                    
                    let notifyViewController = NotifyViewController.instantiate(.popups)
                    let navigationController = UINavigationController.init(rootViewController: notifyViewController)
                    notifyViewController.delegate = self
                    navigationController.modalPresentationStyle = .fullScreen
                    notifyViewController.isFromTTF = true
                    notifyViewController.sourceId = "\(modelItem.id)"
                    GainyAnalytics.logEvent("invest_pressed_ttf", params: ["collectionID" : modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
                    self?.present(navigationController, animated: true, completion: nil)
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
        searchCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset - 32)
        searchCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        searchCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        searchCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        searchCollectionView.fillRemoteBack()
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
            self?.getRemoteData(loadProfile: false) {
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
        
        searchController?.loading = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.showNetworkLoader()
                } else {
                    self?.hideLoader()
                }
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
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateWatchlist).sink { _ in
        } receiveValue: { notification in
            let isEmpty = UserProfileManager.shared.favoriteCollections.isEmpty
            if isEmpty {
                // TODO: Proably show discovery collections
            }
        }.store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: NotificationManager.subscriptionChangedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] notif in
                self?.collectionView.reloadData()
            }
            .store(in: &self.cancellables)
        
        NotificationCenter.default.publisher(for: NotificationManager.discoveryTabPressedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                if let currentCollectionViewCell = self?.collectionView.visibleCells.first as? CollectionDetailsViewCell {
                    currentCollectionViewCell.collectionView.setContentOffset(.zero, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    override func userLoggedOut() {
        super.userLoggedOut()
        
        if var snapshot = self.dataSource?.snapshot() {
            snapshot.deleteAllItems()
            self.dataSource?.apply(snapshot)
        }
    }
    
    private func updateNavigationBarAppearence(withOffset offset:CGFloat, forceShow: Bool = false) {
        
        var needHide = false
        if !forceShow {
            if offset - self.lastOffset >= 100 {
                needHide = true
                self.lastOffset = offset
            } else if offset - self.lastOffset <= -100 {
                needHide = false
                self.lastOffset = offset
            } else  {
                return
            }
        }
        
        let count = self.viewModel?.collectionDetails.count ?? 0
        let isHidden = (self.favoriteButton?.isHidden ?? true) && (self.pageControl?.isHidden ?? true)
        
        var height: CGFloat = 110.0
        var hidden = false
        if !isHidden && needHide {
            height = 80.0
            hidden = true
        } else if isHidden && !needHide {
            height = 110.0
            hidden = false
        } else if !forceShow {
            return
        }
        
        let navBarFrame = CGRect(
            x: 0,
            y: self.navigationBarContainer.frame.origin.y,
            width: view.bounds.width,
            height: height
        )
        
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25) {
            self.pageControl?.alpha = (count <= 1 || hidden) ? 0.0 : 1.0
            self.favoriteButton?.alpha = hidden ? 0.0 : 1.0
            self.navigationBarContainer.frame = navBarFrame
            let navigationBarTopOffset =
            self.navigationBarContainer.frame.origin.y + self.navigationBarContainer.bounds.height
            self.blurViewHeightConstraint?.constant = navigationBarTopOffset + 8.0
            self.view.layoutIfNeeded()
        } completion: { success in
            self.pageControl?.isHidden = (count <= 1 || hidden)
            self.favoriteButton?.isHidden = hidden
        }
    }
    
    private func appendNewCollectionFromModel(_ model: CollectionDetailViewCellModel, _ completed: (() -> Void)? = nil) {
        runOnMain {
            let existingIDs = self.viewModel?.collectionDetails.compactMap({$0.id}) ?? []
            let needAdd = (model.id >= 0 && !existingIDs.contains(model.id))
            guard needAdd == true else {
                completed?()
                return
            }
            
            if Constants.CollectionDetails.top20ID == model.id {
                if let first = self.viewModel?.collectionDetails.first, first.id == Constants.CollectionDetails.watchlistCollectionID {
                    self.viewModel?.collectionDetails.insert(model, at: 1)
                } else {
                    self.viewModel?.collectionDetails.insert(model, at: 0)
                }
            } else {
                self.viewModel?.collectionDetails.append(model)
            }
            
            guard var snapshot = self.dataSource?.snapshot() else {
                completed?()
                return;
            }
            guard snapshot.indexOfSection(.collectionWithCards) != nil else {
                completed?()
                return;
            }
            
            if Constants.CollectionDetails.top20ID != model.id {
                if let last = snapshot.itemIdentifiers(inSection: .collectionWithCards).last {
                    snapshot.insertItems([model], afterItem: last)
                } else {
                    snapshot.appendItems([model],
                                         toSection: .collectionWithCards)
                }
            } else {
                if let first = snapshot.itemIdentifiers(inSection: .collectionWithCards).first {
                    if let firstDetails = self.viewModel?.collectionDetails.first, firstDetails.id == Constants.CollectionDetails.watchlistCollectionID {
                        snapshot.insertItems([model], afterItem: first)
                    } else {
                        snapshot.insertItems([model], beforeItem: first)
                    }
                } else {
                    snapshot.appendItems([model],
                                         toSection: .collectionWithCards)
                }
            }
            
            self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                completed?()
            })
        }
    }
    
    private func appendNewCollectionsFromModels(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        
        let mainDS = DispatchGroup()
        for item in models {
            mainDS.enter()
            appendNewCollectionFromModel(item) {
                mainDS.leave()
            }
        }
        
        mainDS.notify(queue: DispatchQueue.main) {
            completed?()
        }
    }
    
    private func appendWatchlistCollectionsFromModels(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
//        runOnMain {
//            let lock = NSLock()
//            lock.lock()
//            let watchlistCollections = models.filter { item in
//                item.id < 0
//            }
//            if let firstItem = watchlistCollections.first {
//                deleteCollections(watchlistCollections)
//                self.viewModel?.collectionDetails.insert(firstItem, at: 0)
//                if var snapshot = self.dataSource?.snapshot() {
//                    if snapshot.indexOfSection(.collectionWithCards) != nil {
//                        if let first = snapshot.itemIdentifiers(inSection: .collectionWithCards).first {
//                            snapshot.insertItems(watchlistCollections, beforeItem: first)
//                        } else {
//                            snapshot.appendItems(watchlistCollections,
//                                                 toSection: .collectionWithCards)
//                        }
//                        self.dataSource?.apply(snapshot, animatingDifferences: false, completion: {
//                            completed?()
//                        })
//                    } else {
//                        completed?()
//                    }
//                } else {
//                    completed?()
//                }
//            } else {
//                completed?()
//            }
//            lock.unlock()
//        }
    }
    
    private func addNewCollections(_ models: [CollectionDetailViewCellModel], _ completed: (() -> Void)? = nil) {
        runOnMain {
            self.appendNewCollectionsFromModels(models) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
                        if snapshot.itemIdentifiers(inSection: .collectionWithCards).count > 0 {
                            if modelIndex > 0 {
                                snapshot.insertItems([model],
                                                     afterItem: snapshot.itemIdentifiers(inSection: .collectionWithCards)[modelIndex - 1])
                            } else {
                                snapshot.insertItems([model],
                                                     beforeItem: snapshot.itemIdentifiers(inSection: .collectionWithCards)[0])
                            }
                        } else {
                            snapshot.appendItems([model], toSection: .collectionWithCards)
                        }
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
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        searchCollectionView.contentInset = .init(top: 0, left: 0, bottom: self.keyboardSize?.height ?? 0.0, right: 0)
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        searchCollectionView.contentInset = .zero
    }
    // MARK: Properties
    
    private lazy var sections: [SectionLayout] = [
        self.flowSectionLayout,
    ]
    
    private lazy var flowSectionLayout: HorizontalFlowSectionLayout = {
        var layout = HorizontalFlowSectionLayout()
        layout.visibleItemsInvalidationHandler = { (items, offset, environment) in
            
            if let currentIndex = items.last?.indexPath.row {
                if (self.viewModel?.collectionDetails.count ?? 0) <= 1 {
                    self.pageControl?.isHidden = true
                    self.currentCollectionID = currentIndex
                } else {
                    let count = self.viewModel?.collectionDetails.count ?? 0
                    self.pageControl?.isHidden = false
                    self.pageControl?.numberOfPages = count
                    self.pageControl?.currentPage = currentIndex
                    self.currentCollectionID = currentIndex
                }
                if let indexPath = items.last?.indexPath {
                    if let cell = self.collectionView.cellForItem(at: indexPath) as? CollectionDetailsViewCell {
                        self.lastOffset = cell.currentOffset
                        self.updateNavigationBarAppearence(withOffset: 0.0, forceShow: true)
                    }
                }
            }
        }
        return layout
    }()
    
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
    
    
    private var pageControl: GainyPageControl?
    private var currentCollectionID: Int? {
        didSet {
            if let currentCollectionID = currentCollectionID {
                if oldValue != currentCollectionID {
                    logTTFView()
                }
            }
        }
    }
    private var compareButton: UIButton?
    private var favoriteButton: UIButton?
    
    // MARK: Functions
    
    private func getRemoteData(loadProfile: Bool = false, completion: @escaping () -> Void) {
        guard haveNetwork else {
            NotificationManager.shared.showError("Sorry... No Internet connection right now.")
            GainyAnalytics.logEvent("no_internet")
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
                
                if let profileId = UserProfileManager.shared.profileID {
                    SubscriptionManager.shared.login(profileId: profileId)
                    SubscriptionManager.shared.getSubscription { _ in
                        
                    }
                }
                
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
        dprint("initialCollectionsLoading start", profileId: 30)
        CollectionsManager.shared.initialCollectionsLoading {[weak self] _ in
            
            guard !CollectionsManager.shared.collections.isEmpty else {
                self?.onDiscoverCollections?(false)
                return
            }
            
            dprint("initialCollectionsLoading ended", profileId: 30)
            DispatchQueue.main.async {
                self?.initViewModelsFromData()
                self?.hideLoader()
                completion()
            }
        }
    }
    
    private func hideSkeletons() {
        compareButton?.hideSkeleton()
        favoriteButton?.hideSkeleton()
        collectionView?.hideSkeleton()
        
        searchTextField?.isEnabled = true
        discoverCollectionsBtn?.isEnabled = true
        logTTFView()
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
    
    @objc
    private func compareButtonTapped() {
        // TODO: Not implemented yet
    }
    
    private func logTTFView() {
        guard let index = self.currentCollectionID else {
            return
        }
        
        guard viewModel?.collectionDetails.count ?? 0 > index, let model = viewModel?.collectionDetails[index] else {
            return
        }
        
        let collectionID = model.id
        
        SubscriptionManager.shared.getSubscription {[weak self] type in
            guard let self = self else {return}
            if type == .free {
                let isBlocked = !SubscriptionManager.shared.storage.isViewedCollection(collectionID) && SubscriptionManager.shared.storage.viewedCount == SubscriptionManager.shared.storage.collectionViewLimit
                GainyAnalytics.logEvent("ttf_view", params: ["collectionID" : collectionID, "isFromSearch" : false, "isBlocked" : isBlocked])
            } else {
                GainyAnalytics.logEvent("ttf_view", params: ["collectionID" : collectionID, "isFromSearch" : false, "isBlocked" : false ])
            }
        }
    }
    
    @objc
    private func favoriteButtonTapped() {
        
        guard let index = self.currentCollectionID else {
            return
        }
        
        guard viewModel?.collectionDetails.count ?? 0 > index, let model = viewModel?.collectionDetails[index] else {
            return
        }
        
        let collectionID = model.id
        UserProfileManager.shared.removeFavouriteCollection(collectionID) { success in
            self.deleteItem(model.id)
            GainyAnalytics.logEvent( "single_removed_from_yours", params: ["collectionID" : collectionID])
        }
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
        
        if !Constants.CollectionDetails.loadingCellIDs.contains(snap.itemIdentifiers.first?.id ?? -1) {
            hideSkeletons()
        }
    }
    
    func currentBackgroundImageFrame() -> CGRect {
        
//        let initialItemToShow = viewModel?.initialCollectionIndex ?? 0
//        if let cell: CollectionDetailsViewCell = collectionView.cellForItem(at: IndexPath(item: initialItemToShow, section: 0)) as? CollectionDetailsViewCell {
//            let horizontalView = cell.collectionHorizontalView
//            return self.view.convert(horizontalView.frame, from: horizontalView)
//        } else {
            return CGRect.zero
//        }
    }
    
    private func initViewModelsFromData() {
        var array = CollectionsManager.shared.collections
        
        if let watchlist = CollectionsManager.shared.watchlistCollection {
            array.insert(watchlist, at: 0)
        }
        viewModel?.collectionDetails = CollectionsManager.shared.convertToModel(array)
        let count = self.viewModel?.collectionDetails.count ?? 0
        self.pageControl?.numberOfPages = count
        dprint("initViewModelsFromData ended \(viewModel?.collectionDetails.count ?? 0)", profileId: 30)
    }
    
    private func initViewModels() {
        if var snapshot = dataSource?.snapshot() {
            if snapshot.sectionIdentifiers.count > 0 {
                snapshot.deleteSections([.collectionWithCards])
            }
            snapshot.appendSections([.collectionWithCards])
            snapshot.appendItems((viewModel?.collectionDetails ?? []),
                                 toSection: .collectionWithCards)
            dprint("initViewModels appendItems ended", profileId: 30)
            dataSource?.apply(snapshot, animatingDifferences: false, completion: {
                
            })
            collectionView.reloadData()
        }
        searchTextField?.isEnabled = true
        discoverCollectionsBtn?.isEnabled = true
    }
    
    private func addLoaders() {
        collectionView.showAnimatedGradientSkeleton()
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
                .full: FloatingPanelLayoutAnchor(absoluteInset: 400.0, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 400.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 400.0, edge: .bottom, referenceGuide: .safeArea),
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
        
        let navBarFrame = CGRect(
            x: 0,
            y: self.navigationBarContainer.frame.origin.y,
            width: view.bounds.width,
            height: self.navigationBarContainer.frame.size.height
        )
        self.navigationBarContainer.frame = navBarFrame
        let navigationBarTopOffset =
        self.navigationBarContainer.frame.origin.y + self.navigationBarContainer.bounds.height
        self.blurViewHeightConstraint?.constant = navigationBarTopOffset + 8.0
        
        
        if self.skipReload {
            self.skipReload = false
            return
        }
        
        dprint("viewWillAppear load", profileId: 30)
        if self.needTop20Reload {
            TickerLiveStorage.shared.clearMatchData()
            showNetworkLoader()
            
            let asyncGroup = DispatchGroup()
//            asyncGroup.enter()
//            UserProfileManager.shared.getProfileCollections(loadProfile: false, forceReload: true) { _ in
//                dprint("getProfileCollections ended", profileId: 30)
//                asyncGroup.leave()
//            }
//            asyncGroup.enter()
//            CollectionsManager.shared.reloadTop20 {
//                dprint("reloadTop20 ended", profileId: 30)
//                asyncGroup.leave()
//            }
            asyncGroup.notify(queue: .main) { [weak self] in
                CollectionsManager.shared.collections.removeAll()
                dprint("reloadCollectionIfNeeded enter", profileId: 30)
                self?.reloadCollectionIfNeeded()
            }
        } else {
            reloadCollectionIfNeeded()
            dprint("reloadCollectionIfNeeded enter", profileId: 30)
        }
    }
    
    private func reloadCollectionIfNeeded() {
        if Auth.auth().currentUser != nil {
            self.reloadCollection()
        }
    }
    
    private func reloadCollection() {
        guard let profileID = UserProfileManager.shared.profileID else { return }
        let isEmpty = UserProfileManager.shared.favoriteCollections.isEmpty
        guard !isEmpty else {
            self.onDiscoverCollections?(false)
            return
        }
        dprint("getRemoteData started", profileId: 30)
        getRemoteData(loadProfile: false) {
            dprint("getRemoteData ended", profileId: 30)
            DispatchQueue.main.async { [weak self] in
                self?.initViewModels()
                self?.centerInitialCollectionInTheCollectionView()
                self?.hideLoader()
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
                if self.viewModel?.collectionDetails.count ?? 0 <= 1 {
                    self.pageControl?.isHidden = true
                }
                if CollectionsManager.shared.collections.isEmpty {
                    self.onDiscoverCollections?(false)
                } else {
                    self.centerInitialCollectionInTheCollectionView()
                }
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
        self.fpc.dismiss(animated: true) {
            self.currentCollectionViewCell?.refreshData()
        }
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
    
    func didDismissMetricsViewController(needRefresh: Bool) {
        if needRefresh {
            self.currentCollectionViewCell?.refreshData()
        } else {
            self.collectionView.reloadData()
        }
    }
}

extension CollectionDetailsViewController: NotifyViewControllerDelegate {
    func notifyViewControllerWillClosePopup() {
        self.skipReload = true
    }
}
