//
//  HorizontalCompareFlowSectionLayout.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.11.2021.
//

import UIKit

struct HorizontalCompareFlowSectionLayout: SectionLayout {
    func layoutSection(within environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let topItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        // Group
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(environment.container.contentSize.width - (8 + 4 + 4 + 8)),
                heightDimension: .estimated(environment.container.contentSize.height)
            ),
            subitems: [topItem]
        )
        
        // Section
        let collectionsFlowSection = NSCollectionLayoutSection(
            group: group
        )

        collectionsFlowSection.orthogonalScrollingBehavior = .groupPagingCentered
        collectionsFlowSection.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.1
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.alpha = scale
            }
        }
        collectionsFlowSection.contentInsets = .zero
        return collectionsFlowSection
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: CollectionDetailsViewCell =
            collectionView.dequeueReusableCell(for: indexPath)

        cell.isCompare = true
        if let viewModel = viewModel as? CollectionDetailViewCellModel {
            cell.configureWith(
                name: viewModel.name,
                image: viewModel.image,
                imageUrl: viewModel.imageUrl,
                description: viewModel.description,
                stocksAmount: viewModel.stocksAmount,
                cards: viewModel.cards,
                collectionId: viewModel.id
            )
        }

        return cell
    }
}

