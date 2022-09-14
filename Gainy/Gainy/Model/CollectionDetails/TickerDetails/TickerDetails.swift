import GainyAPI

struct TickerDetails {
    let tickerSymbol: String
    let companyName: String
    let description: String
    let financialMetrics: TickerFinancialMetrics
    let tickerMetrics: TickerMetricsData
    let rawTicker: RemoteTickerDetails
}

extension TickerDetails: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tickerSymbol)
    }

    static func == (lhs: TickerDetails, rhs: TickerDetails) -> Bool {
        lhs.tickerSymbol == rhs.tickerSymbol
    }
}
