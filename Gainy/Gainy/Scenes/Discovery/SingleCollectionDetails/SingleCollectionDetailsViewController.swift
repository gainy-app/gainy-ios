//
//  SingleCollectionDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.10.2021.
//

import UIKit
import FloatingPanel
import PureLayout
import GainyAPI
import GainyDriveWealth

protocol SingleCollectionDetailsViewControllerDelegate: AnyObject {
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int)
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int)
}

final class SingleCollectionDetailsViewController: BaseViewController {
        
    //MARK: - Outlets
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: Properties
    private var viewModel: SingleCollectionDetailsViewModel?
    private var collectionView: UICollectionView!
    
    //Panel
    private var fpc: FloatingPanelController!
    private var currentCollectionToChange: Int = 0
    
    //Hosted VCs
    private lazy var sortingVS = SortCollectionDetailsViewController.instantiate(.popups)
    private lazy var searchStocksVC = SearchStocksViewController.instantiate(.popups)
    
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    private var currentCollectionViewCell: CollectionDetailsViewCell?
    
    //MARK: - DI
    var collectionId: Int!
    var model: CollectionDetailViewCellModel!
    var isFromSearch: Bool = false
    var haveNoFav: Bool = false
    var shortCollection: RemoteShortCollectionDetails?
    
    var showShortCollectionDetails: Bool {
        get {
            return (self.shortCollection != nil) ? true : false
        }
    }
    
    weak var coordinator: MainCoordinator?
    weak var delegate: SingleCollectionDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        initCollectionView()
        setupPanel()
        
        //self.toggleBtn.isHidden = self.showShortCollectionDetails
        self.shareBtn.isHidden = true
        if self.showShortCollectionDetails {
            //self.closeButton.setImage(UIImage.init(named: "closeIconWhite24"), for: UIControl.State.normal)
            self.view.bringSubviewToFront(self.closeButton)
            self.closeButton.translatesAutoresizingMaskIntoConstraints = false
            for item in self.closeButton.constraints {
                item.autoRemove()
            }
            self.closeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 12)
            self.closeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 22)
            self.closeButton.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
        }
        
        NotificationCenter.default.publisher(for: NotificationManager.subscriptionChangedNotification)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] notif in
                self?.collectionView.reloadData()
            }
            .store(in: &self.cancellables)
        
        NotificationCenter.default.publisher(for: NotificationManager.dwTTFBuySellNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            if let sourceId = notification.userInfo?["name"] as? String {
                guard let self = self else {return}
                if self.viewModel?.collectionDetailsModels.first?.name == sourceId {
                    
                    if !self.toggleBtn.isSelected {
                        self.toggleBtn.isSelected = true
                        self.delegate?.collectionToggled(vc: self,
                                                         isAdded: true,
                                                         collectionID: self.collectionId)
                    }
                }
            }
        }.store(in: &cancellables)
    }
    
    fileprivate func setupViewModel() {
        if collectionId == Constants.CollectionDetails.compareCollectionID {
            viewModel = SingleCollectionDetailsViewModel.init(model: model)
            toggleBtn.isHidden = true
            shareBtn.isHidden = true
        } else {
            viewModel = SingleCollectionDetailsViewModel.init(collectionId: collectionId)
        }
        viewModel?.loadingPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: {[weak self] isLoading in
                if isLoading {
                    self?.showNetworkLoader()
                } else {
                    self?.hideLoader()
                }
            })
            .store(in: &cancellables)
        
        viewModel?.delegate = self
    }
    
    fileprivate func initCollectionView() {
        if let layout = viewModel?.customLayout , let cmpLayout = viewModel?.customCompareLayout {
            collectionView = UICollectionView(
                frame: CGRect.zero,
                collectionViewLayout: collectionId == Constants.CollectionDetails.compareCollectionID ? cmpLayout : layout
            )
            view.addSubview(collectionView)
            collectionView.autoPinEdge(.top, to: .top, of: view, withOffset: CGFloat(72.0))
            collectionView.autoPinEdge(.leading, to: .leading, of: view)
            collectionView.autoPinEdge(.trailing, to: .trailing, of: view)
            collectionView.autoPinEdge(.bottom, to: .bottom, of: view)
            collectionView.tag = Constants.CollectionDetails.singleCollectionId
            collectionView.register(CollectionDetailsViewCell.self)
            
            collectionView.backgroundColor = .clear
            collectionView.showsVerticalScrollIndicator = false
            collectionView.dragInteractionEnabled = true
            collectionView.bounces = false
            viewModel?.initCollectionView(collectionView: collectionView, shortCollection: self.shortCollection)
        }
        
        viewModel?.loadCollectionDetails({
            self.centerInitialCollectionInTheCollectionView()
        })
    }
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        fpc.layout = SortPanelLayout()
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
    
    class SortPanelLayout: FloatingPanelLayout {
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
    
    class SearchPanelLayout: FloatingPanelLayout {
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: 510, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: 510, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: 510, edge: .bottom, referenceGuide: .safeArea),
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
        
        toggleBtn.isSelected = UserProfileManager.shared.favoriteCollections.contains(collectionId)
        GainyAnalytics.logEvent("open_single_collection", params: ["collectionID" : collectionId, "isFromSearch" : isFromSearch])
        SubscriptionManager.shared.getSubscription {[weak self] type in
            guard let self = self else {return}
            if type == .free {
                let isBlocked = !SubscriptionManager.shared.storage.isViewedCollection(self.collectionId)
                GainyAnalytics.logEvent("ttf_view", params: ["collectionID" : self.collectionId, "isFromSearch" : self.isFromSearch, "isBlocked" : isBlocked])
            } else {
                GainyAnalytics.logEvent("ttf_view", params: ["collectionID" : self.collectionId, "isFromSearch" : self.isFromSearch, "isBlocked" : false ])
            }
        }
        
        if haveNoFav {
            toggleBtn.isSelected = true
            delegate?.collectionToggled(vc: self, isAdded: toggleBtn.isSelected, collectionID: collectionId)
            if isFromSearch {
                GainyAnalytics.logEvent(toggleBtn.isSelected ? "single_searched_added_to_yours" :  "single_searched_removed_from_yours", params: ["collectionID" : collectionId])
            } else {
                GainyAnalytics.logEvent(toggleBtn.isSelected ? "single_collection_added_to_yours" :  "single_collection_removed_from_yours", params: ["collectionID" : collectionId])
            }
        }
    }
    
    fileprivate func centerInitialCollectionInTheCollectionView() {
        guard viewModel?.haveCollection ?? false else {return}
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                     at: .centeredHorizontally,
                                                     animated: false)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        delegate?.collectionClosed(vc: self, collectionID: collectionId)
