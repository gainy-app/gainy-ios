struct CollectionDetailViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: String
    let inYourCollectionList: Bool
    let cards: [CollectionCardViewCellModel]
}

extension CollectionDetailViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(inYourCollectionList)
    }

    static func == (lhs: CollectionDetailViewCellModel, rhs: CollectionDetailViewCellModel) -> Bool {
        lhs.id == rhs.id && lhs.inYourCollectionList == rhs.inYourCollectionList
    }
}
