struct CollectionDetailViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: String
    let cards: [CollectionCardViewCellModel]
}

extension CollectionDetailViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(stocksAmount)
    }

    static func == (lhs: CollectionDetailViewCellModel, rhs: CollectionDetailViewCellModel) -> Bool {
        lhs.id == rhs.id && lhs.stocksAmount == rhs.stocksAmount
    }
}

struct CollectionCardViewCellModel {
    let tickerCompanyName: String
    let tickerSymbol: String
    let priceChange: String
    let tickerPrice: String
    let dividendGrowthPercent: String
    let priceToEarnings: String
    let marketCapitalization: String
    let highlight: String
}

extension CollectionCardViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(tickerSymbol)
    }

    static func == (lhs: CollectionCardViewCellModel, rhs: CollectionCardViewCellModel) -> Bool {
        lhs.tickerSymbol == rhs.tickerSymbol
    }
}
