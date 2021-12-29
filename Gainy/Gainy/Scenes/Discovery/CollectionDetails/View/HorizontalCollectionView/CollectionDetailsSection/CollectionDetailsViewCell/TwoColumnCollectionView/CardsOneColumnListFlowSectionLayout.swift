//
//  CardsOneColumnListFlowSectionLayout.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit

struct CardsOneColumnListFlowSectionLayout: SectionLayout {
    
    let collectionID: Int
    
    // TODO: 1: remove/replace with proper layout
    func layoutSection(within _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // Items
        let gridItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )

        gridItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )

        // Groups
        let horizontalTwoItemsGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(73)
            ),
            subitem: gridItem,
            count: 1
        )
        horizontalTwoItemsGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 4, bottom: 0, trailing: 4
        )

        horizontalTwoItemsGroup.interItemSpacing = .fixed(0)

        // Section
        let twoColumnsGridSection = NSCollectionLayoutSection(
            group: horizontalTwoItemsGroup
        )
        twoColumnsGridSection.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 0, bottom: 0, trailing: 0
        )

        return twoColumnsGridSection
    }

    func configureCell(
        collectionView: UICollectionView,
        indexPath: IndexPath,
        viewModel: AnyHashable,
        position _: Int
    ) -> UICollectionViewCell {
        let cell: CollectionListCardCell =
            collectionView.dequeueReusableCell(for: indexPath)
        
        if let viewModel = viewModel as? CollectionCardViewCellModel {
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionID)
            let markers = settings.marketDataToShow.prefix(5)
            var vals: [String] = []
            for marker in markers {
                switch marker {
                case .matchScore:
                    vals.append(viewModel.matchScore)
                case .sharesOutstanding:
                    vals.append(viewModel.sharesOutstanding)
                case .shortPercentOutstanding:
                    vals.append(viewModel.shortPercentOutstanding)
                case .avgVolume90d:
                    vals.append(viewModel.avgVolume90d)
                case .sharesFloat:
                    vals.append(viewModel.sharesFloat)
                case .shortRatio:
                    vals.append(viewModel.shortRatio)
                case .beta:
                    vals.append(viewModel.beta)
                case .impliedVolatility:
                    vals.append(viewModel.impliedVolatility)
                case .volatility52Weeks:
                    vals.append(viewModel.volatility52Weeks)
                case .revenueGrowthFwd:
                    vals.append(viewModel.revenueGrowthFwd)
                case .ebitdaGrowthYoy:
                    vals.append(viewModel.ebitdaGrowthYoy)
                case .epsGrowthYoy:
                    vals.append(viewModel.epsGrowthYoy)
                case .epsGrowthFwd:
                    vals.append(viewModel.epsGrowthFwd)
                case .address:
                    vals.append(viewModel.address)
                case .marketCapitalization:
                    vals.append(viewModel.marketCapitalization)
                case .enterpriseValueToSales:
                    vals.append(viewModel.enterpriseValueToSales)
                case .priceToEarningsTtm:
                    vals.append(viewModel.priceToEarningsTtm)
                case .priceToSalesTtm:
                    vals.append(viewModel.priceToSalesTtm)
                case .priceToBookValue:
                    vals.append(viewModel.priceToBookValue)
                case .enterpriseValueToEbitda:
                    vals.append(viewModel.enterpriseValueToEbitda)
                case .priceChange1m:
                    vals.append(viewModel.priceChange1m)
                case .priceChange3m:
                    vals.append(viewModel.priceChange3m)
                case .priceChange1y:
                    vals.append(viewModel.priceChange1y)
                case .dividendYield:
                    vals.append(viewModel.dividendYield)
                case .dividendsPerShare:
                    vals.append(viewModel.dividendsPerShare)
                case .dividendPayoutRatio:
                    vals.append(viewModel.dividendPayoutRatio)
                case .yearsOfConsecutiveDividendGrowth:
                    vals.append(viewModel.yearsOfConsecutiveDividendGrowth)
                case .dividendFrequency:
                    vals.append(viewModel.dividendFrequency)
                case .epsActual:
                    vals.append(viewModel.epsActual)
                case .epsEstimate:
                    vals.append(viewModel.epsEstimate)
                case .beatenQuarterlyEpsEstimationCountTtm:
                    vals.append(viewModel.beatenQuarterlyEpsEstimationCountTtm)
                case .epsSurprise:
                    vals.append(viewModel.epsSurprise)
                case .revenueEstimateAvg0y:
                    vals.append(viewModel.revenueEstimateAvg0y)
                case .revenueActual:
                    vals.append(viewModel.revenueActual)
                case .revenueTtm:
                    vals.append(viewModel.revenueTtm)
                case .revenuePerShareTtm:
                    vals.append(viewModel.revenuePerShareTtm)
                case .roi:
                    vals.append(viewModel.roi)
                case .netIncome:
                    vals.append(viewModel.netIncome)
                case .assetCashAndEquivalents:
                    vals.append(viewModel.assetCashAndEquivalents)
                case .roa:
                    vals.append(viewModel.roa)
                case .totalAssets:
                    vals.append(viewModel.totalAssets)
                case .ebitda:
                    vals.append(viewModel.ebitda)
                case .profitMargin:
                    vals.append(viewModel.profitMargin)
                case .netDebt:
                    vals.append(viewModel.netDebt)
                case .avgVolume10d:
                    vals.append(viewModel.avgVolume10d)
                case .revenueGrowthYoy:
                    vals.append(viewModel.revenueGrowthYoy)
                case .exchangeName:
                    vals.append(viewModel.exchangeName)
                }
            }            
                       
            cell.configureWith(
                companyName: viewModel.tickerCompanyName,
                tickerSymbol: viewModel.tickerSymbol,
                tickerPercentChange: viewModel.priceChangeToday > 0.0 ? " +" + viewModel.priceChangeToday.percentRaw : viewModel.priceChangeToday.percentRaw,
                tickerPrice: viewModel.currentPrice.cleanTwoDecimal,
                markerHeaders: markers.map(\.shortTitle),
                markerMetrics: vals,
                matchScore: viewModel.matchScore
            )
        }

        return cell
    }
}
