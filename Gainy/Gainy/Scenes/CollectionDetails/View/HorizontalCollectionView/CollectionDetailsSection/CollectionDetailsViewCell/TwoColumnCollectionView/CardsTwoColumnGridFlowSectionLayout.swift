import UIKit

struct CardsTwoColumnGridFlowSectionLayout: SectionLayout {
    // TODO: 1: remove/replace with proper layout
    func layoutSection(within environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let layoutItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        layoutItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 5,
            bottom: 0,
            trailing: 5
        )

        // Group
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .estimated(1000)
            ),
            subitems: [layoutItem]
        )

        // Section
        let collectionsFlowSection = NSCollectionLayoutSection(group: layoutGroup)
        collectionsFlowSection.orthogonalScrollingBehavior = .groupPagingCentered

        return collectionsFlowSection
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: CollectionCardCell =
            collectionView.dequeueReusableCell(for: indexPath)

        if let viewModel = viewModel as? CollectionCardViewCellModel {
            cell.configureWith(
                companyName: viewModel.tickerCompanyName,
                tickerSymbol: viewModel.tickerSymbol,
                tickerPercentChange: viewModel.priceChange,
                tickerPrice: viewModel.tickerPrice,
                markerMetricFirst: viewModel.dividendGrowthPercent,
                marketMetricSecond: viewModel.priceToEarnings,
                marketMetricThird: viewModel.marketCapitalization,
                highlight: viewModel.highlight
            )
        }

        return cell
    }
}
