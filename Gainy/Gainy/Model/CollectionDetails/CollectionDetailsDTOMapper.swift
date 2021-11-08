enum CollectionDetailsDTOMapper {
    static func mapAsCollectionFromRecommendedCollections(
        _ dto: RemoteCollectionDetails
    ) -> CollectionDetails {
        CollectionDetails(
            id: dto.id ?? -1,
            collectionBackgroundImage: dto.name?.lowercased() ?? "", collectionBackgroundImageUrl: dto.imageUrl ?? "",
            collectionName: dto.name ?? "",
            collectionDescription: dto.description ?? "",
            collectionStocksAmount: dto.tickerCollectionsAggregate.aggregate?.count ?? 0,
            isInYourCollectionsList: false,
            cards: dto.tickerCollections.compactMap {
                if let remoteTickerDetails = $0.ticker?.fragments.remoteTickerDetails {
                return CollectionDetailsDTOMapper.mapTickerDetails(
                    remoteTickerDetails
                )
                } else {
                    return nil
                }
            }
        )
    }

    static func mapAsCollectionFromYourCollections(
        _ dto: RemoteCollectionDetails
    ) -> CollectionDetails {
        CollectionDetails(
            id: dto.id ?? -1,
            collectionBackgroundImage: dto.name?.lowercased() ?? "", collectionBackgroundImageUrl: dto.imageUrl ?? "",
            collectionName: dto.name ?? "",
            collectionDescription: dto.description ?? "",
            collectionStocksAmount: dto.tickerCollectionsAggregate.aggregate?.count ?? 0,
            isInYourCollectionsList: true,
            cards: dto.tickerCollections.compactMap {
                if let remoteTickerDetails = $0.ticker?.fragments.remoteTickerDetails {
                return CollectionDetailsDTOMapper.mapTickerDetails(
                    remoteTickerDetails
                )
                } else {
                    dprint("Missing ticker: \(dto.name ?? "")")
                    return nil
                }
            }
        )
    }

    static func mapTickerDetails(
        _ dto: RemoteTickerDetails
    ) -> TickerDetails {
        let tickerFinancials = dto.tickerFinancials.first
        return TickerDetails(
            tickerSymbol: dto.symbol ?? "",
            companyName: dto.name ?? "",
            description: dto.description ?? "",
            financialMetrics: tickerFinancials != nil ? CollectionDetailsDTOMapper.mapFinancialMetrics(
                tickerFinancials!
            ) : TickerFinancialMetrics.init(todaysPriceChange: 0.0, currentPrice: 0.0, dividendGrowthPercent: 0.0, priceToEarnings: 0.0, marketCapitalization: 0.0, evs: 0.0, growthRateYOY: 0.0, monthToDay: 0.0, netProfit: 0.0, highlight: "ERROR"),
            rawTicker: dto
        )
    }

    static func mapFinancialMetrics(
        _ dto: RemoteTickerDetails.TickerFinancial
    ) -> TickerFinancialMetrics {
        TickerFinancialMetrics(
            todaysPriceChange: Float(dto.priceChangeToday),
            currentPrice: dto.currentPrice,
            dividendGrowthPercent: Float(dto.dividendGrowth ?? 0.0),
            priceToEarnings: Float(dto.peRatio ?? 0.0),
            marketCapitalization: Float(dto.marketCapitalization ?? 0.0),
            evs: Float(dto.enterpriseValueToSales ?? 0.0),
            growthRateYOY: Float(dto.quarterlyRevenueGrowthYoy ?? 0.0) * 100.0,
            monthToDay: Float(dto.monthPricePerformance ?? 0.0),
            netProfit : Float(dto.netProfitMargin ?? 0.0),
            highlight: dto.highlight ?? ""
        )
    }
}