//        hideLoader()
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.collectionClosed(vc: self, collectionID: collectionId)
        hideLoader()
    }
    
    //MARK: - Actions
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
        GainyAnalytics.logEvent("close_single_collection", params: ["collectionID" : collectionId])
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        NotificationManager.shared.showMessage(title: "Sorry", text: "Sharing will be added soon", cancelTitle: "OK", actions: nil)
        GainyAnalytics.logEvent("share_single_collection", params: ["collectionID" : collectionId])
    }
    
    @IBAction func toggleCollectionAction(_ sender: Any) {
        toggleBtn.isSelected.toggle()
        delegate?.collectionToggled(vc: self, isAdded: toggleBtn.isSelected, collectionID: collectionId)
        if isFromSearch {
            GainyAnalytics.logEvent(toggleBtn.isSelected ? "single_searched_added_to_yours" :  "single_searched_removed_from_yours", params: ["collectionID" : collectionId])
        } else {
            GainyAnalytics.logEvent(toggleBtn.isSelected ? "single_collection_added_to_yours" :  "single_collection_removed_from_yours", params: ["collectionID" : collectionId])
        }
        
        if toggleBtn.isSelected {
            GainyAnalytics.logEvent("wl_add", params: ["collectionID" : self.collectionId])
        }
    }
}


