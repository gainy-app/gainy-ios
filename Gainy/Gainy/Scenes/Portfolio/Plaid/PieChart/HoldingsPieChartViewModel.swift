//
//  HoldingsPieChartViewModel.swift
//  Gainy
//
//  Created by r10 on 14.02.2023.
//

import Foundation
import GainyCommon
import GainyAPI
import Combine

protocol HoldingsPieChartViewModelActionPerformer: AnyObject {
    func reloadCollection()
}

class HoldingsPieChartViewModel {
    
    // MARK: - Private Properties
    private var netrowkModel: HoldingPieChartNetworking = .init()
    private var settingsManager: PiePortfolioSettingsManager = .shared
    private let userProfileManager = UserProfileManager.shared
    
    weak var actionPerformer: HoldingsPieChartViewModelActionPerformer?
    
    var isLoading = false
    var isDemoProfile: Bool = false
    var profileToUse: Int? {
        if isDemoProfile {
            return Constants.Plaid.demoProfileID
        } else {
            return UserProfileManager.shared.profileID
        }
    }
    
    private var pieChartData: [PieChartData] = []
    var pieChartDataFilteredSorted: [PieChartData] = [] {
        didSet {
            actionPerformer?.reloadCollection()
        }
    }
    
    // MARK: - LifeCycle
    
    func loadFilters() async {
        isLoading = true
        await getPieFilters()
    }
    
    func reloadData() async {
        isLoading = true
        await loadChartData()
    }
    
    func getPieFilters() async {
        guard let profileToUse else { return }
        do {
            let filters = try await netrowkModel.loadPieFilters(profileID: profileToUse, selectedIds: [])
            updateSettings(filters: filters)
            isLoading = false
        } catch {
            isLoading = false
        }
    }
    
    func loadChartData() async {
        guard let profileToUse,
              let settings = settingsManager.getSettingByUserID(profileToUse) else { return }
        
        let brokerUniqIds = userProfileManager.linkedBrokerAccounts.compactMap { item -> String? in
            let disabled = settings.disabledAccounts.contains { account in
                item.id == account.id
            }
            return disabled ? nil : item.brokerUniqId
        }
        
        let intrs = settings.interests.filter({ $0.selected }).map(\.id)
        let cats = settings.categories.filter({ $0.selected }).map(\.id)

        do {
            let pieChartData = try await netrowkModel.loadChartData(
                profileID: profileToUse,
                brokerIds: UserProfileManager.shared.linkedBrokerAccounts.count == brokerUniqIds.count ? nil : brokerUniqIds,
                interestIds: intrs.isEmpty ? nil : intrs,
                categoryIds: cats.isEmpty ? nil : cats)
            
            self.pieChartData = pieChartData
            filterAndSortPieChartData()
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
    
    private func updateSettings(filters: (interests: [InfoDataSource], categories: [InfoDataSource])) {
        guard let profileToUse else { return }
        var settings = settingsManager.getSettingByUserID(profileToUse)
        let pieChartSorting: [PieChartMode : PortfolioSortingField] = [
            .securityType : .weight,
            .tickers : .weight,
            .categories : .weight,
            .interests : .weight,
            .collections : .weight
        ]
        let pieChartAscending: [PieChartMode : Bool] = [
            .securityType : false,
            .tickers : false,
            .categories : false,
            .interests : false,
            .collections : false
        ]
        let defaultSettings = PortfolioSettings.init(sorting: .matchScore,
                                                     pieChartSorting: pieChartSorting,
                                                     pieChartAscending: pieChartAscending,
                                                     pieChartMode: .categories,
                                                     ascending: false,
                                                     includeClosedPositions: true,
                                                     onlyLongCapitalGainTax: false,
                                                     interests: filters.interests,
                                                     categories: filters.categories,
                                                     securityTypes: [],
                                                     disabledAccounts: [])
        if settings == nil {
            settingsManager.setInitialSettingsForUserId(profileToUse, settings: defaultSettings)
            settings = defaultSettings
        } else {
            settingsManager.changeInterestsForUserId(profileToUse, interests: filters.interests)
            settingsManager.changeCategoriesForUserId(profileToUse, categories: filters.categories)
        }
    }
}
 
extension HoldingsPieChartViewModel {
    func filterAndSortPieChartData() {
        guard let profileID = profileToUse else {
            dprint("Missing profileID")
            return
        }
        guard let settings = settingsManager.getSettingByUserID(profileID) else {
            return
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
        
        var chartData: [PieChartData] = []
        if settings.pieChartMode == .categories {
            chartData = self.pieChartData.filter { data in
                data.entityType == "category" && (selectedCategories.isEmpty || selectedCategories.contains(where: { selectedItem in
                    selectedItem.title.lowercased() == data.entityName?.lowercased() ?? ""
                }))
            }
        } else if settings.pieChartMode == .interests {
            chartData = self.pieChartData.filter { data in
                data.entityType == "interest" && (selectedInterests.isEmpty || selectedInterests.contains(where: { selectedItem in
                    selectedItem.title.lowercased() == data.entityName?.lowercased() ?? ""
                }))
            }
        } else if settings.pieChartMode == .tickers {
            chartData = self.pieChartData.filter { data in
                data.entityType == "asset"
            }
        } else if settings.pieChartMode == .securityType {
            chartData = self.pieChartData.filter { data in
                data.entityType == "security_type" && (selectedSecurityTypes.isEmpty || selectedSecurityTypes.contains(where: { selectedItem in
                    selectedItem.title.lowercased() == data.entityName?.lowercased() ?? ""
                }))
            }
        }
        
        let sorting = settings.sortingValue(mode: settings.pieChartMode)
        let ascending = settings.ascending(mode: settings.pieChartMode)
        print(chartData.compactMap({$0.entityId}).contains("COST"))
        chartData = chartData.sorted {  itemLeft, itemRight in
            switch sorting {
            case .name:
                if ascending {
                    return itemLeft.entityName ?? "" < itemRight.entityName ?? ""
                } else {
                    return itemLeft.entityName ?? "" > itemRight.entityName ?? ""
                }
            case .weight:
                if ascending {
                    return itemLeft.weight ?? 0.0 < itemRight.weight ?? 0.0
                } else {
                    return itemLeft.weight ?? 0.0 > itemRight.weight ?? 0.0
                }
            default:
                return false
            }
        }
        
        self.pieChartDataFilteredSorted = chartData
    }
}
