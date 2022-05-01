//
//  GainersCollectionSectionLayout.swift
//  Gainy
//
//  Created by Anton Gubarenko on 01.05.2022.
//

import UIKit

struct GainersCollectionSectionLayout: SectionLayout {
    let isGainers: Bool
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let yourCollectionItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        // Group
        let yourCollectionGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(144)
            ),
            subitems: [yourCollectionItem]
        )
        
        // Section
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(40 + 16 + 24)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let yourCollectionsSection = NSCollectionLayoutSection(group: yourCollectionGroup)
        yourCollectionsSection.boundarySupplementaryItems = [sectionHeader]
        yourCollectionsSection.interGroupSpacing = 8
        yourCollectionsSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return yourCollectionsSection
    }
    
    
    func header(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable
    ) -> UICollectionReusableView? {
        let headerView: GainersHeaderView =
        collectionView.dequeueReusableSectionHeader(for: indexPath)
        
        headerView.configureWith(
            title: isGainers ? "Top gainers in your TTF" : "Top losers in your TTF"
        )
        
        return headerView
    }
    
    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: HomeTickersCollectionViewCell =
        collectionView.dequeueReusableCell(for: indexPath)
        
        if let viewModel = viewModel as? HomeTickersCollectionViewCellModel {
            if viewModel.isGainers {
                cell.gainers = viewModel.gainers
            } else {
                cell.gainers = viewModel.gainers
            }
        }
        
        return cell
    }
}
