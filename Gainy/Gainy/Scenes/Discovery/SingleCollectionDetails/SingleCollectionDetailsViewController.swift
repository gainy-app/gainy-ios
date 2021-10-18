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
    
    // MARK: Properties
    private var viewModel: SingleCollectionDetailsViewModel?
    private var collectionDetailsCollectionView: UICollectionView!
    
    //Panel
    private var fpc: FloatingPanelController!
    private var currentCollectionToChange: Int = 0
    private lazy var sortingVS = SortCollectionDetailsViewController.instantiate(.popups)
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    //MARK: - DI
    var coordiantor: MainCoordinator?
    var collectionId: Int!
    var model: RecommendedCollectionViewCellModel!
    
    weak var coordinator: MainCoordinator?
    weak var delegate: SingleCollectionDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        initCollectionView()
        setupPanel()
    }
    
    fileprivate func initCollectionView() {
        if let layout = viewModel?.customLayout {
        collectionDetailsCollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: layout
        )
        view.addSubview(collectionDetailsCollectionView)
        collectionDetailsCollectionView.autoPinEdge(.top, to: .top, of: view, withOffset: 72)
        collectionDetailsCollectionView.autoPinEdge(.leading, to: .leading, of: view)
        collectionDetailsCollectionView.autoPinEdge(.trailing, to: .trailing, of: view)
        collectionDetailsCollectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
        
        collectionDetailsCollectionView.register(CollectionDetailsViewCell.self)
        
        collectionDetailsCollectionView.backgroundColor = .clear
        collectionDetailsCollectionView.showsVerticalScrollIndicator = false
        collectionDetailsCollectionView.dragInteractionEnabled = true
        collectionDetailsCollectionView.bounces = false
            
            viewModel?.initCollectionView(collectionView: collectionDetailsCollectionView)
        }
        
    }
    
    fileprivate func setupViewModel() {
        viewModel = SingleCollectionDetailsViewModel.init(collectionId: collectionId)
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
        viewModel?.loadCollectionDetails({            
            DispatchQueue.main.async { [weak self] in
                self?.centerInitialCollectionInTheCollectionView()
            }
        })
        viewModel?.delegate = self
    }
    
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
        
        toggleBtn.isSelected = UserProfileManager.shared.favoriteCollections.contains(collectionId)
    }
    
    fileprivate func centerInitialCollectionInTheCollectionView() {
        guard viewModel?.haveCollection ?? false else {return}
        collectionDetailsCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
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
    func tickerPressed(source: SingleCollectionDetailsViewModel, ticker: RemoteTickerDetails) {
        self.postLeaveAnalytics()
        coordinator?.showCardDetailsViewController(TickerInfo(ticker: ticker))
    }
    
    func sortingPressed(source: SingleCollectionDetailsViewModel, model: CollectionDetailViewCellModel, cell: CollectionDetailsViewCell) {
        guard self.presentedViewController == nil else {return}
            self.sortingVS.collectionId = model.id
            self.sortingVS.collectionCell = cell
            self.currentCollectionToChange = model.id
            GainyAnalytics.logEvent("sorting_pressed", params: ["collectionID" : model.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        self.present(self.fpc, animated: true, completion: nil)
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
