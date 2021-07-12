import UIKit

struct MarketDataHorizontalSectionLayout: SectionLayout {
    // TODO: 1: remove/replace with proper layout
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let gridItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.33),
                heightDimension: .fractionalHeight(1)
            )
        )

//        gridItem.contentInsets = NSDirectionalEdgeInsets(
//            top: 16, leading: 0, bottom: 0, trailing: 0
//        )

        // Groups
        let horizontalTwoItemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(96)
            ),
            subitem: gridItem,
            count: 3
        )
//        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
//            top: 0, leading: 4, bottom: 0, trailing: 4
//        )

        horizontalTwoItemsGroup.interItemSpacing = .fixed(8)

        // Section
        let twoColumnsGridSection = NSCollectionLayoutSection(
            group: horizontalTwoItemsGroup
        )
        twoColumnsGridSection.interGroupSpacing = 8
        twoColumnsGridSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 16, bottom: 0, trailing: 16
        )

        return twoColumnsGridSection
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: HightlightViewCell =
            collectionView.dequeueReusableCell(for: indexPath)

        cell.configureWith(titleEmoji: "🚀",
                           highlightText: "Industry has a huge upside with WFH. Dividend yeild and growth 2x faster industry.")

//        if let viewModel = viewModel as? CollectionCardViewCellModel {
//        }

        return cell
    }
}
