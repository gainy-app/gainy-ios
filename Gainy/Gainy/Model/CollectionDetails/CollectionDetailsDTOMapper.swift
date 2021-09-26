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
            cards: dto.tickerCollections.map {
                CollectionDetailsDTOMapper.mapTickerDetails(
                    $0.ticker
                )
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
            cards: dto.tickerCollections.map {
                CollectionDetailsDTOMapper.mapTickerDetails(
                    $0.ticker
                )
            }
        )
    }

    static func mapTickerDetails(
        _ dto: RemoteCollectionDetails.TickerCollection.Ticker?
    ) -> TickerDetails {
        let tickerFinancials = dto?.fragments.remoteTickerDetails.tickerFinancials.first
        return TickerDetails(
            tickerSymbol: dto?.fragments.remoteTickerDetails.symbol ?? "",
            companyName: dto?.fragments.remoteTickerDetails.name ?? "",
            description: dto?.fragments.remoteTickerDetails.description ?? "",
            financialMetrics: tickerFinancials != nil ? CollectionDetailsDTOMapper.mapFinancialMetrics(
                tickerFinancials!
            ) : TickerFinancialMetrics.init(todaysPriceChange: 0.0, currentPrice: 0.0, dividendGrowthPercent: 0.0, priceToEarnings: 0.0, marketCapitalization: 0.0, evs: 0.0, growthRateYOY: 0.0, monthToDay: 0.0, netProfit: 0.0, highlight: "ERROR"),
            rawTicker: dto?.fragments.remoteTickerDetails ?? nil
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
            growthRateYOY: Float(dto.quarterlyRevenueGrowthYoy ?? 0.0),
            monthToDay: Float(dto.monthPricePerformance ?? 0.0),
            netProfit : Float(dto.netProfitMargin ?? 0.0),
            highlight: dto.highlight ?? ""
        )
    }
}
