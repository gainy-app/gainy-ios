//
//  HoldingsPieChartViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/9/22.
//

import UIKit
import SkeletonView
import FloatingPanel
import Combine
import GainyAPI

final class HoldingsPieChartViewController: BaseViewController {
    public var onSettingsPressed: (() -> Void)?
    public var onPlusPressed: (() -> Void)?
    
    private(set) var collectionView: DetectableCollectionView!
    private lazy var refreshControl: LottieRefreshControl = {
        let control = LottieRefreshControl()
        control.layer.zPosition = -1
        control.clipsToBounds = true
        control.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return control
    } ()
    private let viewModel: HoldingsPieChartViewModel
    private var isFirstLoad = true
    
    init(viewModel: HoldingsPieChartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Hosted VCs
    private lazy var sortingVC = SortPortfolioPieChartViewController.instantiate(.popups)
    private lazy var sortingTickersVC = SortPortfolioPieChartTickersViewController.instantiate(.popups)
    
    public weak var delegate: HoldingsViewControllerDelegate?
    //Panel
    private var fpc: FloatingPanelController!
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.actionPerformer = self
        
        self.view.clipsToBounds = false
        self.view.isUserInteractionEnabled = true
        
        let layout = UICollectionViewFlowLayout.init()
        collectionView = DetectableCollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.normalizeAdjustedContentInset = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
        collectionView.register(CollectionChartCardCell.self)
        
        collectionView.register(CollectionDetailsFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "CollectionDetailsFooterView")
        
        collectionView.register(HoldingPieChartCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HoldingPieChartCollectionHeaderView")
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 0.0, left: 0, bottom: 85, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.clipsToBounds = true
        self.view.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.zero, excludingEdge: .top)
        collectionView.autoPinEdge(.top, to: .top, of: self.view, withOffset: 5.0)
        collectionView.isSkeletonable = true
        collectionView.skeletonCornerRadius = 6.0
        setupPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadChartData()
    }
    
    @objc func refresh(_ sender:AnyObject) {
        self.reloadChartData()
    }
    
