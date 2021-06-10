// TODO: 1: avoid force unwraps in the mappers

enum CollectionDetailsDTOMapper {
    static func map(
        _ dto: CollectionDetailsQuery.Data.Collection
    ) -> CollectionDetails {
        CollectionDetails(
            id: Int(dto.id)!,
            collectionBackgroundImage: dto.name.lowercased(),
            collectionName: dto.name,
            collectionDescription: dto.description,
            collectionStocksAmount: Int(dto.stocksCount)!,
            cards: dto.collectionTickersSymbols.map {
                CollectionDetailsDTOMapper.mapTickerDetails(
                    $0
                )
            }
        )
    }

    static func mapTickerDetails(
        _ dto: CollectionDetailsQuery
            .Data
            .Collection
            .CollectionTickersSymbol
    ) -> TickerDetails {
        TickerDetails(
            tickerSymbol: dto.ticker.symbol,
            companyName: dto.ticker.name,
            description: dto.ticker.description,
            financialMetrics: CollectionDetailsDTOMapper.mapFinancialMetrics(
                dto.ticker.tickerFinancials.first!
            )
        )
    }

    static func mapFinancialMetrics(
        _ dto: CollectionDetailsQuery
            .Data
            .Collection
            .CollectionTickersSymbol
            .Ticker
            .TickerFinancial
    ) -> TickerFinancialMetrics {
        TickerFinancialMetrics(
            todaysPriceChange: Float(dto.priceChangeToday),
            currentPrice: Float(dto.currentPrice),
            dividendGrowthPercent: Int(dto.dividendGrowth)!,
            priceToEarnings: Float(dto.priceToEarnings),
            marketCapitalization: Int64(dto.marketCap)!,
            highlight: dto.highlight
        )
    }
}
