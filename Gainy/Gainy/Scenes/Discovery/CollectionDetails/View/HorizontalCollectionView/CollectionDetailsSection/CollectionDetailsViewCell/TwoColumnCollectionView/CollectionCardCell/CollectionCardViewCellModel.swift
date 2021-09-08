struct CollectionCardViewCellModel {
    let tickerCompanyName: String
    let tickerSymbol: String
    let priceChange: String
    let tickerPrice: String
    let dividendGrowthPercent: String
    let priceToEarnings: String
    let marketCapitalization: String
    let highlight: String
    let rawTicker: DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker
}

extension CollectionCardViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tickerSymbol)
    }

    static func == (lhs: CollectionCardViewCellModel, rhs: CollectionCardViewCellModel) -> Bool {
        lhs.tickerSymbol == rhs.tickerSymbol
    }
}