extension SingleCollectionDetailsViewController: SingleCollectionDetailsViewModelDelegate {
    func onboardPressed(source: SingleCollectionDetailsViewModel) {
        let interestsVC = PersonalizationPickInterestsViewController.instantiate(.onboarding)
        let navigationController = UINavigationController.init(rootViewController: interestsVC)
        interestsVC.mainCoordinator = self.coordinator
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func tickerPressed(source: SingleCollectionDetailsViewModel, tickers: [RemoteTickerDetails], ticker: RemoteTickerDetails) {
        if let index = tickers.firstIndex(where: {$0.symbol == ticker.symbol}) {
            self.postLeaveAnalytics()
            coordinator?.showCardsDetailsViewController(tickers.compactMap({TickerInfo(ticker: $0)}), index: index)
        }
    }
    
    func sortingPressed(source: SingleCollectionDetailsViewModel, model: CollectionDetailViewCellModel, cell: CollectionDetailsViewCell) {
        guard self.presentedViewController == nil else {return}
        self.currentCollectionViewCell = cell
        self.sortingVS.collectionId = model.id
        self.currentCollectionToChange = model.id
        GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : model.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        fpc.layout = SortPanelLayout()
        self.fpc.set(contentViewController: sortingVS)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func addStockPressed(source: SingleCollectionDetailsViewModel) {
        guard self.presentedViewController == nil else {return}
        searchStocksVC.delegate = self
        //GainyAnalytics.logEvent("add_stock_pressed", params: ["collectionID" : model.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        fpc.layout = SearchPanelLayout()
        self.fpc.set(contentViewController: searchStocksVC)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func settingsPressed(source: SingleCollectionDetailsViewModel, collectionID: Int, ticker: RemoteTickerDetails, cell: CollectionDetailsViewCell) {
        
        self.currentCollectionViewCell = cell
        self.coordinator?.showMetricsViewController(ticker:ticker, collectionID: collectionID, delegate: self)
    }
    
    func purchasePressed(source: SingleCollectionDetailsViewModel) {
        coordinator?.showPurchaseView(delegate: self)
    }
    
    func investPressed(source: SingleCollectionDetailsViewModel) {
        if Configuration().environment == .production {
            self.coordinator?.showDWFlowTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", from: self)
        } else {
            GainyAnalytics.logEvent("dw_invest_pressed", params: ["collectionId" : self.collectionId])
            let testOptionsAlertVC = UIAlertController.init(title: "DEMO", message: "Choose your way", preferredStyle: .actionSheet)
            testOptionsAlertVC.addAction(UIAlertAction(title: "KYC", style: .default, handler: { _ in
                self.coordinator?.dwShowKyc(from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Deposit", style: .default, handler: { _ in
                self.coordinator?.dwShowDeposit(from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Withdraw", style: .default, handler: { _ in
                self.coordinator?.dwShowWithdraw(from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Invest", style: .default, handler: { _ in
                self.coordinator?.dwShowInvestTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Buy", style: .default, handler: { _ in
                self.coordinator?.dwShowBuyToTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Sell", style: .default, handler: { _ in
                self.coordinator?.dwShowSellToTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", available: self.viewModel?.collectionDetailsModels.first?.actualValue ?? 0.0, from: self)
            }))
            testOptionsAlertVC.addAction(UIAlertAction(title: "Original flow", style: .default, handler: { _ in
                self.coordinator?.showDWFlowTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", from: self)
            }))
            
            present(testOptionsAlertVC, animated: true)
        }
    }
    
    func buyPressed(source: SingleCollectionDetailsViewModel) {
        guard UserProfileManager.shared.userRegion == .us else {return}
        guard (UserProfileManager.shared.kycStatus?.buyingPower ?? 0.0) > 0 else {
            NotificationManager.shared.showError("Sorry... You don't have enough amount on your balance.")
            return
        }
        GainyAnalytics.logEvent("dw_buy_pressed", params: ["collectionId" : self.collectionId])
        coordinator?.dwShowBuyToTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", from: self)
    }
    
    func sellPressed(source: SingleCollectionDetailsViewModel, actualValue: Double) {
        guard UserProfileManager.shared.userRegion == .us else {return}
        GainyAnalytics.logEvent("dw_sell_pressed", params: ["collectionId" : self.collectionId])
        coordinator?.dwShowSellToTTF(collectionId: self.collectionId, name: self.viewModel?.collectionDetailsModels.first?.name ?? "", available: actualValue,  from: self)
    }
    
    func cancelPressed(source: SingleCollectionDetailsViewModel, history: TradingHistoryFrag, plainDelete: Bool) {
            guard UserProfileManager.shared.userRegion == .us else {return}
            let colID = self.collectionId ?? -1
        
        if plainDelete {
            let alertController = UIAlertController(title: nil, message: NSLocalizedString("Are you sure want to cancel your order?", comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Exit", comment: ""), style: .cancel) { (action) in
                
            }
            let proceedAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive) { (action) in
                GainyAnalytics.logEvent("ttf_cancel_pending_transaction", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "SingleCollectionDetails"])
                self.showNetworkLoader()
                Task {
                    let accountNumber = await CollectionsManager.shared.cancelTTFOrder(versionID: history.tradingCollectionVersion?.id ?? -1)
                    NotificationCenter.default.post(name: NotificationManager.dwTTFBuySellNotification, object: nil, userInfo: ["name" : history.name ?? ""])
                    await MainActor.run {
                        
                        self.hideLoader()
                    }
                }
                //self.lastPendingTransactionView.isHidden = true
            }
            alertController.addAction(proceedAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            //Getting correct mode
            var mode: DWHistoryOrderMode = .other(history: TradingHistoryFrag())
            if let tradingCollectionVersion = history.tradingCollectionVersion {
                if tradingCollectionVersion.targetAmountDelta ?? 0.0  >= 0.0 {
                    mode = .buy(history: history)
                } else {
                    mode = .sell(history: history)
                }
            } else {
                if let tradingOrder = history.tradingOrder {
                    if tradingOrder.targetAmountDelta ?? 0.0  >= 0.0 {
                        mode = .buy(history: history)
                    } else {
                        mode = .sell(history: history)
                    }
                } else {
                    mode = .other(history: history)
                }
            }
            
            self.coordinator?.showDetailedOrderHistory(name: self.viewModel?.collectionDetailsModels.first?.name ?? "",
                                                       amount: Double(history.amount ?? 0.0),
                                                       mode: mode,
                                                       from: self)
        }
        
    }
    
}

extension SingleCollectionDetailsViewController: SortCollectionDetailsViewControllerDelegate {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String) {
        GainyAnalytics.logEvent("sorting_changed", params: ["collectionID": collectionId, "sorting" : sorting, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        self.fpc.dismiss(animated: true) {
            let compareStocks = (self.collectionId == Constants.CollectionDetails.compareCollectionID)
            if compareStocks {
                self.currentCollectionViewCell?.sortSections()
            } else {
                self.currentCollectionViewCell?.refreshData()
            }
        }
    }
}

extension SingleCollectionDetailsViewController: FloatingPanelControllerDelegate {
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

extension SingleCollectionDetailsViewController: SearchStocksViewControllerDelegate {
    func stockSelected(source: SearchStocksViewController, stock: RemoteTickerDetails) {
        self.fpc.dismiss(animated: true, completion: nil)
        
        guard !model.cards.contains(where: {$0.tickerSymbol == stock.symbol}) else {
            NotificationManager.shared.showMessage(title: "Warning", text: "Sorry, this stock is already in compare", cancelTitle: "OK", actions: nil)
            return
        }
        
        if collectionView.cellForItem(at: IndexPath.init(row: 0, section: 0)) as? CollectionDetailsViewCell != nil {
            if let first = viewModel?.collectionDetailsModels.first {
                let cardsDTO = [stock].compactMap({CollectionDetailsDTOMapper.mapTickerDetails($0)}).compactMap({CollectionDetailsViewModelMapper.map($0)})
                var cards = first.cards
                cards.append(contentsOf: cardsDTO)
                let model = CollectionDetailViewCellModel(
                    id: Constants.CollectionDetails.compareCollectionID,
                    uniqID: "",
                    image: "compare_stocks",
                    imageUrl: "",
                    name: "Compared Stocks",
                    description: "",
                    stocksAmount: first.cards.count + 1,
                    dailyGrow: 0.0,
                    matchScore: RemoteCollectionDetails.MatchScore(),
                    inYourCollectionList: false,
                    lastDayPrice: 0.0,
                    cards: cards
                )
                self.model = model
                self.setupViewModel()
                self.collectionView.removeFromSuperview()
                self.initCollectionView()
                self.setupPanel()
            }
        }
    }
}

extension SingleCollectionDetailsViewController: MetricsViewControllerDelegate {
    
    func didDismissMetricsViewController(needRefresh: Bool) {
        if needRefresh {
            self.currentCollectionViewCell?.refreshData()
        } else {
            self.collectionView.reloadData()
        }
    }
}
extension SingleCollectionDetailsViewController: PurchaseViewControllerDelegate {
    func purchaseClosed(vc: PurchaseViewController) {
        collectionView.reloadData()
    }
}
