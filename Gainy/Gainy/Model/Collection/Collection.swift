struct Collection {
    let id: Int
    let image: String
    let imageUrl: String
    let name: String
    let description: String
    let stocksAmount: Int
    var isInYourCollections: Bool
}

extension Collection: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Collection, rhs: Collection) -> Bool {
        lhs.id == rhs.id
    }
}

extension Collection: Reorderable {
    typealias OrderElement = Int
    var orderElement: OrderElement { id }
}
