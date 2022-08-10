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

final class HoldingsPieChartViewController: BaseViewController {
    
    public var onSortingPressed: (() -> Void)?
    public var onSettingsPressed: (() -> Void)?
    
    private var pieChartData: [PieChartData] = []
    private(set) var collectionView: DetectableCollectionView!
    private lazy var refreshControl: LottieRefreshControl = {
        let control = LottieRefreshControl()
        control.layer.zPosition = -1
        control.clipsToBounds = true
        control.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return control
    } ()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.clipsToBounds = false
        self.view.isUserInteractionEnabled = true
        
        let layout = UICollectionViewFlowLayout.init()
        collectionView = DetectableCollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
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
        loadChartData()
    }
    
    @objc func refresh(_ sender:AnyObject) {

        self.loadChartData()
    }
    
    public func loadChartData() {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            dprint("Missing profileID")
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(profileID) else {
            return
        }
        
        dprint("\(Date()) PieChart for Porto load start")
        let accessTokenIds = UserProfileManager.shared.linkedPlaidAccounts.compactMap { item -> Int? in
            let disabled = settings.disabledAccounts.contains { account in
                item.id == account.id
            }
            return disabled ? nil : item.id
        }
        
        view.showAnimatedGradientSkeleton()
        let query = GetPortfolioPieChartQuery.init(profileId: profileID, accessTokenIds: accessTokenIds)
        Network.shared.apollo.fetch(query: query) {result in
            self.view.hideSkeleton()
            self.refreshControl.endRefreshing()
            switch result {
            case .success(let graphQLResult):
                if let fetchedData = graphQLResult.data?.getPortfolioPiechart {
                    let data = fetchedData.compactMap { item -> PieChartData? in
                        
                        if let item = item {
                            let weight = (item.weight != nil) ? float8(item.weight!) : nil
                            let relativeDailyChange = (item.relativeDailyChange != nil) ? float8(item.relativeDailyChange!) : float8(0)
                            let absoluteValue = (item.absoluteValue != nil) ? float8(item.absoluteValue!) : nil
                            let absoluteDailyChange = (item.absoluteDailyChange != nil) ? float8(item.absoluteDailyChange!) : nil
                            return PieChartData.init(weight: weight,
                                                     entityType: item.entityType,
                                                     relativeDailyChange: relativeDailyChange,
                                                     entityName: item.entityName,
                                                     entityId: item.entityId,
                                                     absoluteValue: absoluteValue,
                                                     absoluteDailyChange: absoluteDailyChange)
                        }
                        return nil
                    }
                    self.pieChartData = [PieChartData]()
                    self.collectionView.reloadData()
                    self.pieChartData = data
                    self.collectionView.reloadData()
                    
                } else {
                    self.pieChartData = [PieChartData]()
                    self.collectionView.reloadData()
                }
                
                break
            case .failure(let error):
                dprint("Failure when making GetPortfolioPieChartQuery request. Error: \(error)")
                self.pieChartData = [PieChartData]()
                self.collectionView.reloadData()
                break
            }
            dprint("\(Date()) PieChart for Porto load end")
        }
    }
}


// MARK: UICollectionViewDataSource

extension HoldingsPieChartViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.currentChartData().count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return self.chartCardCellForItemAtIndexPath(indexPath: indexPath)
    }
    
    func chartCardCellForItemAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionChartCardCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionChartCardCell.cellIdentifier, for: indexPath) as! CollectionChartCardCell
        let chartData = self.currentChartData()
        guard indexPath.row < chartData.count else {
            return cell
        }
        
        cell.configureWithChartData(data: chartData[indexPath.row], index: indexPath.row, customTickerLayout: false)
        cell.removeBlur()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HoldingPieChartCollectionHeaderView.reuseIdentifier, for: indexPath) as! HoldingPieChartCollectionHeaderView
            
            guard let userID = UserProfileManager.shared.profileID else {
                return headerView
            }
            guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
                return headerView
            }
            
            let pieChartSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(-42)
            
            headerView.backgroundColor = self.view.backgroundColor
            headerView.configureWithPieChartData(pieChartData: self.currentChartData(), mode: pieChartSettings.pieChartMode)
            headerView.updateChargeLbl(settings.sortingText())

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                headerView.setNeedsLayout()
                headerView.layoutIfNeeded()
            })
            
            headerView.onSettingsPressed = {
                self.onSettingsPressed?()
            }
            
            headerView.onSortingPressed = {
                self.onSortingPressed?()
            }
            
            headerView.onChartTickerButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(-42, pieChartMode: .tickers)
                self.collectionView.reloadData()
            }
            
            headerView.onChartCategoryButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(-42, pieChartMode: .categories)
                self.collectionView.reloadData()
            }
            
            headerView.onChartInterestButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(-42, pieChartMode: .interests)
                self.collectionView.reloadData()
            }
            
            headerView.onChartSecurityTypeButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(-42, pieChartMode: .securityType)
                self.collectionView.reloadData()
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
    
    func currentChartData() -> [PieChartData] {
        
        guard let profileID = UserProfileManager.shared.profileID else {
            dprint("Missing profileID")
            return []
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(profileID) else {
            return []
        }
        
        let selectedInterests = settings.interests.filter { item in
            item.selected
        }
        let selectedCategories = settings.categories.filter { item in
            item.selected
        }
        let selectedSecurityTypes = settings.securityTypes.filter { item in
            item.selected
        }
        
        let pieChartSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(-42)
        var chartData: [PieChartData] = []
        if pieChartSettings.pieChartMode == .categories {
            chartData = self.pieChartData.filter { data in
                data.entityType == "category" && (selectedCategories.isEmpty || selectedCategories.contains(where: { selectedItem in
                    selectedItem.title.lowercased() == data.entityName?.lowercased() ?? ""
                }))
            }
        } else if pieChartSettings.pieChartMode == .interests {
            chartData = self.pieChartData.filter { data in
                data.entityType == "interest" && (selectedInterests.isEmpty || selectedInterests.contains(where: { selectedItem in
                    selectedItem.title.lowercased() == data.entityName?.lowercased() ?? ""
                }))
            }
        } else if pieChartSettings.pieChartMode == .tickers {
            chartData = self.pieChartData.filter { data in
                data.entityType == "ticker"
            }
        } else if pieChartSettings.pieChartMode == .securityType {
            chartData = self.pieChartData.filter { data in
                data.entityType == "security_type" && (selectedSecurityTypes.isEmpty || selectedSecurityTypes.contains(where: { selectedItem in
                    selectedItem.title.lowercased() == data.entityName?.lowercased() ?? ""
                }))
            }
        }
        
        if settings.sorting == .name {
            chartData = chartData.sorted(by: { itemLeft, itemRight in
                if settings.ascending {
                    return itemLeft.entityName ?? "" > itemRight.entityName ?? ""
                } else {
                    return itemLeft.entityName ?? "" <= itemRight.entityName ?? ""
                }
            })
        } else {
            chartData = chartData.sorted(by: { itemLeft, itemRight in
                if settings.ascending {
                    return itemLeft.weight ?? 0.0 > itemRight.weight ?? 0.0
                } else {
                    return itemLeft.weight ?? 0.0 <= itemRight.weight ?? 0.0
                }
            })
        }
        
        return chartData
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
