import UIKit

class YourCollectionsSectionLayout: SectionLayout {
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
                               description: viewModel.description,
                               stocksAmount: viewModel.stocksAmount,
                               imageName: viewModel.image)
        }

        cell.delegate = self

        return cell
    }
}

extension YourCollectionsSectionLayout: SwipeCollectionViewCellDelegate {
    func collectionView(
        _: UICollectionView,
        editActionsForItemAt _: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .default) { _, _ in }
        deleteAction.image = UIImage(named: "trash")

        return [deleteAction]
    }
}
