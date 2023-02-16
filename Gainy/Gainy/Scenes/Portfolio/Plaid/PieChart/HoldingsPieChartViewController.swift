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
    
    private var isLoading: Bool = false
//    private var pieChartData: [PieChartData] = []
//    private var pieChartDataFilteredSorted: [PieChartData] = []
    private(set) var collectionView: DetectableCollectionView!
    private lazy var refreshControl: LottieRefreshControl = {
        let control = LottieRefreshControl()
        control.layer.zPosition = -1
        control.clipsToBounds = true
        control.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return control
    } ()
    
//    public weak var viewModel: HoldingsViewModel? = nil
    private var viewModel: HoldingsPieChartViewModel = .init()
    
    //MARK: - Hosted VCs
    private lazy var sortingVC = SortPortfolioPieChartViewController.instantiate(.popups)
    private lazy var sortingTickersVC = SortPortfolioPieChartTickersViewController.instantiate(.popups)
    
    public weak var delegate: HoldingsViewControllerDelegate?
    
    //Panel
    private var fpc: FloatingPanelController!
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    
    var isDemoProfile: Bool = false
    var profileToUse: Int? {
        if isDemoProfile {
            return Constants.Plaid.demoProfileID
        } else {
            return UserProfileManager.shared.profileID
        }
    }
    
    //MARK: - Interests and Cats
    var interestsCount = 0
    var categoriesCount = 0
    
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
//        reloadChartData()
        Task() {
            await viewModel.loadFilters()
        }
        setupPanel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        reloadChartData()
    }
    
    @objc func refresh(_ sender:AnyObject) {
        self.reloadChartData()
    }
    
    public func reloadChartData() {
        self.isLoading = true
        self.reloadData()
        Task() {
            await viewModel.reloadData()
        }
    }
    
//    public func loadChartData() {
//        self.isLoading = true
//        guard let profileID = profileToUse else {
//            dprint("Missing profileID")
//            self.isLoading = false
//            return
//        }
//        //replace with piechartsettings call
//        guard let settings = PiePortfolioSettingsManager.shared.getSettingByUserID(profileID) else {
//            self.isLoading = false
//            return
//        }
//        collectionView.contentInset = .init(top: 0.0, left: 0, bottom: 85, right: 0)
//
//        dprint("\(Date()) PieChart for Porto load start")
//        let brokerUniqIds = UserProfileManager.shared.linkedBrokerAccounts.compactMap { item -> String? in
//            let disabled = settings.disabledAccounts.contains { account in
//                item.id == account.id
//            }
//            return disabled ? nil : item.brokerUniqId
//        }
//
//        view.showAnimatedGradientSkeleton()
//        let intrs = settings.interests.filter({$0.selected}).map(\.id)
//        let cats = settings.categories.filter({$0.selected}).map(\.id)
//        let query = GetPortfolioPieChartQuery.init(profileId: profileID,
//                                                   brokerIds: UserProfileManager.shared.linkedBrokerAccounts.count == brokerUniqIds.count ? nil : brokerUniqIds,
//                                                   interestIds: intrs.count == interestsCount || intrs.isEmpty ? nil : intrs,
//                                                   categoryIds: cats.count == categoriesCount || cats.isEmpty ? nil : cats)
//        Network.shared.apollo.fetch(query: query) {result in
//            self.view.hideSkeleton()
//            self.refreshControl.endRefreshing()
//            self.isLoading = false
//            switch result {
//            case .success(let graphQLResult):
//                if let fetchedData = graphQLResult.data?.getPortfolioPiechart {
//                    let data = fetchedData.compactMap { item -> PieChartData? in
//
//                        if let item = item {
//                            let weight = (item.weight != nil) ? float8(item.weight!) : nil
//                            let relativeDailyChange = (item.relativeDailyChange != nil) ? float8(item.relativeDailyChange!) : float8(0)
//                            let absoluteValue = (item.absoluteValue != nil) ? float8(item.absoluteValue!) : nil
//                            let absoluteDailyChange = (item.absoluteDailyChange != nil) ? float8(item.absoluteDailyChange!) : nil
//                            return PieChartData.init(weight: weight,
//                                                     entityType: item.entityType,
//                                                     relativeDailyChange: relativeDailyChange,
//                                                     entityName: item.entityName,
//                                                     entityId: item.entityId,
//                                                     absoluteValue: absoluteValue,
//                                                     absoluteDailyChange: absoluteDailyChange)
//                        }
//                        return nil
//                    }
//
//                    //Yauheni
//                    //get pie settings
//                    //if no - fill with current data
//                    let interests = data.filter({$0.entityType == "interest"}).compactMap({InfoDataSource.init(type: .Interst, id: Int($0.entityId ?? "") ?? 0,  title:$0.entityName ?? "", iconURL:"", selected: false)})
//                    let categories = data.filter({$0.entityType == "category"}).compactMap({InfoDataSource.init(type: .Category, id: Int($0.entityId ?? "") ?? 0,  title:$0.entityName ?? "", iconURL:"", selected: false)})
//                    let secTypes = data.filter({$0.entityType == "security_type"}).compactMap({InfoDataSource.init(type: .SecurityType, id: Int($0.entityId ?? "") ?? 0,  title:$0.entityName ?? "", iconURL:"", selected: false)})
//                    //else take same and filter by settings
//                    //HoldingsViewModel l.153
//                    self.pieChartDataFilteredSorted = [PieChartData]()
//                    self.collectionView.reloadData()
//                    self.pieChartData = data
//                    self.reloadData()
//
//                } else {
//                    self.pieChartDataFilteredSorted = [PieChartData]()
//                    self.reloadData()
//                }
//
//                break
//            case .failure(let error):
//                dprint("Failure when making GetPortfolioPieChartQuery request. Error: \(error)")
//                self.pieChartDataFilteredSorted = [PieChartData]()
//                self.reloadData()
//                break
//            }
//            dprint("\(Date()) PieChart for Porto load end")
//        }
//    }
    
    private func setupPanel() {
        fpc = FloatingPanelController()
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 16.0
        appearance.backgroundColor = .clear
        fpc.surfaceView.appearance = appearance
        fpc.delegate = self // Optional
    }
    
    private func showSortingPanel() {
        guard let userID = profileToUse else {
            return
        }
        guard let settings = PiePortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let layout = MyFloatingPanelLayout()
        
        fpc.layout = layout
        sortingVC.delegate = self
        sortingVC.isDemoProfile = self.isDemoProfile
        sortingTickersVC.delegate = self
        sortingTickersVC.isDemoProfile = self.isDemoProfile
        
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
            headerView.isDemoProfile = isDemoProfile
            guard let userID = profileToUse else {
                return headerView
            }
            guard let settings = PiePortfolioSettingsManager.shared.getSettingByUserID(userID) else {
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
                PiePortfolioSettingsManager.shared.changePieChartModeForUserId(userID, pieChartMode: .tickers)
                self.reloadData()
            }
            
            headerView.onChartCategoryButtonPressed = {
                PiePortfolioSettingsManager.shared.changePieChartModeForUserId(userID, pieChartMode: .categories)
                self.reloadData()
            }
            
            headerView.onChartInterestButtonPressed = {
                PiePortfolioSettingsManager.shared.changePieChartModeForUserId(userID, pieChartMode: .interests)
                self.reloadData()
            }
            
            headerView.onChartSecurityTypeButtonPressed = {
                PiePortfolioSettingsManager.shared.changePieChartModeForUserId(userID, pieChartMode: .securityType)
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
