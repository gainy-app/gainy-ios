import UIKit

struct YourCollectionsSectionLayout: SectionLayout {
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let recommendedItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalWidth(0.5)
            )
        )

        // Group
        let recommendedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.5)
            ),
            subitem: recommendedItem,
            count: 2
        )
        recommendedGroup.interItemSpacing = .fixed(16)

        // Section
        let recommendedCollectionsSection = NSCollectionLayoutSection(group: recommendedGroup)
        recommendedCollectionsSection.interGroupSpacing = 8
        recommendedCollectionsSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16.0,
            bottom: 0,
            trailing: 16.0
        )

        return recommendedCollectionsSection
    }

    func header(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable
    ) -> UICollectionReusableView? {
        let headerView: YourCollectionsHeaderView =
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
        let cell: SquareYourCollectionViewCell =
            collectionView.dequeueReusableCell(for: indexPath)

        if let viewModel = viewModel as? YourCollectionViewCellModel {
            cell.configureWith(name: viewModel.name,
                               imageUrl: viewModel.imageUrl,
                               description: viewModel.description,
                               stocksAmount: viewModel.stocksAmount,
                               matchScore: viewModel.matchScore,
                               dailyGrow: viewModel.dailyGrow,
                               imageName: viewModel.image,
                               plusButtonState: .checked)
        }

        return cell
    }
}
