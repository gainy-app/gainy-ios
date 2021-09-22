struct CollectionCardViewCellModel {
    let tickerCompanyName: String
    let tickerSymbol: String
    let priceChange: String
    let tickerPrice: String
    let dividendGrowthPercent: String
    let growthRateYOY: String
    let evs: String
    let marketCap: String
    let monthToDay: String
    let netProfit: String
    let highlight: String
    
    let rawTicker: RemoteTickerDetails
}

extension CollectionCardViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tickerSymbol)
    }

    static func == (lhs: CollectionCardViewCellModel, rhs: CollectionCardViewCellModel) -> Bool {
        lhs.tickerSymbol == rhs.tickerSymbol
    }
}
