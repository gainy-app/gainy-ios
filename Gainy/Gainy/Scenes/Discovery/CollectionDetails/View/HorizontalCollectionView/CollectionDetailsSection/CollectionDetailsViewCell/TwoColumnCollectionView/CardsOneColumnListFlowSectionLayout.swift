//
//  CardsOneColumnListFlowSectionLayout.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit

struct CardsOneColumnListFlowSectionLayout: SectionLayout {
    
    let collectionID: Int
    
    // TODO: 1: remove/replace with proper layout
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let gridItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        gridItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )

        // Groups
        let horizontalTwoItemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(60)
            ),
            subitem: gridItem,
            count: 1
        )
        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 4, bottom: 0, trailing: 4
        )

        horizontalTwoItemsGroup.interItemSpacing = .fixed(0)

        // Section
        let twoColumnsGridSection = NSCollectionLayoutSection(
            group: horizontalTwoItemsGroup
        )
        twoColumnsGridSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )

        return twoColumnsGridSection
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: CollectionListCardCell =
            collectionView.dequeueReusableCell(for: indexPath)
        
        if let viewModel = viewModel as? CollectionCardViewCellModel {
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionID)
            let markers = settings.marketDataToShow.prefix(5)
            var vals: [String] = []
            for marker in markers {
                switch marker {
                case .dividendGrowth:
                    vals.append(viewModel.dividendGrowthPercent)
                case .evs:
                    vals.append(viewModel.evs)
                case .marketCap:
                    vals.append(viewModel.marketCap)
                case .monthToDay:
                    vals.append(viewModel.monthToDay)
                case .netProfit:
                    vals.append(viewModel.netProfit)
                case .growsRateYOY:
                    vals.append(viewModel.growthRateYOY)
                }
            }            
                       
            cell.configureWith(
                companyName: viewModel.tickerCompanyName,
                tickerSymbol: viewModel.tickerSymbol,
                tickerPercentChange: viewModel.priceChange,
                tickerPrice: viewModel.tickerPrice,
                markerHeaders: markers.map(\.shortTitle),
                markerMetrics: vals
            )
        }

        return cell
    }
}
