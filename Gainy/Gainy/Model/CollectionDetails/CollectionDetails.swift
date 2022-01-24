struct CollectionDetails {
    let id: Int
    let collectionBackgroundImage: String
    let collectionBackgroundImageUrl: String
    let collectionName: String
    let collectionDescription: String
    let collectionStocksAmount: Int
    let isInYourCollectionsList: Bool
    var cards: [TickerDetails]
    
    mutating func insertCards(_ newCards: [TickerDetails]) {
        cards.append(contentsOf: newCards)
    }
    
    mutating func clearCards() {
        cards.removeAll()
    }
}

extension CollectionDetails: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isInYourCollectionsList)
    }

    static func == (lhs: CollectionDetails, rhs: CollectionDetails) -> Bool {
        lhs.id == rhs.id && lhs.isInYourCollectionsList == rhs.isInYourCollectionsList
    }
}
