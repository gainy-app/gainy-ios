import UIKit

struct YourCollectionsSectionLayout: SectionLayout {
    var layoutSection: NSCollectionLayoutSection = {
        // Items
        let discoveryItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(88)
            )
        )

        // Group
        let discoveredGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(88 + 8)
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
                heightDimension: .absolute(70)
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
