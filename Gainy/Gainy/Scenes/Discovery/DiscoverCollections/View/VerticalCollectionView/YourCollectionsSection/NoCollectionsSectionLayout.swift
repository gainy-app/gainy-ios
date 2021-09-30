import UIKit

struct NoCollectionsSectionLayout: SectionLayout {
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
                heightDimension: .absolute(92) // original is 88
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

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: YourCollectionTipCell =
            collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
}
