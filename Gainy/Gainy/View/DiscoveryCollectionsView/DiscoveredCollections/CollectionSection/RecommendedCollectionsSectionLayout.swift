import UIKit

struct RecommendedCollectionsSectionLayout: SectionLayout {
    private enum Constant {
        static let numberOfColumns = 3
    }

    var layoutSection: NSCollectionLayoutSection = {
        // Items
        let recommendedItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / CGFloat(Constant.numberOfColumns)),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        recommendedItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0.0,
            leading: 4.0,
            bottom: 0.0,
            trailing: 4.0
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
        recommendedGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 8.0,
            leading: 14.0,
            bottom: 0.0,
            trailing: 14.0
        )

        let section = NSCollectionLayoutSection(group: recommendedGroup)
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

    func header(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView? {
        let headerView: DiscoveredCollectionsHeaderView = collectionView.dequeueReusableSectionHeader(for: indexPath)

        headerView.configureWith(
            title: "Collections you might like",
            description: "Tap on collection for preview, or tap on plus icon to add to your discovery"
        )

        return headerView
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        item: AnyHashable,
        position: Int
    ) -> UICollectionViewCell {
        let cell: RecommendedCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if let viewModel = item as? RecommendedCollectionViewCellModel {
            cell.configureWith(name: viewModel.name,
                               description: viewModel.description,
                               stocksAmount: viewModel.stocksAmount,
                               imageName: viewModel.image,
                               plusButtonState: viewModel.buttonState)
        }

        return cell
    }
}
