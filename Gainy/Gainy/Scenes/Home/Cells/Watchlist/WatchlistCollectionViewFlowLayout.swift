//
//  HomeCollectionsFlowLayout.swift
//  Gainy
//
//  Created by Anton Gubarenko on 05.03.2022.
//

import UIKit

struct WatchlistCollectionViewFlowLayout {
    
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let gridItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        gridItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 16, bottom: 8, trailing: 16
        )

        // Groups
        let horizontalTwoItemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(88 + 8)
            ),
            subitem: gridItem,
            count: 1
        )
        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )

        horizontalTwoItemsGroup.interItemSpacing = .fixed(8)

        // Section
        let twoColumnsGridSection = NSCollectionLayoutSection(
            group: horizontalTwoItemsGroup
        )
        twoColumnsGridSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )

        return twoColumnsGridSection
    }
}
