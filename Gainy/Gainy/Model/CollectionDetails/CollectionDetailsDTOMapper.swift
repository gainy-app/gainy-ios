enum CollectionDetailsDTOMapper {
    static func mapAsCollectionFromRecommendedCollections(
        _ dto: CollectionDetailsQuery.Data.AppCollection
    ) -> CollectionDetails {
        CollectionDetails(
            id: dto.id,
            collectionBackgroundImage: dto.name.lowercased(),
            collectionName: dto.name,
            collectionDescription: dto.description ?? "",
            collectionStocksAmount: dto.collectionSymbolsAggregate.aggregate?.count ?? 0,
            isInYourCollectionsList: false,
            cards: dto.collectionSymbols.map {
                CollectionDetailsDTOMapper.mapTickerDetails(
                    $0
                )
            }
        )
    }

    static func mapAsCollectionFromYourCollections(
        _ dto: CollectionDetailsQuery.Data.AppCollection
    ) -> CollectionDetails {
        CollectionDetails(
            id: dto.id,
            collectionBackgroundImage: dto.name.lowercased(),
            collectionName: dto.name,
            collectionDescription: dto.description ?? "",
            collectionStocksAmount: dto.collectionSymbolsAggregate.aggregate?.count ?? 0,
            isInYourCollectionsList: true,
            cards: dto.collectionSymbols.map {
                CollectionDetailsDTOMapper.mapTickerDetails(
                    $0
                )
            }
        )
    }

    static func mapTickerDetails(
        _ dto: CollectionDetailsQuery
            .Data
            .AppCollection
            .CollectionSymbol
    ) -> TickerDetails {
        TickerDetails(
            tickerSymbol: dto.ticker.symbol ?? "",
            companyName: dto.ticker.name ?? "",
            description: dto.ticker.description ?? "",
            financialMetrics: CollectionDetailsDTOMapper.mapFinancialMetrics(
                dto.ticker.tickerFinancials.first!
            )
        )
    }

    static func mapFinancialMetrics(
        _ dto: CollectionDetailsQuery
            .Data
            .AppCollection
            .CollectionSymbol
            .Ticker
            .TickerFinancial
    ) -> TickerFinancialMetrics {
        TickerFinancialMetrics(
            todaysPriceChange: Float(dto.priceChangeToday ?? 0.0),
            currentPrice: dto.currentPrice ?? 0.0,
            dividendGrowthPercent: Float(dto.dividentGrowth ?? 0.0),
            priceToEarnings: Float(dto.peRatio ?? 0.0),
            marketCapitalization: Float(dto.marketCapitalization ?? 0.0),
            highlight: dto.highlight ?? "Highlighted text info"
        )
    }
}
