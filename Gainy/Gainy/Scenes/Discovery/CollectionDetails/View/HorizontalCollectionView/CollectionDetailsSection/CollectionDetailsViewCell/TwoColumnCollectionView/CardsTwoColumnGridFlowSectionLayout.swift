import UIKit

struct CardsTwoColumnGridFlowSectionLayout: SectionLayout {
    
    let collectionID: Int
    
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
                heightDimension: .absolute(232 + 16)
            ),
            subitem: gridItem,
            count: 2
        )
        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 4, bottom: 0, trailing: 4
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

        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionID)
        let markers = settings.marketDataToShow.prefix(3)
                
        if let viewModel = viewModel as? CollectionCardViewCellModel {
            
            var vals: [String] = []
            for marker in markers {
                switch marker {
                case .dividendGrowth:
                    vals.append(viewModel.dividendGrowthPercent)
                case .evs:
                    vals.append(viewModel.evs)
                case .marketCap:
                    vals.append(viewModel.marketCap)
                case .monthToDay:
                    vals.append(viewModel.monthToDay)
                case .netProfit:
                    vals.append(viewModel.netProfit)
                case .growsRateYOY:
                    vals.append(viewModel.growthRateYOY)
                case .matchScore:
                    vals.append(viewModel.matchScore)
                }
            }
            
            cell.configureWith(
                companyName: viewModel.tickerCompanyName,
                tickerSymbol: viewModel.tickerSymbol,
                tickerPercentChange: viewModel.priceChangeToday > 0.0 ? " +" + viewModel.priceChangeToday.percentRaw : viewModel.priceChangeToday.percentRaw,
                tickerPrice:  viewModel.currentPrice > 0.0 ? viewModel.currentPrice.cleanTwoDecimal: "",
                markerMetricHeaders: markers.map(\.shortTitle),
                markerMetric: vals,
                highlight: viewModel.highlight,
                matchScore: viewModel.matchScore,
                isMatch: viewModel.isMatch
            )
        }

        return cell
    }
}
