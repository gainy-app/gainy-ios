import Foundation
import GainyCommon
import FloatingPanel
import SnapKit

final class DiscoveryViewController: BaseViewController {
    
    weak var authorizationManager: AuthorizationManager?
    var viewModel: DiscoveryViewModelProtocol?
    weak var coordinator: MainCoordinator?
    
    var onGoToCollectionDetails: ((Int) -> Void)?
    var onRemoveCollectionFromYourCollections: (() -> Void)?
    
    enum ViewMode {
        case grid, shelf
    }
    
    private var viewMode: ViewMode = .shelf {
        didSet {
            filterHeaderView.viewMode = viewMode
            
            UIView.animate(withDuration: 0.3) {
                self.filterHeaderView.snp.updateConstraints { make in
                    make.height.equalTo(self.viewMode == .grid ? 84.0 : 64.0)
                }
                self.recCollectionView.snp.updateConstraints { make in
                    make.trailing.equalToSuperview().offset(self.viewMode == .grid ? -16.0 : 0.0)                    
                    make.leading.equalToSuperview().offset(self.viewMode == .grid ? 16.0 : 0.0)
                    make.top.equalTo(self.filterHeaderView.snp.bottom).offset(self.viewMode == .grid ? 24.0 : 8.0)
                }
                self.view.layoutIfNeeded()
            }
            setSources()
            refreshAction()
        }
    }
    
    private func setSources() {
        if viewMode == .grid {
            recCollectionView.dataSource = viewModel?.gridDataSource
            recCollectionView.delegate = viewModel?.gridDataSource
            viewModel?.gridDataSource.delegate = self
            viewModel?.shelfDataSource.delegate = nil
        } else {
            recCollectionView.dataSource = viewModel?.shelfDataSource
            recCollectionView.delegate = viewModel?.shelfDataSource
            viewModel?.gridDataSource.delegate = nil
            viewModel?.shelfDataSource.delegate = self
        }
    }
    
    lazy var filterHeaderView: RecommendedCollectionsHeaderView = {
        let header = RecommendedCollectionsHeaderView()
        header.alpha = 0.0
        return header
    }()
    
    
    private var noFavHeight: ConstraintMakerEditable?
    private var noFavBottom: ConstraintMakerEditable?
    
    var isNoFavTTFs: Bool = false {
        didSet {
            addToCollectionHintView.isHidden = !isNoFavTTFs
            UIView.animate(withDuration: 0.3) {
                self.addToCollectionHintView.snp.updateConstraints { make in
                    make.height.equalTo(144.0)
                }
                self.filterHeaderView.snp.updateConstraints { make in
                    if self.isNoFavTTFs {
                        make.top.equalTo(self.addToCollectionHintView.snp.bottom)
                    } else {
                        make.top.equalTo(self.addToCollectionHintView.snp.bottom).offset(-16)
                    }
                }
            }
            
            noFavHeight?.constraint.update(offset: isNoFavTTFs ? 144.0 : 0.0)
            noFavBottom?.constraint.update(offset: isNoFavTTFs ? 16.0 : 0.0)
            view.layoutIfNeeded()
        }
    }
    
    //Panel
    private var fpc: FloatingPanelController!
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    private lazy var sortingVS = SortDiscoveryViewController.instantiate(.popups)
    
