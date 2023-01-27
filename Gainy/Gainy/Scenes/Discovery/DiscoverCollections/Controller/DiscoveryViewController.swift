import Foundation
import GainyCommon
import FloatingPanel

final class DiscoveryViewController: BaseViewController {
    
    weak var authorizationManager: AuthorizationManager?
    var viewModel: DiscoveryViewModelProtocol?
    weak var coordinator: MainCoordinator?
    
    var onGoToCollectionDetails: ((Int) -> Void)?
    var onRemoveCollectionFromYourCollections: (() -> Void)?
    
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
        showNetworkLoader()
        getRemoteData(loadProfile: true ) {
            DispatchQueue.main.async { [weak self] in
                self?.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
                self?.tabBarController?.tabBar.isHidden = self?.showCollectionDetailsBtn?.isHidden ?? false
                self?.addToCollectionHintView.isHidden = !UserProfileManager.shared.yourCollections.isEmpty
                self?.initViewModels()
                self?.hideLoader()
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
        
        discoverCollectionsButton.setImage(UIImage(named: "collection-details"), for: .normal)
        discoverCollectionsButton.addTarget(self,
                                            action: #selector(discoverCollectionsButtonTapped),
                                            for: .touchUpInside)
        
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
        
        // Add the collection views and view to the stack view
        stackView.addArrangedSubview(addToCollectionHintView)
        stackView.addArrangedSubview(topCollectionView)
        stackView.addArrangedSubview(recCollectionView)
        
        // Hide show more for now
//        stackView.addArrangedSubview(showMoreButton)
//        self.showMoreButton.buttonActionHandler = { sender in
//            self.currentPage += 1
//            self.initViewModels()
//        }
        
        // Disable scrolling in the collection views
        self.topCollectionViewHeightConstraint = topCollectionView.autoSetDimension(.height, toSize: 600)
        self.recCllectionViewHeightConstraint = recCollectionView.autoSetDimension(.height, toSize: 1000)
        addToCollectionHintView.autoSetDimension(.height, toSize: 144)
        
        topCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        topCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        recCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        recCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        
        addToCollectionHintView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
//        showMoreButton.autoSetDimension(.width, toSize: UIScreen.main.bounds.width - 64)
//        showMoreButton.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
//        showMoreButton.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
//        showMoreButton.autoSetDimension(.height, toSize: 64.0)
        
        topCollectionView.dataSource = self
        recCollectionView.dataSource = self
        
        topCollectionView.delegate = self
        recCollectionView.delegate = self
        
        // Add the stack view to the scroll view
        scrollView.addSubview(stackView)
        
        // Set up the constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Add the scroll view to the view hierarchy
        view.addSubview(scrollView)
        scrollView.autoPinEdge(toSuperviewEdge: .left)
        scrollView.autoPinEdge(toSuperviewEdge: .right)
        scrollView.autoPinEdge(toSuperviewEdge: .bottom)
        scrollView.autoPinEdge(.top, to: .top, of: view, withOffset: navigationBarTopOffset)
        
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
            self?.topCollectionView.reloadData()
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
        NotificationCenter.default.publisher(for: NotificationManager.discoveryTabPressedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.scrollView.contentOffset = CGPoint.zero
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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private var topCollectionViewHeightConstraint :NSLayoutConstraint? = nil
    private let topCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RecommendedCollectionViewCell.self)
        collectionView.registerSectionHeader(RecommendedCollectionsHeaderView.self)
        collectionView.isHidden = true
        return collectionView
    }()
    
    private var recCllectionViewHeightConstraint :NSLayoutConstraint? = nil
    private let recCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RecommendedCollectionViewCell.self)
        collectionView.registerSectionHeader(RecommendedCollectionsHeaderView.self)
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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
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
    
    @objc
    private func discoverCollectionsButtonTapped() {
        GainyAnalytics.logEvent("discover_collection_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        self.goToCollectionDetails(at: 0)
    }
    
    private func goToCollectionDetails(at collectionPosition: Int) {
        
        onGoToCollectionDetails?(collectionPosition)
    }
    
    private func addToYourCollection(collectionItemToAdd: RecommendedCollectionViewCellModel) {
        
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
            self.addToCollectionHintView.isHidden = !UserProfileManager.shared.yourCollections.isEmpty
            self.tabBarController?.tabBar.isHidden = self.showCollectionDetailsBtn?.isHidden ?? false
            self.initViewModels()
        }
    }
    
