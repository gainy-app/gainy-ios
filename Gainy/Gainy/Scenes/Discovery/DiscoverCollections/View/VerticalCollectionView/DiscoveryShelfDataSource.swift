//
//  DiscoveryShelfDataSource.swift
//  Gainy
//
//  Created by Anton Gubarenko on 02.05.2023.
//

import UIKit
import GainyCommon

final class DiscoveryShelfDataSource: NSObject {
    weak var delegate: DiscoveryGridItemActionable?
    
    enum Cell: Int {
        case recent, topUp, topDown, bestMatch, banner, market, bull, flat, bear
        
        var title: String {
            switch self {
            case .recent:
                return "Recently viewed"
            case .topUp:
                return "Top Performers"
            case .topDown:
                return "Top Losers"
            case .bestMatch:
                return "Best Match"
            case .banner:
                return ""
            case .market:
                return "Gainy’s 6 months market view"
            case .bull:
                return "Bull scenario"
            case .flat:
                return "Flat scenario"
            case .bear:
                return "Bear Scenario"
            }
        }
    }
    
    fileprivate let colHeight: CGFloat = (UIScreen.main.bounds.width - 16.0 * 3.0) / 2.0
    
    var isBannerHidden: Bool = false
    
    //MARK: - Shelfs
    
    private var shelfs: [Cell : [RecommendedCollectionViewCellModel]] = [:]
    
    func updateCollections(_ recColls: [RecommendedCollectionViewCellModel]) {
        guard let userID = UserProfileManager.shared.profileID else {
            shelfs.removeAll()
            return
        }
        let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(userID)
        let sorting = settings.sorting
        let period = settings.performancePeriod
        
        let topUp = recColls.sorted(by: { leftCol, rightCol in
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
        })
        shelfs[.topUp] = topUp
        let topDown = recColls.sorted(by: { leftCol, rightCol in
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
        })
        shelfs[.topDown] = topDown
    }
}

extension DiscoveryShelfDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cell.bear.rawValue + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = Cell.init(rawValue: indexPath.row) else {return UICollectionViewCell() }
        
        guard type != .banner else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendShelfBannerViewCell.reuseIdentifier, for: indexPath) as! RecommendShelfBannerViewCell
            cell.delegate = delegate
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedShelfViewCell.reuseIdentifier, for: indexPath) as? RecommendedShelfViewCell else { return UICollectionViewCell() }
        
        switch type {
        case .banner:
            cell.isHidden = isBannerHidden
            break
        case .market:
            cell.configureAsHeaderOnly(name: type.title)
            cell.isHidden = false
        default:
            let cols = shelfs[type] ?? []
            cell.configureWith(name: type.title, collections: Array(cols.prefix(8)), moreToShow: max(cols.count - 8, 0))
            cell.isHidden = cols.isEmpty
        }
        cell.delegate = delegate
        return cell
    }

}

extension DiscoveryShelfDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = colHeight + 16.0 + 24.0
        guard let type = Cell.init(rawValue: indexPath.row) else {return CGSize.init(width: collectionView.bounds.width, height: size)}
        
        switch type {
        case .banner:
            return isBannerHidden ? .zero : CGSize.init(width: collectionView.bounds.width, height: 136.0)
        case .market:
            return CGSize.init(width: collectionView.bounds.width, height: 24.0)
        default:
            let cols = shelfs[type] ?? []
            return cols.isEmpty ? .zero : CGSize.init(width: collectionView.bounds.width, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return section == 0 ? 0.0 : 32.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }
}