    private var currentPage: Int = 1
    private var itemsPerPage: Int = 6
    private var recommendedCollections: [RecommendedCollectionViewCellModel] {
        get {
            guard let itemsAll = viewModel?.recommendedCollections else {
                return []
            }
            
            let result = self.sortRecommendedCollections(recColls: itemsAll)
            return result
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isFromOnboard = UserProfileManager.shared.isFromOnboard
        refreshAction()
    }
    
    @objc func refreshAction() {
        refreshControl.endRefreshing()
        if viewMode == .grid {
            showNetworkLoader()
            getRemoteData(loadProfile: true ) {
                DispatchQueue.main.async { [weak self] in
                    self?.filterHeaderView.alpha = 1.0
                    self?.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
                    self?.tabBarController?.tabBar.isHidden = self?.showCollectionDetailsBtn?.isHidden ?? false
                    self?.isNoFavTTFs = UserProfileManager.shared.yourCollections.isEmpty
                    self?.initViewModels()
                    self?.hideLoader()
                }
            }
        } else {
            showNetworkLoader()
            
            if UserProfileManager.shared.yourCollections.isEmpty {
                getRemoteData(loadProfile: true ) {
                    DispatchQueue.main.async { [weak self] in
                        self?.filterHeaderView.alpha = 1.0
                        self?.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
                        self?.tabBarController?.tabBar.isHidden = self?.showCollectionDetailsBtn?.isHidden ?? false
                        self?.isNoFavTTFs = UserProfileManager.shared.yourCollections.isEmpty
                        self?.initViewModels()
                        Task {
                            let shelfCollections = await CollectionsManager.shared.getShelfCollections()
                            self?.viewModel?.shelfs = shelfCollections
                            self?.viewModel?.shelfDataSource.updateCollections(self?.viewModel?.recommendedCollections ?? [], shelfCols: shelfCollections)
                            self?.initViewModels()
                            self?.hideLoader()
                        }
                    }
                }
                
            } else {
                self.initViewModelsFromData()
                Task {
                    let shelfCollections = await CollectionsManager.shared.getShelfCollections()
                    self.viewModel?.shelfs = shelfCollections
                    self.viewModel?.shelfDataSource.updateCollections(self.viewModel?.recommendedCollections ?? [], shelfCols: shelfCollections)
                    initViewModels()
                    self.filterHeaderView.alpha = 1.0
                    self.hideLoader()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = RemoteConfigManager.shared.mainBackColor
        
        let navigationBarContainer = UIView(
            frame: CGRect(
                x: 0,
                y: view.safeAreaInsets.top + 36,
                width: view.bounds.width,
                height: 130.0 + 16
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
        blurView.autoSetDimension(.height, toSize: navigationBarTopOffset)
        blurView.intensity = 0.3
        blurView.alpha = 0.0
        
        let titleLbl = UILabel(frame: CGRect.init(x: 24, y: 28, width: 110, height: 32))
        titleLbl.text = "Discovery"
        titleLbl.textColor = UIColor.Gainy.mainText
        titleLbl.font = .proDisplayBold(24)
        titleLbl.textAlignment = .left
        navigationBarContainer.addSubview(titleLbl)
        
        let discoverCollectionsButton = UIButton(
            frame: CGRect(
                x: navigationBarContainer.bounds.width - (32 + 20),
                y: 28,
                width: 32,
                height: 32
            )
        )
        
        discoverCollectionsButton.setImage(UIImage(named: "disco_list_btn"), for: .normal)
        discoverCollectionsButton.setImage(UIImage(named: "disco_grid_btn"), for: .selected)
        discoverCollectionsButton.addTarget(self,
                                            action: #selector(discoverCollectionsButtonTapped),
                                            for: .touchUpInside)
        discoverCollectionsButton.isSelected = true
        navigationBarContainer.addSubview(discoverCollectionsButton)
        showCollectionDetailsBtn = discoverCollectionsButton
        let searchTextField = UITextField(
            frame: CGRect(
                x: 16,
                y: 90,
                width: navigationBarContainer.bounds.width - (16 + 16),
                height: 40
            )
        )
        
        searchTextField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        searchTextField.textColor = UIColor(named: "mainText")
        searchTextField.layer.cornerRadius = 16
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.black.cgColor
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
        searchTextField.fillRemoteBack()
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
        
        // Add the collection views and view to the stack view
        view.addSubview(addToCollectionHintView)
        addToCollectionHintView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(navigationBarTopOffset)
            noFavHeight = make.height.equalTo(144.0)
        }
        
        view.addSubview(filterHeaderView)
        filterHeaderView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalTo(addToCollectionHintView.snp.bottom)
            make.height.equalTo(64.0)
        }
        
        view.addSubview(recCollectionView)
        recCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.top.equalTo(filterHeaderView.snp.bottom).offset(8.0)
            make.bottom.equalToSuperview()
        }
        recCollectionView.refreshControl = self.refreshControl
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        
        setSources()
        
        //        showMoreButton.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 64)
        //        showMoreButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        //        showMoreButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        //        showMoreButton.autoSetDimension(.height, toSize: 64.0)
        
        
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
                RecentViewedManager.shared.addViewedStock(HomeTickerInnerTableViewCellModel.init(ticker: ticker))
                _ = self?.coordinator?.showCardsDetailsViewController(tickers.compactMap({TickerInfo(ticker: $0)}), index: index)
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
            self?.recCollectionView.reloadData()
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
        NotificationCenter.default.publisher(for: NotificationManager.appBecomeActiveNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                self?.refreshAction()
            }.store(in: &cancellables)
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateScoringSettings)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                self?.refreshAction()
            }.store(in: &cancellables)
        NotificationCenter.default.publisher(for: NotificationManager.discoveryTabPressedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.recCollectionView.contentOffset = CGPoint.zero
            }
            .store(in: &cancellables)
        view.bringSubviewToFront(blurView)
        view.bringSubviewToFront(navigationBarContainer)
        
        self.setupPanel()
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
    
    private let recCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RecommendedCollectionViewCell.self)
        collectionView.register(RecommendedShelfViewCell.self)
        collectionView.register(RecommendShelfBannerViewCell.self)
        collectionView.register(RecommendMSBannerViewCell.self)
        collectionView.register(RecommendedRecentShelfViewCell.self)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private let addToCollectionHintView: UIView = {
        var view = UIView()
        let headerView = NoCollectionsHeaderView.init()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerView.autoPinEdge(toSuperviewEdge: .top)
        headerView.autoPinEdge(toSuperviewEdge: .bottom)
        headerView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        headerView.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        headerView.configureWith(title: "No TTF added yet?", description: "Add at least one TTF from the Recommended\nlist below, just click on the plus icon")
        view.isHidden = true
        return view
    }()
    
    private let showMoreButton: GainyButton = {
        var button = GainyButton()
        let title = "Show more".uppercased()
        button.configureWithTitle(title: title, color: UIColor.white, state: .normal)
        button.configureWithTitle(title: title, color: UIColor.white, state: .disabled)
        button.configureWithTitle(title: title, color: UIColor.white, state: .highlighted)
        let color = UIColor(hexString: "#1B45FB") ?? UIColor.blue
        button.configureWithCornerRadius(radius: 20.0)
        button.configureWithBackgroundColor(color: color)
        button.configureWithHighligtedBackgroundColor(color: color.withAlphaComponent(0.75))
        button.isEnabled = true
        return button
    }()
    
    private var refreshControl = LottieRefreshControl()
    
    private var searchCollectionView: UICollectionView!
    private var searchController: CollectionSearchController?
    private var showCollectionDetailsBtn: UIButton?
    private var searchTextField: UITextField?
    
    private var isFromOnboard: Bool = false
    
    private var yourCollectionsCache: [Collection] = []
    private var yourCollections: [Collection] {
        get {
            return self.yourCollectionsCache
        }
    }
    
    //MARK: - Keyboard
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        searchCollectionView.contentInset = .init(top: 0, left: 0, bottom: self.keyboardSize?.height ?? 0.0, right: 0)
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        searchCollectionView.contentInset = .zero
    }
    
