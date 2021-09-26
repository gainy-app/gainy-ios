struct CollectionCardViewCellModel {
    let tickerCompanyName: String
    let tickerSymbol: String
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

extension CollectionCardViewCellModel: RemotePricable {
    var currentPrice: Float {
        TickerLiveStorage.shared.getSymbolData(tickerSymbol)?.currentPrice ?? 0.0
    }
    
    var priceChangeToday: Float {
        TickerLiveStorage.shared.getSymbolData(tickerSymbol)?.priceChangeToday ?? 0.0
    }
}
