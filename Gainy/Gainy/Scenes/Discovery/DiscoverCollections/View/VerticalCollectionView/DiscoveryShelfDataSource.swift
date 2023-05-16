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
    
    fileprivate let colHeight: CGFloat = (UIScreen.main.bounds.width - 16.0 * 3.0) / 2.0
    
    var isBannerHidden: Bool = false
    
    //MARK: - Shelfs
    
    private(set) var shelfs: [DiscoverySectionInfo : [RecommendedCollectionViewCellModel]] = [:]
    
    private let maxH = 18
    private let maxV = 18
    
    func updateRecent() {
        let recentCols = RecentViewedManager.shared.recent.compactMap({$0.ttf})
        if !recentCols.isEmpty {
            shelfs[.recent] = recentCols
        } else {
            shelfs[.recent] = nil
        }
    }
    
    func updateCollections(_ recColls: [RecommendedCollectionViewCellModel], shelfCols: [DiscoverySectionCollection] = []) {
        guard let userID = UserProfileManager.shared.profileID else {
            shelfs.removeAll()
            return
        }
        let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(userID)
        let period = settings.performancePeriod
        
        updateRecent()
        
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
        var list = Array(topUp.prefix(maxV))
        if list.isEmpty {
            shelfs[.topUp] = nil
        } else {
            shelfs[.topUp] = list
        }
        
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
        list = Array(topDown.prefix(maxV))
        if list.isEmpty {
            shelfs[.topDown] = nil
        } else {
            shelfs[.topDown] = list
        }
        
        if UserProfileManager.shared.isOnboarded {
            let msUp = recColls.sorted(by: { leftCol, rightCol in
                leftCol.matchScore > rightCol.matchScore
            })
            list = Array(msUp.prefix(maxV))
            if list.isEmpty {
                shelfs[.bestMatch] = nil
            } else {
                shelfs[.bestMatch] = list
            }
        } else {
            shelfs[.bestMatch] = []
        }
        
        //Shelfs split
        let bears = shelfCols.filter({ $0.discoverySection == .bear })
            .sorted(by: {$0.position ?? 0 < $1.position ?? 0})
            .compactMap({$0.collection?.fragments.remoteShortCollectionDetails})
            .compactMap({CollectionViewModelMapper.mapFromShort($0)})
            .sorted(by: { leftCol, rightCol in
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
        if bears.isEmpty {
            shelfs[.bear] = nil
        } else {
            shelfs[.bear] = bears
        }
        
        let flats = shelfCols.filter({ $0.discoverySection == .flat })
            .sorted(by: {$0.position ?? 0 < $1.position ?? 0})
            .compactMap({$0.collection?.fragments.remoteShortCollectionDetails})
            .compactMap({CollectionViewModelMapper.mapFromShort($0)})
            .sorted(by: { leftCol, rightCol in
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
        if flats.isEmpty {
            shelfs[.flat] = nil
        } else {
            shelfs[.flat] = flats
        }
        
        let bulls = shelfCols.filter({ $0.discoverySection == .bull })
            .sorted(by: {$0.position ?? 0 < $1.position ?? 0})
            .compactMap({$0.collection?.fragments.remoteShortCollectionDetails})
            .compactMap({CollectionViewModelMapper.mapFromShort($0)})
            .sorted(by: { leftCol, rightCol in
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
        if bulls.isEmpty {
            shelfs[.bull] = nil
        } else {
            shelfs[.bull] = bulls
        }
        
        shelfs[.banner] = []
    }
}

extension DiscoveryShelfDataSource: UICollectionViewDataSource {
    
    var sections: [DiscoverySectionInfo] {
        Array(shelfs.keys).sorted(by: {$0.rawValue < $1.rawValue})
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let type = sections[indexPath.section]
        
        guard type != .banner else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendShelfBannerViewCell.reuseIdentifier, for: indexPath) as! RecommendShelfBannerViewCell
            cell.delegate = delegate
            cell.isHidden = isBannerHidden
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedShelfViewCell.reuseIdentifier, for: indexPath) as? RecommendedShelfViewCell else { return UICollectionViewCell() }
        
        switch type {
        case .recent:
            let cols = shelfs[type] ?? []
            cell.configureWith(type: type, collections: Array(cols.prefix(maxH)), moreToShow: max(cols.count - maxH, 0))
            break
        case .bestMatch:
            if UserProfileManager.shared.isOnboarded {
                let cols = shelfs[type] ?? []
                cell.configureWith(type: type, collections: Array(cols.prefix(maxH)), moreToShow: max(cols.count - maxH, 0))
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendMSBannerViewCell.reuseIdentifier, for: indexPath) as! RecommendMSBannerViewCell
                cell.delegate = delegate
                return cell
            }
            break
        default:
            let cols = shelfs[type] ?? []
            cell.configureWith(type: type, collections: Array(cols.prefix(maxH)), moreToShow: max(cols.count - maxH, 0))
            break
        }
        cell.delegate = delegate
        return cell
    }

}

extension DiscoveryShelfDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = colHeight + 16.0 + 24.0
        let type = sections[indexPath.section]
        
        switch type {
        case .banner:
            return isBannerHidden ? .zero : CGSize.init(width: collectionView.bounds.width, height: 136.0)
        case .bestMatch:
            if UserProfileManager.shared.isOnboarded {
                let cols = shelfs[type] ?? []
                return CGSize.init(width: collectionView.bounds.width, height: size)
            } else {
                return CGSize.init(width: collectionView.bounds.width, height: 136.0)
            }
        default:
            let cols = shelfs[type] ?? []
            return CGSize.init(width: collectionView.bounds.width, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let type = sections[section]
        let isBanner = type == .banner
        if type == .bestMatch {
            if UserProfileManager.shared.isOnboarded {
                return UIEdgeInsets.init(top: 0, left: 0, bottom: 32.0, right: 0)
            } else {
                return UIEdgeInsets.init(top: 8, left: 0, bottom: 16, right: 0)
            }
        }
        return UIEdgeInsets.init(top: isBanner ? 16 : 0, left: 0, bottom: 32.0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
