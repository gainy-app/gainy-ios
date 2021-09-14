enum CollectionDetailsDTOMapper {
    static func mapAsCollectionFromRecommendedCollections(
        _ dto: DiscoverCollectionDetailsQuery.Data.Collection
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
                    $0
                )
            }
        )
    }

    static func mapAsCollectionFromYourCollections(
        _ dto: DiscoverCollectionDetailsQuery.Data.Collection
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
                    $0
                )
            }
        )
    }

    static func mapTickerDetails(
        _ dto: DiscoverCollectionDetailsQuery
            .Data
            .Collection
            .TickerCollection
    ) -> TickerDetails {
        TickerDetails(
            tickerSymbol: dto.ticker?.symbol ?? "",
            companyName: dto.ticker?.name ?? "",
            description: dto.ticker?.description ?? "",
            financialMetrics: CollectionDetailsDTOMapper.mapFinancialMetrics(
                (dto.ticker?.tickerFinancials.first)!
            ),
            rawTicker: dto.ticker ?? nil
        )
    }

    static func mapFinancialMetrics(
        _ dto: DiscoverCollectionDetailsQuery
            .Data
            .Collection
            .TickerCollection
            .Ticker
            .TickerFinancial
    ) -> TickerFinancialMetrics {
        TickerFinancialMetrics(
            todaysPriceChange: Float(dto.priceChangeToday),
            currentPrice: dto.currentPrice,
            dividendGrowthPercent: Float(dto.dividendGrowth ?? 0.0),
            priceToEarnings: Float(dto.peRatio ?? 0.0),
            marketCapitalization: Float(dto.marketCapitalization ?? 0.0),
            evs: Float(dto.enterpriseValueToSales ?? "0.0") ?? 0.0,
            growthRateYOY: Float(dto.marketCapCagr_1years ?? 0.0),
            monthToDay: Float(dto.sma_30days ?? 0.0),
            netProfit : Float(dto.netProfitMargin ?? 0.0),
            highlight: dto.highlight ?? "Highlighted text missing"
        )
    }
}
