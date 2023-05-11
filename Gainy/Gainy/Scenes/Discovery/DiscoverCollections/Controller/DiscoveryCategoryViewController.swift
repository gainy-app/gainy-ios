//
//  DiscoveryCategoryViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 29.04.2023.
//

import Foundation
import GainyCommon
import FloatingPanel
import SnapKit

protocol DiscoveryCategoryViewControllerDelegate: AnyObject {
    func collectionToggled(vc: DiscoveryCategoryViewController, isAdded: Bool, collectionID: Int)
}

final class DiscoveryCategoryViewController: BaseViewController {
    
    weak var coordinator: MainCoordinator?
    weak var delegate: DiscoveryCategoryViewControllerDelegate?
    
    lazy var filterHeaderView: RecommendedCollectionsHeaderView = {
        let header = RecommendedCollectionsHeaderView()
        header.viewMode = .grid
        header.delegate = self
        return header
    }()
    
    //Panel
    private var fpc: FloatingPanelController!
    private var shouldDismissFloatingPanel = false
    private var floatingPanelPreviousYPosition: CGFloat? = nil
    private lazy var sortingVS = SortDiscoveryViewController.instantiate(.popups)
    
    private var currentPage: Int = 1
    
    var category: DiscoverySectionInfo = .banner
    var categoryCollections: [RecommendedCollectionViewCellModel] = []
    private var recommendedCollections: [RecommendedCollectionViewCellModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = RemoteConfigManager.shared.mainBackColor
        
        let navigationBarContainer = UIView(
            frame: CGRect(
                x: 0,
                y: view.safeAreaInsets.top + 16,
                width: view.bounds.width,
                height: 40
            )
        )
        navigationBarContainer.backgroundColor = .clear
        let navigationBarTopOffset =
        navigationBarContainer.frame.origin.y + navigationBarContainer.bounds.height
        
        let closeBtn = UIButton(
            frame: CGRect(
                x: 16,
                y: 16,
                width: 32,
                height: 32
            )
        )
        
        closeBtn.setImage(UIImage(named: "iconClose"), for: .normal)
        closeBtn.addTarget(self,
                                            action: #selector(dismissAction),
                                            for: .touchUpInside)
        
        navigationBarContainer.addSubview(closeBtn)
        
        // Add the collection views and view to the stack view
        view.addSubview(navigationBarContainer)
        
        view.addSubview(filterHeaderView)
        filterHeaderView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalToSuperview().offset(navigationBarTopOffset + 16)
            make.height.equalTo(84.0)
        }
        
        view.addSubview(recCollectionView)
        recCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.top.equalTo(filterHeaderView.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        
        recCollectionView.dataSource = self
        recCollectionView.delegate = self
        
        view.bringSubviewToFront(navigationBarContainer)
        
        settingsManager = CategoryCollectionsSortingSettingsManager(category: category)
        self.setupPanel()
        filterHeaderView.settingsManager = settingsManager
        self.recommendedCollections = categoryCollections
    }

    private var settingsManager: SortingSettingsManagable!
        
    private let recCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RecommendedCollectionViewCell.self)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)
        return collectionView
    }()
    
    @objc func dismissAction() {
        dismiss(animated: true)
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
        sortingVS.settingsManager = settingsManager
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshAction()
    }
    
    @objc func refreshAction() {
        initViewModels()
    }
    
    private func initViewModels() {
        if let profileID = UserProfileManager.shared.profileID {
            let settings = settingsManager.getSettingByID(profileID)
            filterHeaderView.configureCategoryWith(title: category.title, description: "",
                                           sortLabelString: category.showSorting ? settings.sorting.title : nil,
                                           periodsHidden: false)
        }
        self.recommendedCollections = self.sortRecommendedCollections(recColls: categoryCollections)
        if category == .topUp || category == .topDown {
            self.recommendedCollections = Array(self.recommendedCollections.prefix(18))
        }
        self.recCollectionView.reloadData()
    }
    
    private func sortRecommendedCollections(recColls: [RecommendedCollectionViewCellModel]) -> [RecommendedCollectionViewCellModel] {
        
        guard let userID = UserProfileManager.shared.profileID else { return [] }
        let settings = settingsManager.getSettingByID(userID)
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
}

extension DiscoveryCategoryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collection = self.recommendedCollections
        return collection.count
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
            let settings = settingsManager.getSettingByID(userID)
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
            guard let self else {return}
            cell.isUserInteractionEnabled = false
            
            cell.setButtonChecked()
            self.delegate?.collectionToggled(vc: self, isAdded: true, collectionID: modelItem.id)
            cell.isUserInteractionEnabled = true
        }
        
        cell.onCheckButtonPressed = { [weak self] in
            guard let self else {return}
            cell.isUserInteractionEnabled = false
            
            cell.setButtonUnchecked()
            self.delegate?.collectionToggled(vc: self, isAdded: false, collectionID: modelItem.id)
            cell.isUserInteractionEnabled = true
        }
        return cell
    }

}

extension DiscoveryCategoryViewController: UICollectionViewDelegateFlowLayout {
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
}

extension DiscoveryCategoryViewController : SingleCollectionDetailsViewControllerDelegate {
    func collectionToggled(vc: SingleCollectionDetailsViewController, isAdded: Bool, collectionID: Int) {
        delegate?.collectionToggled(vc: self, isAdded: isAdded, collectionID: collectionID)
    }
    
    func collectionClosed(vc: SingleCollectionDetailsViewController, collectionID: Int) {
        
    }
}

extension DiscoveryCategoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
            let recColl = self.recommendedCollections[indexPath.row]
            AnalyticsKeysHelper.shared.ttfOpenSource = "discovery"
            coordinator?.showCollectionDetails(collectionID: recColl.id, delegate: self, haveNoFav: UserProfileManager.shared.favoriteCollections.isEmpty)
            GainyAnalytics.logEvent("recommended_collection_pressed", params: ["collectionID": UserProfileManager.shared.recommendedCollections[indexPath.row].id, "type" : "recommended", "ec" : "DiscoverCollections"])
    }
}

extension DiscoveryCategoryViewController: RecommendedCollectionsHeaderViewDelegate {
    func sortByTapped() {
        guard self.presentedViewController == nil else {return}
        GainyAnalytics.logEvent("disc_sort_tapped", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Discovery"])
        fpc.layout = SortRecCollectionsPanelLayout()
        self.fpc.set(contentViewController: sortingVS)
        self.present(self.fpc, animated: true, completion: nil)
    }
    
    func didChangePerformancePeriod(period: RecommendedCollectionsSortingSettings.PerformancePeriodField) {
        GainyAnalytics.logEvent("disc_period_changed", params: ["period": period.title])
        self.initViewModels()
    }
}

extension DiscoveryCategoryViewController: SortDiscoveryViewControllerDelegate {
    func selectionChanged(vc: SortDiscoveryViewController, sorting: RecommendedCollectionsSortingSettings.RecommendedCollectionSortingField, ascending: Bool) {
        GainyAnalytics.logEvent("disc_sort_changed", params: ["sortBy" : sorting, "isDescending": ascending ? "false" : "true"])
        self.fpc.dismiss(animated: true) {
            self.initViewModels()
        }
    }
}

extension DiscoveryCategoryViewController: FloatingPanelControllerDelegate {
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
