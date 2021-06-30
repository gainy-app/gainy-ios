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
