struct CollectionDetails {
    let id: Int
    let collectionBackgroundImage: String
    let collectionName: String
    let collectionDescription: String
    let collectionStocksAmount: Int
    let cards: [TickerDetails]
}

extension CollectionDetails: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: CollectionDetails, rhs: CollectionDetails) -> Bool {
        lhs.id == rhs.id
    }
}
