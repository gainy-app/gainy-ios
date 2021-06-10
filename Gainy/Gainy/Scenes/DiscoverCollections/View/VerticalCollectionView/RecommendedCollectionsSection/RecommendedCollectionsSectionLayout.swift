import UIKit

struct RecommendedCollectionsSectionLayout: SectionLayout {
    // MARK: Internal

    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let recommendedItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        // Group
        let recommendedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(144)
            ),
            subitem: recommendedItem,
            count: Constant.numberOfColumns
        )
        recommendedGroup.interItemSpacing = .fixed(8)

        // Section
        let recommendedCollectionsSection = NSCollectionLayoutSection(group: recommendedGroup)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(64)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        recommendedCollectionsSection.boundarySupplementaryItems = [sectionHeader]
        recommendedCollectionsSection.interGroupSpacing = 8
        recommendedCollectionsSection.contentInsets = NSDirectionalEdgeInsets(
            top: 16.0,
            leading: 16.0,
            bottom: 28.0,
            trailing: 16.0
        )

        return recommendedCollectionsSection
    }

    func header(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable
    ) -> UICollectionReusableView? {
        let headerView: RecommendedCollectionsHeaderView =
            collectionView.dequeueReusableSectionHeader(for: indexPath)

        if let viewModel = viewModel as? CollectionHeaderViewModel {
            headerView.configureWith(
                title: viewModel.title,
                description: viewModel.description
            )
        }

        return headerView
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: RecommendedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if let viewModel = viewModel as? RecommendedCollectionViewCellModel {
            let buttonState: RecommendedCellButtonState = viewModel.isInYourCollections
                ? .checked
                : .unchecked

            cell.configureWith(
                name: viewModel.name,
                description: viewModel.description,
                stocksAmount: viewModel.stocksAmount,
                imageName: viewModel.image,
                plusButtonState: buttonState
            )
        }

        return cell
    }

    // MARK: Private

    private enum Constant {
        static let numberOfColumns = 3
    }
}
