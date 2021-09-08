struct TickerDetails {
    let tickerSymbol: String
    let companyName: String
    let description: String
    let financialMetrics: TickerFinancialMetrics
    let rawTicker: DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker?
}

extension TickerDetails: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tickerSymbol)
    }

    static func == (lhs: TickerDetails, rhs: TickerDetails) -> Bool {
        lhs.tickerSymbol == rhs.tickerSymbol
    }
}