    public func reloadChartData() {
        showNetworkLoader()
        self.reloadData()
        collectionView.contentInset = .init(top: 0.0, left: 0, bottom: 85, right: 0)
        view.showAnimatedGradientSkeleton()
        Task() {
            if isFirstLoad {
                await viewModel.loadFilters()
                isFirstLoad = false
            }
            await viewModel.reloadData()
            await MainActor.run {
                hideLoader()
            }
        }
    }
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        fpc.surfaceView.appearance = appearance
        fpc.delegate = self // Optional
    }
    
    private func showSortingPanel() {
        guard let userID = viewModel.profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.pieShared.getSettingByUserID(userID) else {
            return
        }
        
        let layout = MyFloatingPanelLayout()
        
        fpc.layout = layout
        sortingVC.delegate = self
        sortingVC.isDemoProfile = viewModel.isDemoProfile
        sortingTickersVC.delegate = self
        sortingTickersVC.isDemoProfile = viewModel.isDemoProfile
        
        let mode = settings.pieChartMode
        layout.height = 160.0
        fpc.set(contentViewController: sortingVC)
        
        fpc.isRemovalInteractionEnabled = true
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    class MyFloatingPanelLayout: FloatingPanelLayout {
        public var height: CGFloat = 0.0
        let position: FloatingPanelPosition = .bottom
        let initialState: FloatingPanelState = .tip
        var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(absoluteInset: self.height, edge: .bottom, referenceGuide: .safeArea),
                .half: FloatingPanelLayoutAnchor(absoluteInset: self.height, edge: .bottom, referenceGuide: .safeArea),
                .tip: FloatingPanelLayoutAnchor(absoluteInset: self.height, edge: .bottom, referenceGuide: .safeArea),
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
}

// MARK: - HoldingsPieChartViewModelActionPerformer
extension HoldingsPieChartViewController: HoldingsPieChartViewModelActionPerformer {
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HoldingsPieChartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pieChartDataFilteredSorted.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.chartCardCellForItemAtIndexPath(indexPath: indexPath)
    }
    
    func chartCardCellForItemAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionChartCardCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionChartCardCell.cellIdentifier, for: indexPath) as! CollectionChartCardCell
        let chartData = viewModel.pieChartDataFilteredSorted
        guard indexPath.row < chartData.count else {
            return cell
        }
        
        let chartDataObj = chartData[indexPath.row]
        cell.configureWithChartData(data: chartDataObj, index: indexPath.row, customTickerLayout: false)
        
        let chartDataSorted = chartData.sorted(by: { itemLeft, itemRight in
            itemLeft.weight ?? 0.0 > itemRight.weight ?? 0.0
        })
        let colors = UIColor.Gainy.pieChartColors
        if let colorIndex = chartDataSorted.firstIndex(where: { item in
            (item.entityId ?? "").lowercased() == (chartDataObj.entityId ?? "").lowercased()
        }) {
            let color = (colorIndex <= 8 ? colors[colorIndex] : colors[9]) ?? UIColor.white
            cell.configureWithColor(color: color)
        } else {
            cell.configureWithColor(color: colors[9] ?? UIColor.white)
        }

        cell.removeBlur()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HoldingPieChartCollectionHeaderView.reuseIdentifier, for: indexPath) as! HoldingPieChartCollectionHeaderView
            headerView.isDemoProfile = viewModel.isDemoProfile
            guard let userID = viewModel.profileToUse else {
                return headerView
            }
            guard let settings = PortfolioSettingsManager.pieShared.getSettingByUserID(userID) else {
                return headerView
            }
            
            headerView.configureWithPieChartData(pieChartData: viewModel.pieChartDataFilteredSorted, mode: settings.pieChartMode, loading: viewModel.isLoading)
            headerView.updateChargeLbl(settings.sortingText(mode: settings.pieChartMode))

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                headerView.setNeedsLayout()
                headerView.layoutIfNeeded()
            })
            
            headerView.onSettingsPressed = {
                self.onSettingsPressed?()
            }
            
            headerView.onSortingPressed = {
                self.showSortingPanel()
            }
            
            headerView.onPlusPressed = {
                self.onPlusPressed?()
            }
            
            headerView.onChartTickerButtonPressed = {
                PortfolioSettingsManager.pieShared.changePieChartModeForUserId(userID, pieChartMode: .tickers)
                self.reloadData()
            }
            
            headerView.onChartCategoryButtonPressed = {
                PortfolioSettingsManager.pieShared.changePieChartModeForUserId(userID, pieChartMode: .categories)
                self.reloadData()
            }
            
            headerView.onChartInterestButtonPressed = {
                PortfolioSettingsManager.pieShared.changePieChartModeForUserId(userID, pieChartMode: .interests)
                self.reloadData()
            }
            
            headerView.onChartSecurityTypeButtonPressed = {
                PortfolioSettingsManager.pieShared.changePieChartModeForUserId(userID, pieChartMode: .securityType)
                self.reloadData()
            }
            headerView.removeBlur()
            headerView.removeBlockView()
            headerView.clipsToBounds = false
            result = headerView
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionDetailsFooterView", for: indexPath)
            return footer
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
    
    private func reloadData() {
        viewModel.filterAndSortPieChartData()
    }
}

// MARK: FloatingPanelControllerDelegate

extension HoldingsPieChartViewController: FloatingPanelControllerDelegate {
    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        if vc.isAttracting == false {
            
            if let prevY = floatingPanelPreviousYPosition {
                shouldDismissFloatingPanel = prevY < vc.surfaceLocation.y
            }
            let loc = vc.surfaceLocation
            let minY = vc.surfaceLocation(for: .full).y
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

// MARK: SortPortfolioPieChartViewControllerDelegate

extension HoldingsPieChartViewController: SortPortfolioPieChartViewControllerDelegate {
    func selectionChanged(vc: SortPortfolioPieChartViewController, sorting: PortfolioSortingField, ascending: Bool) {
        self.fpc.dismiss(animated: true, completion: nil)
        self.reloadData()
    }
}

// MARK: SortPortfolioPieChartTickersViewControllerDelegate

extension HoldingsPieChartViewController: SortPortfolioPieChartTickersViewControllerDelegate {
    func selectionChanged(vc: SortPortfolioPieChartTickersViewController, sorting: PortfolioSortingField, ascending: Bool) {
        self.fpc.dismiss(animated: true, completion: nil)
        self.reloadData()
    }
}

// MARK: UICollectionViewDelegate

extension HoldingsPieChartViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        guard UICollectionView.elementKindSectionFooter == elementKind else { return }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension HoldingsPieChartViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = 56.0
        let width = collectionView.frame.width - 30
        
        return CGSize.init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(8.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: 8.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let chartHeight = (UIScreen.main.bounds.width - 40.0 * 2.0)
        let freeSpace = 177.0
        return CGSize.init(width: collectionView.frame.width, height: chartHeight + freeSpace)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.width, height: 64.0)
    }
}
