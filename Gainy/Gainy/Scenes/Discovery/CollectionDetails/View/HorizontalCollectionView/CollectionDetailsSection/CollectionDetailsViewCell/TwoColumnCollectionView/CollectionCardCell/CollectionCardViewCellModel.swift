struct CollectionCardViewCellModel {
    let tickerCompanyName: String
    let tickerSymbol: String
    
    let sharesOutstanding: String
    let shortPercentOutstanding: String
    let avgVolume10d: String
    let avgVolume90d: String
    let sharesFloat: String
    let shortRatio: String
    let beta: String
    let impliedVolatility : String
    let volatility52Weeks: String
    let revenueGrowthYoy: String
    let revenueGrowthFwd: String
    let ebitdaGrowthYoy: String
    let epsGrowthYoy: String
    let epsGrowthFwd: String
    let address: String
    let exchangeName: String
    let marketCapitalization: String
    let enterpriseValueToSales: String
    let priceToEarningsTtm: String
    let priceToSalesTtm: String
    let priceToBookValue: String
    let enterpriseValueToEbitda: String
    let priceChange1m: String
    let priceChange3m: String
    let priceChange1y: String
    let dividendYield: String
    let dividendsPerShare: String
    let dividendPayoutRatio: String
    let yearsOfConsecutiveDividendGrowth: String
    let dividendFrequency: String
    let epsActual: String
    let epsEstimate: String
    let beatenQuarterlyEpsEstimationCountTtm: String
    let epsSurprise: String
    let revenueEstimateAvg0y: String
    let revenueActual: String
    let revenueTtm: String
    let revenuePerShareTtm: String
    let roi: String
    let netIncome: String
    let assetCashAndEquivalents: String
    let roa: String
    let totalAssets: String
    let ebitda: String
    let profitMargin: String
    let netDebt: String
    
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

extension CollectionCardViewCellModel: RemoteMatchable {
    var matchScore: String {
        "\(TickerLiveStorage.shared.getMatchData(tickerSymbol)?.matchScore ?? 0)"
    }
    
//    var isMatch: Bool {
//        TickerLiveStorage.shared.getMatchData(tickerSymbol)?.isMatch ?? false
//    }
}
