import UIKit

struct YourCollectionsSectionLayout: SectionLayout {
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
                heightDimension: .estimated(92)
            ),
            subitems: [yourCollectionItem]
        )

        // Section
        let yourCollectionsSection = NSCollectionLayoutSection(group: yourCollectionGroup)
        yourCollectionsSection.interGroupSpacing = 8
        yourCollectionsSection.contentInsets = NSDirectionalEdgeInsets(
            top: 16.0,
            leading: 16.0,
            bottom: 32.0,
            trailing: 16.0
        )

        return yourCollectionsSection
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
        let cell: YourCollectionViewCell =
            collectionView.dequeueReusableCell(for: indexPath)

        if let viewModel = viewModel as? YourCollectionViewCellModel {
            cell.configureWith(name: viewModel.name,
                               imageUrl: viewModel.imageUrl,
                               description: viewModel.description,
                               stocksAmount: viewModel.stocksAmount,
                               matchScore: viewModel.matchScore,
                               dailyGrow: viewModel.dailyGrow,
                               imageName: viewModel.image)
        }

        return cell
    }
}