    // MARK: Private
    private func setupPanel() {
        fpc = FloatingPanelController()
        fpc.layout = SortRecCollectionsPanelLayout()
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
    
    class SortRecCollectionsPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 200.0, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 200.0, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 200.0, edge: .bottom, referenceGuide: .safeArea),
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
    
    @objc
    private func discoverCollectionsButtonTapped() {
        //        GainyAnalytics.logEvent("favorite_view_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        //        self.goToCollectionDetails(at: 0)
        showCollectionDetailsBtn?.isSelected.toggle()
        viewMode = (showCollectionDetailsBtn?.isSelected ?? false) ? .shelf : .grid
    }
    
    private func goToCollectionDetails(at collectionPosition: Int) {
        
        onGoToCollectionDetails?(collectionPosition)
    }
    
    internal func addToYourCollection(collectionItemToAdd: RecommendedCollectionViewCellModel) {
        
        let updatedRecommendedItem = RecommendedCollectionViewCellModel(
            id: collectionItemToAdd.id,
            image: collectionItemToAdd.image,
            imageUrl: collectionItemToAdd.imageUrl,
            name: collectionItemToAdd.name,
            description: collectionItemToAdd.description,
            stocksAmount: collectionItemToAdd.stocksAmount,
            matchScore: collectionItemToAdd.matchScore,
            dailyGrow: collectionItemToAdd.dailyGrow,
            value_change_1w: collectionItemToAdd.value_change_1w,
            value_change_1m: collectionItemToAdd.value_change_1m,
            value_change_3m: collectionItemToAdd.value_change_3m,
            value_change_1y: collectionItemToAdd.value_change_1y,
            value_change_5y: collectionItemToAdd.value_change_5y,
            performance: collectionItemToAdd.performance,
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
            value_change_1w: collectionItemToAdd.value_change_1w,
            value_change_1m: collectionItemToAdd.value_change_1m,
            value_change_3m: collectionItemToAdd.value_change_3m,
            value_change_1y: collectionItemToAdd.value_change_1y,
            value_change_5y: collectionItemToAdd.value_change_5y,
            performance: collectionItemToAdd.performance,
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
                                         value_change_1w: yourCollectionItem.value_change_1w,
                                         value_change_1m: yourCollectionItem.value_change_1m,
                                         value_change_3m: yourCollectionItem.value_change_3m,
                                         value_change_1y: yourCollectionItem.value_change_1y,
                                         value_change_5y: yourCollectionItem.value_change_5y,
                                         performance: yourCollectionItem.performance,
                                         isInYourCollections: true)
            
            if yourCollectionItem.id == Constants.CollectionDetails.top20ID {
                UserProfileManager.shared.yourCollections.insert(collection, at: 0)
            } else {
                UserProfileManager.shared.yourCollections.append(collection)
            }
            
            self.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
            self.isNoFavTTFs = UserProfileManager.shared.yourCollections.isEmpty
            self.tabBarController?.tabBar.isHidden = self.showCollectionDetailsBtn?.isHidden ?? false
            self.initViewModels()
        }
    }
    
    internal func removeFromYourCollection(itemId: Int, yourCollectionItemToRemove: YourCollectionViewCellModel) {
        removeFromYourCollection(itemId: itemId, yourCollectionItemToRemove: yourCollectionItemToRemove, removeFavourite: true)
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
        
        UserProfileManager.shared.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        
        
        self.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
        self.isNoFavTTFs = UserProfileManager.shared.yourCollections.isEmpty
        self.tabBarController?.tabBar.isHidden = showCollectionDetailsBtn?.isHidden ?? false
        
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
                value_change_1w: recommendedItem.value_change_1w,
                value_change_1m: recommendedItem.value_change_1m,
                value_change_3m: recommendedItem.value_change_3m,
                value_change_1y: recommendedItem.value_change_1y,
                value_change_5y: recommendedItem.value_change_5y,
                performance: recommendedItem.performance,
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
                value_change_1w: recommendedItem.value_change_1w,
                value_change_1m: recommendedItem.value_change_1m,
                value_change_3m: recommendedItem.value_change_3m,
                value_change_1y: recommendedItem.value_change_1y,
                value_change_5y: recommendedItem.value_change_5y,
                performance: recommendedItem.performance,
                isInYourCollections: false
            )
            
            if let index = UserProfileManager.shared.recommendedCollections.firstIndex { item in
                item.id == recommendedItem.id
            } {
                UserProfileManager.shared.recommendedCollections[index].isInYourCollections = false
                self.initViewModels()
            }
            
        } else {
            
            let reloadItem = RecommendedCollectionViewCellModel(
                id: yourCollectionItemToRemove.id,
                image: yourCollectionItemToRemove.image,
                imageUrl: yourCollectionItemToRemove.imageUrl,
                name: yourCollectionItemToRemove.name,
                description: yourCollectionItemToRemove.description,
                stocksAmount: yourCollectionItemToRemove.stocksAmount,
                matchScore: yourCollectionItemToRemove.matchScore,
                dailyGrow: yourCollectionItemToRemove.dailyGrow,
                value_change_1w: yourCollectionItemToRemove.value_change_1w,
                value_change_1m: yourCollectionItemToRemove.value_change_1m,
                value_change_3m: yourCollectionItemToRemove.value_change_3m,
                value_change_1y: yourCollectionItemToRemove.value_change_1y,
                value_change_5y: yourCollectionItemToRemove.value_change_5y,
                performance: yourCollectionItemToRemove.performance,
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
                value_change_1w: yourCollectionItemToRemove.value_change_1w,
                value_change_1m: yourCollectionItemToRemove.value_change_1m,
                value_change_3m: yourCollectionItemToRemove.value_change_3m,
                value_change_1y: yourCollectionItemToRemove.value_change_1y,
                value_change_5y: yourCollectionItemToRemove.value_change_5y,
                performance: yourCollectionItemToRemove.performance,
                isInYourCollections: false
            )
            
            if let indexOfRecommendedItemToUpdate = UserProfileManager.shared.recommendedCollections
                .firstIndex(where: { $0.id == yourCollectionItemToRemove.id }) {
                UserProfileManager.shared.recommendedCollections[indexOfRecommendedItemToUpdate].isInYourCollections = false
                self.initViewModels()
            }
        }
    }
    
    private func initViewModelsFromData() {
        
        if let profileID = UserProfileManager.shared.profileID {
            let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(profileID)
            filterHeaderView.delegate = self
            filterHeaderView.configureWith(title: "Find your TTFs", description: "", sortLabelString: settings.sorting.title, periodsHidden: false)
        }
        
        
        viewModel?.yourCollections = self.yourCollections
            .map { CollectionViewModelMapper.map($0) }
        
        var recColls: [RecommendedCollectionViewCellModel] = []
        
        var mergedCollections = UserProfileManager.shared.recommendedCollections
        
        for (_, val) in mergedCollections.enumerated() {
            if val.isInYourCollections {
                viewModel?.addedRecs[val.id] = CollectionViewModelMapper.map(val)
            } else {
                recColls.append(CollectionViewModelMapper.map(val))
            }
        }
        
        for (_, val) in UserProfileManager.shared.yourCollections.enumerated() {
            let mapped: RecommendedCollectionViewCellModel = CollectionViewModelMapper.map(val)
            viewModel?.addedRecs[val.id] = mapped
            recColls.append(mapped)
        }
        viewModel?.recommendedCollections = sortRecommendedCollections(recColls: recColls)
        self.initViewModels()
    }
    
    private func initViewModels() {
        self.recCollectionView.reloadData()
    }
    
    private func sortRecommendedCollections(recColls: [RecommendedCollectionViewCellModel]) -> [RecommendedCollectionViewCellModel] {
        
        guard let userID = UserProfileManager.shared.profileID else { return [] }
        let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(userID)
        let sorting = settings.sorting
        let period = settings.performancePeriod
        let ascending = settings.ascending
        
        let sorted = recColls.sorted(by: { leftCol, rightCol in
            switch sorting {
            case .performance:
                if !ascending {
                    switch period {
                    case .day:
                        return leftCol.dailyGrow > rightCol.dailyGrow
                    case .week:
                        return leftCol.value_change_1w > rightCol.value_change_1w
                    case .month:
                        return leftCol.value_change_1m > rightCol.value_change_1m
                    case .threeMonth:
                        return leftCol.value_change_3m > rightCol.value_change_3m
                    case .year:
                        return leftCol.value_change_1y > rightCol.value_change_1y
                    case .fiveYears:
                        return leftCol.value_change_5y > rightCol.value_change_5y
                    }
                } else {
                    switch period {
                    case .day:
                        return leftCol.dailyGrow <= rightCol.dailyGrow
                    case .week:
                        return leftCol.value_change_1w <= rightCol.value_change_1w
                    case .month:
                        return leftCol.value_change_1m <= rightCol.value_change_1m
                    case .threeMonth:
                        return leftCol.value_change_3m <= rightCol.value_change_3m
                    case .year:
                        return leftCol.value_change_1y <= rightCol.value_change_1y
                    case .fiveYears:
                        return leftCol.value_change_5y <= rightCol.value_change_5y
                    }
                }
            case .matchScore:
                if !ascending {
                    return leftCol.matchScore > rightCol.matchScore
                } else {
                    return leftCol.matchScore <= rightCol.matchScore
                }
            case .mostPopular:
                if !ascending {
                    return leftCol.performance > rightCol.performance
                } else {
                    return leftCol.performance <= rightCol.performance
                }
            }
        })
        
        return sorted
    }
    
    private func getRemoteData(loadProfile: Bool = false, completion: @escaping () -> Void) {
        guard haveNetwork else {
            completion()
            NotificationManager.shared.showError("Sorry... No Internet connection right now.", report: true) { [weak self] in
                self?.getRemoteData(loadProfile: loadProfile, completion: completion)
            }
            GainyAnalytics.logEvent("no_internet")
            refreshControl.endRefreshing()
            return
        }
        self.currentPage = 1
        UserProfileManager.shared.getProfileCollections(loadProfile: loadProfile, forceReload: UserProfileManager.shared.isFromOnboard) { success in
            self.refreshControl.endRefreshing()
            UserProfileManager.shared.isFromOnboard = false
            self.searchController?.reloadSuggestedCollections()
            self.yourCollectionsCache = UserProfileManager.shared.yourCollections
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

extension DiscoveryViewController {
    
    @objc func textFieldClear() {
        searchTextField?.text = ""
        searchController?.searchText = searchTextField?.text ?? ""
        searchController?.clearAll()
        
        searchTextField?.resignFirstResponder()
        
        UIView.animate(withDuration: 0.3) {
            self.recCollectionView.alpha = 1.0
            self.filterHeaderView.alpha = 1.0
            self.addToCollectionHintView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.showCollectionDetailsBtn?.alpha = 1.0
            
            self.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
            self.isNoFavTTFs = UserProfileManager.shared.yourCollections.isEmpty
            self.tabBarController?.tabBar.isHidden = self.showCollectionDetailsBtn?.isHidden ?? false
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
        GainyAnalytics.logEvent("search_started", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        searchController?.searchText =  ""
        UIView.animate(withDuration: 0.3) {
            self.recCollectionView.alpha = 0.0
            self.filterHeaderView.alpha = 0.0
            self.addToCollectionHintView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
            self.showCollectionDetailsBtn?.alpha = 0.0
        }
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        GainyAnalytics.logEvent("search_ended", params: ["text": textField.text ?? ""])
    }
}

extension DiscoveryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



extension DiscoveryViewController : SingleCollectionDetailsViewControllerDelegate, DiscoveryCategoryViewControllerDelegate {
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        if isAdded {
            if let rightModel = self.recommendedCollections.first(where: { item in
                item.id == collectionID
            }) {
                addToYourCollection(collectionItemToAdd: rightModel)
            }
        } else {
            
            if let rightModel = self.recommendedCollections.first(where: { item in
                item.id == collectionID
            }) {
                let yourCollectionItem = YourCollectionViewCellModel(
                    id: rightModel.id,
                    image: rightModel.image,
                    imageUrl: rightModel.imageUrl,
                    name: rightModel.name,
                    description: rightModel.description,
                    stocksAmount: rightModel.stocksAmount,
                    matchScore: rightModel.matchScore,
                    dailyGrow: rightModel.dailyGrow,
                    value_change_1w: rightModel.value_change_1w,
                    value_change_1m: rightModel.value_change_1m,
                    value_change_3m: rightModel.value_change_3m,
                    value_change_1y: rightModel.value_change_1y,
                    value_change_5y: rightModel.value_change_5y,
                    performance: rightModel.performance,
                    recommendedIdentifier: rightModel
                )
                removeFromYourCollection(itemId: collectionID, yourCollectionItemToRemove: yourCollectionItem)
            }
            
        }
    }
    
    func collectionToggled(vc: DiscoveryCategoryViewController, isAdded: Bool, collectionID: Int) {
        if isAdded {
            if let rightModel = self.recommendedCollections.first(where: { item in
                item.id == collectionID
            }) {
                addToYourCollection(collectionItemToAdd: rightModel)
            }
        } else {
            
            if let rightModel = self.recommendedCollections.first(where: { item in
                item.id == collectionID
            }) {
                let yourCollectionItem = YourCollectionViewCellModel(
                    id: rightModel.id,
                    image: rightModel.image,
                    imageUrl: rightModel.imageUrl,
                    name: rightModel.name,
                    description: rightModel.description,
                    stocksAmount: rightModel.stocksAmount,
                    matchScore: rightModel.matchScore,
                    dailyGrow: rightModel.dailyGrow,
                    value_change_1w: rightModel.value_change_1w,
                    value_change_1m: rightModel.value_change_1m,
                    value_change_3m: rightModel.value_change_3m,
                    value_change_1y: rightModel.value_change_1y,
                    value_change_5y: rightModel.value_change_5y,
                    performance: rightModel.performance,
                    recommendedIdentifier: rightModel
                )
                removeFromYourCollection(itemId: collectionID, yourCollectionItemToRemove: yourCollectionItem)
            }
            
        }
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        viewModel?.shelfDataSource.updateRecent()
        recCollectionView.reloadData()
    }
}

extension DiscoveryViewController: DiscoveryGridItemActionable {
    func openStock(stock: HomeTickerInnerTableViewCellModel, category: DiscoverySectionInfo?) {
        
        showNetworkLoader()
        Task(priority: .background) {
            let tickers = await CollectionsManager.shared.getStocks(symbols: [stock.symbol])
            await MainActor.run {
                if let firstTicker = tickers.first {
                    _ = self.coordinator?.showCardsDetailsViewController(tickers.compactMap({_ in TickerInfo(ticker: firstTicker)}), index: 0)
                }
                self.hideLoader()
            }
        }        
    }
    
    
    func addToYourCollection(collectionItemToAdd: RecommendedCollectionViewCellModel, category: DiscoverySectionInfo?) {
        AnalyticsKeysHelper.shared.ttfOpenCategory = category?.titleForAMP ?? "none"
        addToYourCollection(collectionItemToAdd: collectionItemToAdd)
    }
    
    func removeFromYourCollection(itemId: Int, yourCollectionItemToRemove: YourCollectionViewCellModel, category: DiscoverySectionInfo?) {
        AnalyticsKeysHelper.shared.ttfOpenCategory = category?.titleForAMP ?? "none"
        removeFromYourCollection(itemId: itemId, yourCollectionItemToRemove: yourCollectionItemToRemove)
    }
    
    func openCollection(collection: RecommendedCollectionViewCellModel, category: DiscoverySectionInfo?) {
        let recColl = collection
        AnalyticsKeysHelper.shared.ttfOpenSource = "discovery"
        AnalyticsKeysHelper.shared.ttfOpenCategory = category?.titleForAMP ?? "none"
        coordinator?.showCollectionDetails(collectionID: recColl.id, delegate: self, haveNoFav: UserProfileManager.shared.favoriteCollections.isEmpty)
        GainyAnalytics.logEvent("recommended_collection_pressed", params: ["collectionID": recColl.id, "type" : "recommended", "ec" : "DiscoverCollections"])
    }
    
    func showMore(collections: [RecommendedCollectionViewCellModel], category: DiscoverySectionInfo) {
        let fullCollection = viewModel?.shelfDataSource.shelfs[category] ?? []
        coordinator?.showCollectionCategory(category: category,
                                            collections: category == .topUp || category == .topDown ? (viewModel?.recommendedCollections ?? []) : fullCollection,
                                            delegate: self)
    }    
    
    func bannerClosePressed() {
        viewModel?.shelfDataSource.isBannerHidden = true
        recCollectionView.reloadData()
    }
    
    func bannerRequestPressed() {
        
    }
    
    func msRequestPressed() {
        let interestsVC = PersonalizationPickInterestsViewController.instantiate(.onboarding)
        let navigationController = UINavigationController.init(rootViewController: interestsVC)
        interestsVC.mainCoordinator = self.coordinator
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func infoPressed(category: DiscoverySectionInfo) {
        GainyAnalytics.logEventAMP("disc_hint_shown", params: ["category" : category.titleForAMP])
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: category.explanationTitle)
        explanationVc.configureWith(description: category.explanationDescription,
                                    linkString: nil,
                                    link: nil)
        FloatingPanelManager.shared.configureWithHeight(height: CGFloat(category.explanationHeight))
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
}

extension DiscoveryViewController: RecommendedCollectionsHeaderViewDelegate {
    func sortByTapped() {
        guard self.presentedViewController == nil else {return}
        GainyAnalytics.logEvent("disc_sort_tapped", params: ["discType" : "all", "category" : "none"])
        fpc.layout = SortRecCollectionsPanelLayout()
        self.fpc.set(contentViewController: sortingVS)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func didChangePerformancePeriod(period: RecommendedCollectionsSortingSettings.PerformancePeriodField) {
        GainyAnalytics.logEvent("disc_period_changed", params: ["period": period.title, "discType" : "all"])
        self.initViewModelsFromData()
    }
}

extension DiscoveryViewController: SortDiscoveryViewControllerDelegate {
    func selectionChanged(vc: SortDiscoveryViewController, sorting: RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField, ascending: Bool) {
        GainyAnalytics.logEvent("disc_sort_changed", params: ["sortBy" : sorting, "isDescending": ascending ? "false" : "true"])
        self.fpc.dismiss(animated: true) {
            self.initViewModelsFromData()
        }
    }
}

extension DiscoveryViewController: FloatingPanelControllerDelegate {
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
