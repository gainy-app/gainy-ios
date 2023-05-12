//
//  DiscoveryGridDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.05.2023.
//

import Foundation
import GainyCommon

protocol DiscoveryGridItemActionable: AnyObject {
    //Old collections
    func addToYourCollection(collectionItemToAdd: RecommendedCollectionViewCellModel, category: DiscoverySectionInfo?)
    func removeFromYourCollection(itemId: Int, yourCollectionItemToRemove: YourCollectionViewCellModel, category: DiscoverySectionInfo?)
    func openCollection(collection: RecommendedCollectionViewCellModel, category: DiscoverySectionInfo?)
    func showMore(collections: [RecommendedCollectionViewCellModel], category: DiscoverySectionInfo)
    
    //Banner
    func bannerClosePressed()
    func bannerRequestPressed()
    
    //Info
    func infoPressed(category: DiscoverySectionInfo)
}

final class DiscoveryGridDataSource: NSObject {
    weak var delegate: DiscoveryGridItemActionable?
    
    var recommendedCollections: [RecommendedCollectionViewCellModel] = []
}

extension DiscoveryGridDataSource: UICollectionViewDataSource {
    
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
            self?.delegate?.addToYourCollection(collectionItemToAdd: modelItem, category: nil)
            
            cell.isUserInteractionEnabled = true
            GainyAnalytics.logEvent("add_to_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
            
                GainyAnalytics.logEvent("ttf_added_to_wl", params: ["af_content_id" : modelItem.id, "af_content_type" : "ttf"])
                GainyAnalytics.logEventAMP("ttf_added_to_wl", params: ["collectionID" : modelItem.id, "action" : "plus", "isFirstSaved" : UserProfileManager.shared.favoriteCollections.isEmpty ? "true" : "false", "isFromSearch" : "false", "category" : "all"])
                
                if UserProfileManager.shared.favoriteCollections.isEmpty && AnalyticsKeysHelper.shared.initialTTFFlag {
                    GainyAnalytics.logEventAMP("first_ttf_added", params: ["collectionID" : modelItem.id, "action" : "plus"])
                    AnalyticsKeysHelper.shared.initialTTFFlag = false
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
            self?.delegate?.removeFromYourCollection(itemId: modelItem.id, yourCollectionItemToRemove: yourCollectionItem, category: nil)
            
            cell.isUserInteractionEnabled = true
            GainyAnalytics.logEvent("remove_from_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
            GainyAnalytics.logEventAMP("ttf_removed_from_wl", params: ["collectionID" : modelItem.id, "action" : "unplus", "isFirstSaved" : UserProfileManager.shared.favoriteCollections.isEmpty ? "true" : "false", "isFromSearch" : "false"])
        }
        return cell
    }

}

extension DiscoveryGridDataSource: UICollectionViewDelegateFlowLayout {
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

extension DiscoveryGridDataSource: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView,
                            didSelectItemAt indexPath: IndexPath) {
            let recColl = self.recommendedCollections[indexPath.row]
            delegate?.openCollection(collection: recColl, category: nil)
        }
}
