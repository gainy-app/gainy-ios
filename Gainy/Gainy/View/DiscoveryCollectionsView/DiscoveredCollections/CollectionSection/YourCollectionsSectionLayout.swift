import UIKit

struct YourCollectionsSectionLayout: SectionLayout {
    var layoutSection: NSCollectionLayoutSection = {
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
                heightDimension: .absolute(92) // original is 88
            ),
            subitems: [yourCollectionItem]
        )

        let yourCollectionsSection = NSCollectionLayoutSection(group: yourCollectionGroup)
        let yourCollectionsHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(74)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        yourCollectionsSection.boundarySupplementaryItems = [yourCollectionsHeader]
        yourCollectionsSection.interGroupSpacing = 8
        yourCollectionsSection.contentInsets = NSDirectionalEdgeInsets(
            top: 16.0,
            leading: 16.0,
            bottom: 32.0,
            trailing: 16.0
        )

        return yourCollectionsSection
    }()

    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let headerView: YourCollectionsHeaderView = collectionView.dequeueReusableSectionHeader(for: indexPath)

        headerView.configureWith(
            title: "Your collections",
            description: "Tap to view, swipe to edit or drag & drop to reorder"
        )
        return headerView
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: YourCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if let viewModel = item as? YourCollectionViewCellModel {
            cell.configureWith(name: viewModel.name,
                               description: viewModel.description,
                               stocksAmount: viewModel.stocksAmount,
                               imageName: viewModel.image)
        }

        return cell
    }
}
