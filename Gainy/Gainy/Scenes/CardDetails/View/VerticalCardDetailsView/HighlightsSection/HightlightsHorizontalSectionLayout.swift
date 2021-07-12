import UIKit

struct HightlightsHorizontalSectionLayout: SectionLayout {
    // TODO: 1: remove/replace with proper layout
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let gridItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

//        gridItem.contentInsets = NSDirectionalEdgeInsets(
//            top: 16, leading: 0, bottom: 0, trailing: 0
//        )

        // Groups
        let horizontalTwoItemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(240),
                heightDimension: .absolute(136)
            ),
            subitems: [gridItem]
        )
//        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
//            top: 0, leading: 4, bottom: 0, trailing: 4
//        )

//        horizontalTwoItemsGroup.interItemSpacing = .fixed(15)

        // Section
        let twoColumnsGridSection = NSCollectionLayoutSection(
            group: horizontalTwoItemsGroup
        )

        let highlightsHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(68)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        twoColumnsGridSection.boundarySupplementaryItems = [highlightsHeader]

        twoColumnsGridSection.interGroupSpacing = 12
        twoColumnsGridSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 16, bottom: 0, trailing: 16
        )

        twoColumnsGridSection.orthogonalScrollingBehavior = .groupPaging

        return twoColumnsGridSection
    }

    func header(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable
    ) -> UICollectionReusableView? {
        let headerView: HighlightHeaderView =
            collectionView.dequeueReusableSectionHeader(for: indexPath)

//        if let viewModel = viewModel as? CollectionHeaderViewModel {
            headerView.configureWith(
                title: "Highlights" // TODO: update viewModel.title
            )
//        }

        return headerView
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