    private func removeFromYourCollection(itemId: Int, yourCollectionItemToRemove: YourCollectionViewCellModel, removeFavourite : Bool = true, removeFromYourTTF: Bool = false) {
        
        if let delIndex = UserProfileManager.shared.favoriteCollections.firstIndex(of: itemId) {
            if removeFavourite {
                showNetworkLoader()
                UserProfileManager.shared.removeFavouriteCollection(itemId) { success in
                    
                    self.hideLoader()
                    self.removeFromYourCollection(itemId: itemId, yourCollectionItemToRemove: yourCollectionItemToRemove, removeFavourite: false, removeFromYourTTF:removeFromYourTTF)
                }
                return
            }
        }
        
        UserProfileManager.shared.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }
        
        
        self.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
        self.addToCollectionHintView.isHidden = !UserProfileManager.shared.yourCollections.isEmpty
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
    
    private func initViewModels() {
        
        self.view.setNeedsLayout()
        self.topCollectionView.reloadData()
        self.recCollectionView.reloadData()
        //
        let size = (self.topCollectionView.frame.size.width - 16.0) / 2.0
        let spaces = ceil(Float(self.recommendedCollections.count) / 2.0) * 16.0 - 16.0
        let rows = ceil(Float(self.recommendedCollections.count) / 2.0)
        var headerHeight: CGFloat = 40.0
        if let profileID = UserProfileManager.shared.profileID {
            let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(profileID)
            if settings.sorting == .performance {
                headerHeight += 70.0
            }
        }
        var spacesPlusHeader = CGFloat(42.0) + headerHeight
        self.topCollectionViewHeightConstraint?.constant = CGFloat(3.0 * CGFloat(size) + spacesPlusHeader)
        spacesPlusHeader = CGFloat(spaces) + headerHeight
        self.recCllectionViewHeightConstraint?.constant = CGFloat(CGFloat(rows) * CGFloat(size) + spacesPlusHeader)
        //
        self.view.layoutIfNeeded()
        
    }
    
