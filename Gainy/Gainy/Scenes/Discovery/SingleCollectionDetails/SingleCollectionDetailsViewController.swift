//
//  SingleCollectionDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.10.2021.
//

import UIKit
import FloatingPanel

protocol SingleCollectionDetailsViewControllerDelegate: AnyObject {
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int)
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int)
}

final class SingleCollectionDetailsViewController: BaseViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
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
    
    //MARK: - DI
    var coordiantor: MainCoordinator?
    var collectionId: Int!
    var model: CollectionDetailViewCellModel!
    
    weak var coordinator: MainCoordinator?
    weak var delegate: SingleCollectionDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        initCollectionView()
        setupPanel()
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
            collectionView.autoPinEdge(.top, to: .top, of: view, withOffset: 72)
            collectionView.autoPinEdge(.leading, to: .leading, of: view)
            collectionView.autoPinEdge(.trailing, to: .trailing, of: view)
            collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
            
            collectionView.register(CollectionDetailsViewCell.self)
            
            collectionView.backgroundColor = .clear
            collectionView.showsVerticalScrollIndicator = false
            collectionView.dragInteractionEnabled = true
            collectionView.bounces = false
            viewModel?.initCollectionView(collectionView: collectionView)
        }
        
        
        
        viewModel?.loadCollectionDetails({
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: { [weak self] in
                self?.centerInitialCollectionInTheCollectionView()
            })
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
    }
    
    fileprivate func centerInitialCollectionInTheCollectionView() {
        guard viewModel?.haveCollection ?? false else {return}
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                     at: .centeredHorizontally,
                                                     animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
        GainyAnalytics.logEvent("close_single_collection", params: ["collectionID" : collectionId])
    }
    
    @IBAction func toggleCollectionAction(_ sender: Any) {
        toggleBtn.isSelected.toggle()
        delegate?.collectionToggled(vc: self, isAdded: toggleBtn.isSelected, collectionID: collectionId)
        GainyAnalytics.logEvent(toggleBtn.isSelected ? "single_collection_added_to_yours" :  "single_collection_removed_from_yours", params: ["collectionID" : collectionId])
    }
}


extension SingleCollectionDetailsViewController: SingleCollectionDetailsViewModelDelegate {
    func tickerPressed(source: SingleCollectionDetailsViewModel, tickers: [RemoteTickerDetails], ticker: RemoteTickerDetails) {
        if let index = tickers.firstIndex(where: {$0.symbol == ticker.symbol}) {
            self.postLeaveAnalytics()
            coordinator?.showCardsDetailsViewController(tickers.compactMap({TickerInfo(ticker: $0)}), index: index)
        }
    }
    
    func sortingPressed(source: SingleCollectionDetailsViewModel, model: CollectionDetailViewCellModel, cell: CollectionDetailsViewCell) {
        guard self.presentedViewController == nil else {return}
        self.sortingVS.collectionId = model.id
        self.sortingVS.collectionCell = cell
        self.currentCollectionToChange = model.id
        GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : model.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        fpc.layout = SortPanelLayout()
        self.fpc.set(contentViewController: sortingVS)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func addStockPressed(source: SingleCollectionDetailsViewModel) {
        guard self.presentedViewController == nil else {return}
        searchStocksVC.delegate = self
        GainyAnalytics.logEvent("add_stock_pressed", params: ["collectionID" : model.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        fpc.layout = SearchPanelLayout()
        self.fpc.set(contentViewController: searchStocksVC)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func settingsPressed(source: SingleCollectionDetailsViewModel, collectionID: Int, ticker: RemoteTickerDetails) {
        
        self.coordinator?.showMetricsViewController(ticker:ticker, collectionID: collectionID, delegate: self)
    }
}

extension SingleCollectionDetailsViewController: SortCollectionDetailsViewControllerDelegate {
    func selectionChanged(vc: SortCollectionDetailsViewController, sorting: String) {
        GainyAnalytics.logEvent("sorting_changed", params: ["collectionID": collectionId, "sorting" : sorting, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        self.fpc.dismiss(animated: true, completion: nil)
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
        if let cell = collectionView.cellForItem(at: IndexPath.init(row: 0, section: 0)) as? CollectionDetailsViewCell {
            cell.addRemoteStocks([stock])
        }
        self.fpc.dismiss(animated: true, completion: nil)
    }
}

extension SingleCollectionDetailsViewController: MetricsViewControllerDelegate {
    
    func didDismissMetricsViewController() {
        
        self.collectionView.reloadData()
    }
}
