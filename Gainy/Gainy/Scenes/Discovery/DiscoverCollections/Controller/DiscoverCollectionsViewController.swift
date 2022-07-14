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
    case topGainers
    case topLosers
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
    
    private var refreshControl = LottieRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBarContainer = UIView(
            frame: CGRect(
                x: 0,
                y: view.safeAreaInsets.top + 36,
                width: view.bounds.width,
                height: 80
            )
        )
        navigationBarContainer.backgroundColor = .clear
        let navigationBarTopOffset =
        navigationBarContainer.frame.origin.y + navigationBarContainer.bounds.height
        
        let blurView = BlurEffectView()
        view.addSubview(blurView)
        
        blurView.autoPinEdge(toSuperviewEdge: .leading)
        blurView.autoPinEdge(toSuperviewEdge: .top)
        blurView.autoPinEdge(toSuperviewEdge: .trailing)
        blurView.autoSetDimension(.height, toSize: navigationBarTopOffset + 8.0)
        blurView.intensity = 0.3
        
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
        searchIconImageView.backgroundColor = .clear
        searchIconImageView.image = UIImage(named: "search")
        
        searchTextField.leftView = searchIconContainerView
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .whileEditing
        searchTextField.fillRemoteButtonBack()
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
        
        
        
        discoverCollectionsCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: customLayout
        )
        view.addSubview(discoverCollectionsCollectionView)
        discoverCollectionsCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        discoverCollectionsCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        discoverCollectionsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        discoverCollectionsCollectionView.autoPinEdge(.bottom, to: .bottom, of: view)
        
        //discoverCollectionsCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        discoverCollectionsCollectionView.addSubview(refreshControl)
        
        discoverCollectionsCollectionView.registerSectionHeader(NoCollectionsHeaderView.self)
        discoverCollectionsCollectionView.registerSectionHeader(YourCollectionsHeaderView.self)
        discoverCollectionsCollectionView.registerSectionHeader(RecommendedCollectionsHeaderView.self)
        discoverCollectionsCollectionView.registerSectionHeader(GainersHeaderView.self)
        
        discoverCollectionsCollectionView.register(YourCollectionTipCell.self)
        discoverCollectionsCollectionView.register(YourCollectionViewCell.self)
        discoverCollectionsCollectionView.register(RecommendedCollectionViewCell.self)
        discoverCollectionsCollectionView.register(UINib.init(nibName: HomeTickersCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: HomeTickersCollectionViewCell.cellIdentifier)
        
        
        discoverCollectionsCollectionView.fillRemoteBack()
        discoverCollectionsCollectionView.showsVerticalScrollIndicator = false
        discoverCollectionsCollectionView.dragInteractionEnabled = true
        
        discoverCollectionsCollectionView.delegate = self
        
        discoverCollectionsCollectionView.dragDelegate = self
        discoverCollectionsCollectionView.dropDelegate = self
        discoverCollectionsCollectionView.contentInset = .init(top: 0, left: 0, bottom: 45.0, right: 0)
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
                    NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure you want to delete this TTF?", cancelTitle: "No", actions: [yesAction])
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
                        matchScore: modelItem.matchScore,
                        dailyGrow: modelItem.dailyGrow,
                        recommendedIdentifier: modelItem
                    )
                    self?.removeFromYourCollection(itemId: modelItem.id, yourCollectionItemToRemove: yourCollectionItem)
                    
                    cell.isUserInteractionEnabled = true
                    GainyAnalytics.logEvent("remove_from_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
                }
            case let (cell as HomeTickersCollectionViewCell, modelItem as HomeTickersCollectionViewCellModel):
                cell.delegate = self
                break
            default:
                break
            }
            
            return cell
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                var headerViewModel = indexPath.section == DiscoverCollectionsSection.watchlist.rawValue
                ? CollectionHeaderViewModel(
                    title: Constants.CollectionDetails.yourCollections,
                    description: "Tap to view, swipe to edit or drag & drop to reorder.\nAdd TTFs you might like from below to browse them."
                )
                : CollectionHeaderViewModel(
                    title: "TTFs you might like",
                    description: "All collections are sorted by relevancy based on your profile and goals "
                )
                
                if UserProfileManager.shared.yourCollections.isEmpty && indexPath.section == DiscoverCollectionsSection.watchlist.rawValue {
                    headerViewModel = CollectionHeaderViewModel(
                        title: Constants.CollectionDetails.yourCollections,
                        description: "Add at least one TTF from the list below,\njust click on the plus icon"
                    )
                    headerViewModel.showOutline = true
                }
                
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
        discoverCollectionsCollectionView.clipsToBounds = false
        
        searchCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: blurView.frame.origin.y + blurView.frame.height,
                width: view.bounds.width,
                height: view.bounds.height - navigationBarTopOffset
            ),
            collectionViewLayout: CollectionSearchController.createLayout([.loader])
        )
        view.addSubview(searchCollectionView)
        searchCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset + 8)
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
        NotificationCenter.default.publisher(for: NotificationManager.appBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                self?.refreshAction()
            }.store(in: &cancellables)
        view.bringSubviewToFront(blurView)
        view.bringSubviewToFront(navigationBarContainer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshAction()
    }
    
    @objc func refreshAction() {
        showNetworkLoader()
        getRemoteData(loadProfile: true ) {
            DispatchQueue.main.async { [weak self] in
                self?.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
                self?.tabBarController?.tabBar.isHidden = self?.showCollectionDetailsBtn?.isHidden ?? false
                if let frame = UserProfileManager.shared.yourCollections.isEmpty ? self?.fullSerachFieldFrame : self?.smallSerachFieldFrame {
                    UIView.animate(withDuration: 0.3) {
                        self?.searchTextField?.frame = frame
                    }
                }
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
        
        let frame = UserProfileManager.shared.yourCollections.isEmpty ? self.fullSerachFieldFrame : self.smallSerachFieldFrame
        UIView.animate(withDuration: 0.3) {
            self.discoverCollectionsCollectionView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.showCollectionDetailsBtn?.alpha = 1.0
            self.searchTextField?.frame = frame
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
            self.searchTextField?.frame = self.fullSerachFieldFrame
        }
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_ended", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
    }
    
    
    // MARK: Private
    
    // MARK: Properties
    
    private lazy var sections: [SectionLayout] =  {
        return self.sectionsNew
    }()
    
    private var sectionsNew: [SectionLayout] {
        let headerHeight: CGFloat = UserProfileManager.shared.yourCollections.isEmpty ? 104.0 : 74.0
        self.noCollectionSectionLayout.headerHeight = headerHeight
        return [self.noCollectionSectionLayout,
         YourCollectionsSectionLayout(),
         RecommendedCollectionsSectionLayout()]
    }
    
    private var customLayout: UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            if sectionIndex >= self?.sections.count ?? 0  {
                return NoCollectionsSectionLayout().layoutSection(within: env)
            }
            if (sectionIndex == 0) {
                let headerHeight: CGFloat = UserProfileManager.shared.yourCollections.isEmpty ? 104.0 : 74.0
                self?.noCollectionSectionLayout.headerHeight = headerHeight
                return self?.noCollectionSectionLayout.layoutSection(within: env)
            }
            return self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }
    
    private var smallSerachFieldFrame: CGRect = {
        let frame = CGRect(
            x: 16,
            y: 24,
            width: UIScreen.main.bounds.width - (16 + 16 + 32 + 20),
            height: 40
        )
        return frame
    }()
    
    private var fullSerachFieldFrame: CGRect = {
        let frame = CGRect(
            x: 16,
            y: 24,
            width: UIScreen.main.bounds.width  - (16 + 16),
            height: 40
        )
        return frame
    }()
    
    private var noCollectionSectionLayout = NoCollectionsSectionLayout()
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
            matchScore: collectionItemToAdd.matchScore,
            dailyGrow: collectionItemToAdd.dailyGrow,
            isInYourCollections: true
        )
        
        let yourCollectionItem = YourCollectionViewCellModel(
            id: collectionItemToAdd.id,
            image: collectionItemToAdd.image,
            imageUrl: collectionItemToAdd.imageUrl,
            name: collectionItemToAdd.name,
            description: collectionItemToAdd.description,
            stocksAmount: collectionItemToAdd.stocksAmount,
            matchScore: collectionItemToAdd.matchScore,
            dailyGrow: collectionItemToAdd.dailyGrow,
            recommendedIdentifier: updatedRecommendedItem
        )
        
        //Prefetching
        showNetworkLoader()
        
        DispatchQueue.global(qos:.utility).async {
            CollectionsManager.shared.loadNewCollectionDetails(collectionItemToAdd.id) { remoteTickers in
                runOnMain {
                    self.hideLoader()
                    
                }
            }
        }
        
        UserProfileManager.shared.addFavouriteCollection(yourCollectionItem.id) { success in
            
            guard success == true else {
                return
            }
            
            if yourCollectionItem.id == Constants.CollectionDetails.top20ID {
                self.viewModel?.yourCollections.insert(yourCollectionItem, at: 0)
            } else {
                self.viewModel?.yourCollections.append(yourCollectionItem)
            }
            
            Task {
                await self.reloadGainers()
            }
            
            if let index = UserProfileManager.shared.recommendedCollections.firstIndex { item in
                item.id == yourCollectionItem.id
            } {
                UserProfileManager.shared.recommendedCollections[index].isInYourCollections = true
            }
            
            let collection =  Collection(id: yourCollectionItem.id,
                                         image: yourCollectionItem.image,
                                         imageUrl: yourCollectionItem.imageUrl,
                                         name: yourCollectionItem.name,
                                         description: yourCollectionItem.description,
                                         stocksAmount: yourCollectionItem.stocksAmount,
                                         matchScore: yourCollectionItem.matchScore,
                                         dailyGrow: yourCollectionItem.dailyGrow,
                                         isInYourCollections: true)
            
            if yourCollectionItem.id == Constants.CollectionDetails.top20ID {
                UserProfileManager.shared.yourCollections.insert(collection, at: 0)
            } else {
                UserProfileManager.shared.yourCollections.append(collection)
            }
            
            self.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
            self.tabBarController?.tabBar.isHidden = self.showCollectionDetailsBtn?.isHidden ?? false
            let frame = UserProfileManager.shared.yourCollections.isEmpty ? self.fullSerachFieldFrame : self.smallSerachFieldFrame
            UIView.animate(withDuration: 0.3) {
                self.searchTextField?.frame = frame
            }
            
            self.discoverCollectionsCollectionView.collectionViewLayout = self.customLayout
            if var snapshot = self.dataSource?.snapshot() {
                if yourCollectionItem.id == Constants.CollectionDetails.top20ID {
                    if let first = snapshot.itemIdentifiers(inSection: .yourCollections).first {
                        snapshot.insertItems([yourCollectionItem], beforeItem: first)
                    } else {
                        snapshot.appendItems([yourCollectionItem], toSection: .yourCollections)
                    }
                } else {
                    snapshot.appendItems([yourCollectionItem], toSection: .yourCollections)
                }
                snapshot.deleteItems([collectionItemToAdd])
                self.viewModel?.addedRecs[collectionItemToAdd.id] = collectionItemToAdd
                self.viewModel?.recommendedCollections.removeAll(where: { item in
                    item.id == yourCollectionItem.id
                })
                self.updateHeaderHeight()
                self.dataSource?.apply(snapshot, animatingDifferences: true, completion: {
                    self.addNextButtonAsNeeded()
                })
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
                return
            }
        }
        
        viewModel?.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        UserProfileManager.shared.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        Task {
            await self.reloadGainers()
        }
        
        showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
        self.tabBarController?.tabBar.isHidden = showCollectionDetailsBtn?.isHidden ?? false
        let frame = UserProfileManager.shared.yourCollections.isEmpty ? self.fullSerachFieldFrame : self.smallSerachFieldFrame
        UIView.animate(withDuration: 0.3) {
            self.searchTextField?.frame = frame
        }
        
        guard var snapshot = dataSource?.snapshot() else {return}
        if let recommendedItem = yourCollectionItemToRemove.recommendedIdentifier {
            
            
            let reloadItem = RecommendedCollectionViewCellModel(
                id: recommendedItem.id,
                image: recommendedItem.image,
                imageUrl: recommendedItem.imageUrl,
                name: recommendedItem.name,
                description: recommendedItem.description,
                stocksAmount: recommendedItem.stocksAmount,
                matchScore: recommendedItem.matchScore,
                dailyGrow: recommendedItem.dailyGrow,
                isInYourCollections: true
            )
            
            let updatedRecommendedItem = RecommendedCollectionViewCellModel(
                id: recommendedItem.id,
                image: recommendedItem.image,
                imageUrl: recommendedItem.imageUrl,
                name: recommendedItem.name,
                description: recommendedItem.description,
                stocksAmount: recommendedItem.stocksAmount,
                matchScore: recommendedItem.matchScore,
                dailyGrow: recommendedItem.dailyGrow,
                isInYourCollections: false
            )
            
            if let index = UserProfileManager.shared.recommendedCollections.firstIndex { item in
                item.id == recommendedItem.id
            } {
                UserProfileManager.shared.recommendedCollections[index].isInYourCollections = false
            }
            viewModel?.recommendedCollections.append(updatedRecommendedItem)
            
            snapshot.deleteItems([yourCollectionItemToRemove])
            snapshot.appendItems([updatedRecommendedItem], toSection: .recommendedCollections)
            
            self.updateHeaderHeight()
            dataSource?.apply(snapshot, animatingDifferences: true, completion: {
                self.onItemDelete?(DiscoverCollectionsSection.yourCollections ,itemId)
            })
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
                    matchScore: yourCollectionItemToRemove.matchScore,
                    dailyGrow: yourCollectionItemToRemove.dailyGrow,
                    isInYourCollections: true
                )
                
                let updatedRecommendedItem = RecommendedCollectionViewCellModel(
                    id: yourCollectionItemToRemove.id,
                    image: yourCollectionItemToRemove.image,
                    imageUrl: yourCollectionItemToRemove.imageUrl,
                    name: yourCollectionItemToRemove.name,
                    description: yourCollectionItemToRemove.description,
                    stocksAmount: yourCollectionItemToRemove.stocksAmount,
                    matchScore: yourCollectionItemToRemove.matchScore,
                    dailyGrow: yourCollectionItemToRemove.dailyGrow,
                    isInYourCollections: false
                )
                
                if let indexOfRecommendedItemToUpdate = UserProfileManager.shared.recommendedCollections
                    .firstIndex(where: { $0.id == yourCollectionItemToRemove.id }) {
                    UserProfileManager.shared.recommendedCollections[indexOfRecommendedItemToUpdate].isInYourCollections = false
                    
                    if let itemToReload  = snapshot.itemIdentifiers(inSection: .recommendedCollections).first(where: {
                        if let item = $0 as? RecommendedCollectionViewCellModel {
                            return item.id == itemId
                        }
                        return false
                    }) as? RecommendedCollectionViewCellModel {
                        snapshot.reloadItems([itemToReload])
                    }
                }
                
                viewModel?.recommendedCollections.append(updatedRecommendedItem)
                
                snapshot.deleteItems([deleteItems])
                snapshot.appendItems([updatedRecommendedItem], toSection: .recommendedCollections)
                
                self.updateHeaderHeight()
                dataSource?.apply(snapshot, animatingDifferences: true, completion: {
                    self.onItemDelete?(DiscoverCollectionsSection.yourCollections, itemId)
                })
            }
            
        }
        
    }
    
    private func updateHeaderHeight() {
        let headerHeight: CGFloat = UserProfileManager.shared.yourCollections.isEmpty ? 104.0 : 74.0
        self.noCollectionSectionLayout.headerHeight = headerHeight
        self.discoverCollectionsCollectionView.collectionViewLayout = self.customLayout
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
        
        self.updateHeaderHeight()
        dataSource?.apply(snapshot, animatingDifferences: true, completion: {
        })
        dropCoordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }
    
    private func initViewModels() {
        
        guard let dataSource = dataSource else {return}
        sections = self.sectionsNew
        if let top1 = viewModel?.topGainers, !top1.isEmpty {
            sections.insert(GainersCollectionSectionLayout(isGainers: true), at: sections.count - 1)
        }
        if let top2 = viewModel?.topLosers, !top2.isEmpty {
            sections.insert(GainersCollectionSectionLayout(isGainers: false), at: sections.count - 1)
        }
        
        var snap = dataSource.snapshot()
        if snap.sectionIdentifiers.count > 0 {
            snap.deleteSections([.watchlist, .yourCollections, .topGainers, .topLosers, .recommendedCollections])
        }
        snap.appendSections(sections.count > 3 ? [.watchlist, .yourCollections, .topGainers, .topLosers, .recommendedCollections] : [.watchlist, .yourCollections, .recommendedCollections])
        snap.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
        
        if let top1 = viewModel?.topGainers, !top1.isEmpty {
            snap.appendItems(top1, toSection: .topGainers)
        }
        if let top2 = viewModel?.topLosers, !top2.isEmpty {
            snap.appendItems(top2, toSection: .topLosers)
        }
        
        snap.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)
        self.updateHeaderHeight()
        dataSource.apply(snap, animatingDifferences: true)
        discoverCollectionsCollectionView.reloadData()
        if showNextButton {
            //addBottomButton()
        }
        hideLoader()
    }
    
    internal func reloadGainers() async {
        guard let profileID = UserProfileManager.shared.profileID else {return}
        guard let dataSource = dataSource else {return}
        
        let topTickers = await CollectionsManager.shared.getGainers(profileId: profileID)
        
        CollectionsManager.shared.topTickers = topTickers
        let topTickers1: HomeTickersCollectionViewCellModel = HomeTickersCollectionViewCellModel.init(gainers: topTickers.topGainers, isGainers: true)
        let topTickers2: HomeTickersCollectionViewCellModel = HomeTickersCollectionViewCellModel.init(gainers: topTickers.topLosers, isGainers: false)
        viewModel?.topGainers.removeAll()
        viewModel?.topLosers.removeAll()
        if (viewModel?.yourCollections ?? []).isEmpty {
            viewModel?.topGainers = []
            viewModel?.topLosers = []
            CollectionsManager.shared.topTickers = nil
        } else {
            viewModel?.topGainers = [topTickers1]
            viewModel?.topLosers = [topTickers2]
        }
        await MainActor.run {
            var snap = dataSource.snapshot()
            
            //Update Your Collections
            
            if snap.itemIdentifiers(inSection: .yourCollections).isEmpty && !(viewModel?.yourCollections.isEmpty ?? true) {
                snap.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
            }
            
            if let top1 = viewModel?.topGainers, !top1.isEmpty,let top2 = viewModel?.topLosers, !top2.isEmpty  {
                if !snap.sectionIdentifiers.contains(.topGainers) {
                    sections.insert(GainersCollectionSectionLayout(isGainers: true), at: sections.count - 1)
                    sections.insert(GainersCollectionSectionLayout(isGainers: false), at: sections.count - 1)
                    snap.deleteSections([.recommendedCollections])
                    snap.appendSections([.topGainers, .topLosers, .recommendedCollections])
                    
                    snap.appendItems(top1, toSection: .topGainers)
                    snap.appendItems(top2, toSection: .topLosers)
                    snap.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)
                    self.updateHeaderHeight()
                    dataSource.apply(snap, animatingDifferences: true)
                } else {
                    snap.deleteSections([.topGainers, .topLosers])
                }
            }
        }
    }
    
    private func goToCollectionDetails(at collectionPosition: Int) {
        
        onGoToCollectionDetails?(collectionPosition)
    }
    
    private func addNextButtonAsNeeded() {
        guard let profileID = UserProfileManager.shared.profileID else {return}
        guard let yourCollections = viewModel?.yourCollections else {return}
        guard let watchlistCollections = viewModel?.watchlistCollections else {return}
        let empty = yourCollections.isEmpty && watchlistCollections.isEmpty
        if (!empty) {
            let discoverShownForProfileKey = String(profileID) + "DiscoverCollectionsShownKey"
            let shown = UserDefaults.standard.bool(forKey: discoverShownForProfileKey)
            if !shown {
                UserDefaults.standard.set(true, forKey: discoverShownForProfileKey)
                self.showNextButton = true
                //addBottomButton()
                return
            }
        }
    }
    
    private func initViewModelsFromData() {
        viewModel?.yourCollections = UserProfileManager.shared
            .yourCollections
            .map { CollectionViewModelMapper.map($0) }
        
        
        viewModel?.watchlistCollections.removeAll()
        //Gainers
        if let topTickers = CollectionsManager.shared.topTickers {
            let topTickers1: HomeTickersCollectionViewCellModel = HomeTickersCollectionViewCellModel.init(gainers: topTickers.topGainers, isGainers: true)
            let topTickers2: HomeTickersCollectionViewCellModel = HomeTickersCollectionViewCellModel.init(gainers: topTickers.topLosers, isGainers: false)
            viewModel?.topGainers.removeAll()
            viewModel?.topLosers.removeAll()
            if viewModel?.yourCollections.isEmpty ?? false {
                viewModel?.topGainers = []
                viewModel?.topLosers = []
                
            } else {
                viewModel?.topGainers = [topTickers1]
                viewModel?.topLosers = [topTickers2]
            }
        } else {
            viewModel?.topGainers.removeAll()
            viewModel?.topLosers.removeAll()
        }
        
        
        self.addNextButtonAsNeeded()
        
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
            NotificationManager.shared.showError("Sorry... No Internet connection right now.") { [weak self] in
                self?.getRemoteData(loadProfile: loadProfile, completion: completion)
            }
            GainyAnalytics.logEvent("no_internet")
            refreshControl.endRefreshing()
            return
        }
        
        UserProfileManager.shared.getProfileCollections(loadProfile: loadProfile) { success in
            self.refreshControl.endRefreshing()
            guard success == true  else {
                self.initViewModels()
                completion()
                return
            }
            runOnMain {
                self.initViewModelsFromData()
                completion()
            }
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
            
            if indexPath.row < UserProfileManager.shared.yourCollections.count {
                GainyAnalytics.logEvent("your_collection_pressed", params: ["collectionID": UserProfileManager.shared.yourCollections[indexPath.row].id, "type" : "yours", "ec" : "DiscoverCollections"])
            }
            let index = indexPath.row
            let increment = (viewModel?.watchlistCollections.count ?? 0) > 0 ? 1 : 0
            self.goToCollectionDetails(at: index + increment)
        } else {
            if let recColl = viewModel?.recommendedCollections[indexPath.row] {
                coordinator?.showCollectionDetails(collectionID: recColl.id, delegate: self)
            }
            GainyAnalytics.logEvent("recommended_collection_pressed", params: ["collectionID": UserProfileManager.shared.recommendedCollections[indexPath.row].id, "type" : "recommended", "ec" : "DiscoverCollections"])
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
            
            if CollectionsManager.shared.collections.contains(where: { item in
                (item.id ?? 0) == Constants.CollectionDetails.top20ID
            }), indexPath.row == 0 {
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
            cornerRadius: 18
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
        
        if CollectionsManager.shared.collections.contains(where: { item in
            (item.id ?? 0) == Constants.CollectionDetails.top20ID
        }), destination.row == 0 {
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

extension DiscoverCollectionsViewController: HomeTickersCollectionViewCellDelegate {
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        
    }
    
    func stockPressed(stock: AltStockTicker, index: Int, cell: HomeTickersCollectionViewCell) {
        let gainerIndex = viewModel?.topGainers.first?.gainers.firstIndex(where: {
            $0.symbol == stock.symbol
        }) ?? -1
        
        let loserIndex = viewModel?.topLosers.first?.gainers.firstIndex(where: {
            $0.symbol == stock.symbol
        }) ?? -1
        
        if gainerIndex != -1 {
            coordinator?.showCardsDetailsViewController(viewModel?.topGainers.first?.gainers.compactMap({TickerInfo(ticker: $0)}) ?? [], index: gainerIndex)
        } else {
            if loserIndex != -1 {
                coordinator?.showCardsDetailsViewController(viewModel?.topLosers.first?.gainers.compactMap({TickerInfo(ticker: $0)}) ?? [], index: loserIndex)
            }
        }
    }
}
