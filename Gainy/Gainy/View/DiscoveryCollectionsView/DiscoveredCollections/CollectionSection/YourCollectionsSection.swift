import UIKit

struct YourCollectionsSection: LayoutSection {
    var layoutSection: NSCollectionLayoutSection = {
        // Items
        let discoveryItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        // Group
        let discoveredGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(88)
            ),
            subitems: [discoveryItem]
        )
        discoveredGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0.0,
            leading: 16.0,
            bottom: 8.0,
            trailing: 16.0
        )

        let section = NSCollectionLayoutSection(group: discoveredGroup)
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(70)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0.0,
            leading: 0.0,
            bottom: 12.0,
            trailing: 0.0
        )

        return section
    }()

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: AnyHashable,
        position: Int
    ) -> UICollectionViewCell {
        let cell: DiscoveredCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if let collection = item as? Collection {
            cell.configureWith(name: collection.name,
                               description: collection.description,
                               stocksAmount: collection.stocksAmount,
                               imageName: collection.image)
        }

        return cell

    }
}
