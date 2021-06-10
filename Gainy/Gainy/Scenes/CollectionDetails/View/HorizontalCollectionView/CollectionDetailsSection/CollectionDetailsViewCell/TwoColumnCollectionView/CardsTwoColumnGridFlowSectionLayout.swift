import UIKit

struct CardsTwoColumnGridFlowSectionLayout: SectionLayout {
    // TODO: 1: remove/replace with proper layout
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let gridItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1)
            )
        )

        gridItem.contentInsets = NSDirectionalEdgeInsets(
            top: 16, leading: 0, bottom: 0, trailing: 0
        )

        // Groups
        let horizontalTwoItemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(216 + 16)
            ),
            subitem: gridItem,
            count: 2
        )
        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 6, bottom: 0, trailing: 6
        )

        horizontalTwoItemsGroup.interItemSpacing = .fixed(15)

        // Section
        let twoColumnsGridSection = NSCollectionLayoutSection(
            group: horizontalTwoItemsGroup
        )
        twoColumnsGridSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 13, trailing: 0
        )

        return twoColumnsGridSection
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