    private func initViewModelsFromData() {
        
        viewModel?.yourCollections = self.yourCollections
            .map { CollectionViewModelMapper.map($0) }
        
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
        self.initViewModels()
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
            self.stackView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
            self.showCollectionDetailsBtn?.alpha = 1.0
            
            self.showCollectionDetailsBtn?.isHidden = UserProfileManager.shared.yourCollections.isEmpty
            self.addToCollectionHintView.isHidden = !UserProfileManager.shared.yourCollections.isEmpty
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
        GainyAnalytics.logEvent("collections_search_started", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        searchController?.searchText =  ""
        UIView.animate(withDuration: 0.3) {
            self.stackView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
            self.showCollectionDetailsBtn?.alpha = 0.0
        }
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        GainyAnalytics.logEvent("collections_search_ended", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
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

extension DiscoveryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collection = self.recommendedCollections
        if collectionView == self.recCollectionView {
            return collection.count
        } else if collectionView == self.topCollectionView {
            return (collection.count >= 5) ? 5 : 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommendedCollectionViewCell else { return UICollectionViewCell() }
        
        let collection = self.recommendedCollections
        let modelItem = collection[indexPath.row]
        let buttonState: RecommendedCellButtonState = UserProfileManager.shared.favoriteCollections.contains(modelItem.id)
        ? .checked
        : .unchecked
        
        
        var grow: Float = modelItem.dailyGrow
        
        if let userID = UserProfileManager.shared.profileID {
            let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(userID)
            switch settings.performancePeriod {
            case .day:
                grow = modelItem.dailyGrow
            case .week:
                grow = modelItem.value_change_1w
            case .month:
                grow = modelItem.value_change_1m
            case .threeMonth:
                grow = modelItem.value_change_3m
            case .year:
                grow = modelItem.value_change_1y
            case .fiveYears:
                grow = modelItem.value_change_5y
            }
        }
        
        cell.configureWith(
            name: modelItem.name,
            imageUrl: modelItem.imageUrl,
            description: modelItem.description,
            stocksAmount: modelItem.stocksAmount,
            matchScore: modelItem.matchScore,
            dailyGrow: grow,
            imageName: modelItem.image,
            plusButtonState: buttonState
        )
        
        
        
        cell.tag = modelItem.id
        cell.onPlusButtonPressed = { [weak self] in
            cell.isUserInteractionEnabled = false
            
            cell.setButtonChecked()
            self?.addToYourCollection(collectionItemToAdd: modelItem)
            
            cell.isUserInteractionEnabled = true
            GainyAnalytics.logEvent("add_to_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
            
            if !(self?.isFromOnboard ?? false) {
                GainyAnalytics.logEvent("wl_add", params: ["collectionID" : modelItem.id])
            }
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
                value_change_1w: modelItem.value_change_1w,
                value_change_1m: modelItem.value_change_1m,
                value_change_3m: modelItem.value_change_3m,
                value_change_1y: modelItem.value_change_1y,
                value_change_5y: modelItem.value_change_5y,
                performance: modelItem.performance,
                recommendedIdentifier: modelItem
            )
            self?.removeFromYourCollection(itemId: modelItem.id, yourCollectionItemToRemove: yourCollectionItem)
            
            cell.isUserInteractionEnabled = true
            GainyAnalytics.logEvent("remove_from_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: RecommendedCollectionsHeaderView =
            collectionView.dequeueReusableSectionHeader(for: indexPath)
            if collectionView == topCollectionView {
                headerView.configureWith(title: "Top 5 TTFs", description: "")
            } else {
                if let profileID = UserProfileManager.shared.profileID {
                    let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(profileID)
                    headerView.delegate = self
                    headerView.configureWith(title: "Find your TTFs", description: "", sortLabelString: settings.sorting.title, periodsHidden: settings.sorting != .performance)
                }
            }
            return headerView
        }
        
        return UICollectionReusableView.init()
    }
}

extension DiscoveryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = floor(collectionView.frame.size.width - 16.0) / 2.0
        return CGSize.init(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        var height = 40.0 + 16.0
        if let profileID = UserProfileManager.shared.profileID {
            let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(profileID)
            if settings.sorting == .performance {
                height += 56.0
            }
        }
        return CGSize.init(width: collectionView.frame.size.width, height: height)
    }
}

extension DiscoveryViewController : SingleCollectionDetailsViewControllerDelegate {
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
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        
    }
}

extension DiscoveryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.topCollectionView {
            // Top 5 is hardcoded (and disabled for now)
            let recColl = self.recommendedCollections[indexPath.row]
            coordinator?.showCollectionDetails(collectionID: recColl.id, delegate: self, haveNoFav: self.isFromOnboard)
            GainyAnalytics.logEvent("recommended_collection_pressed", params: ["collectionID": UserProfileManager.shared.recommendedCollections[indexPath.row].id, "type" : "recommended", "ec" : "DiscoverCollections"])
        } else if collectionView == self.recCollectionView {
            let recColl = self.recommendedCollections[indexPath.row]
            coordinator?.showCollectionDetails(collectionID: recColl.id, delegate: self, haveNoFav: self.isFromOnboard)
            GainyAnalytics.logEvent("recommended_collection_pressed", params: ["collectionID": UserProfileManager.shared.recommendedCollections[indexPath.row].id, "type" : "recommended", "ec" : "DiscoverCollections"])
        }
    }
}

extension DiscoveryViewController: RecommendedCollectionsHeaderViewDelegate {
    func sortByTapped() {
        guard self.presentedViewController == nil else {return}
        GainyAnalytics.logEvent("sorting_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Discovery"])
        fpc.layout = SortRecCollectionsPanelLayout()
        self.fpc.set(contentViewController: sortingVS)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func didChangePerformancePeriod(period: RecommendedCollectionsSortingSettings.PerformancePeriodField) {
        GainyAnalytics.logEvent("performance_period_changed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Discovery"])
        self.initViewModelsFromData()
    }
}

extension DiscoveryViewController: SortDiscoveryViewControllerDelegate {
    func selectionChanged(vc: SortDiscoveryViewController, sorting: RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField, ascending: Bool) {
        GainyAnalytics.logEvent("sorting_changed", params: ["sorting" : sorting, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Discovery"])
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
