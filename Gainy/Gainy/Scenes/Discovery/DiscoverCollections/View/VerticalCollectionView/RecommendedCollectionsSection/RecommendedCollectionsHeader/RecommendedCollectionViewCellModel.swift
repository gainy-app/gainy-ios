struct RecommendedCollectionViewCellModel {
    let id: Int
    let image: String
    let imageUrl: String
    let name: String
    let description: String
    let stocksAmount: String
    var isInYourCollections: Bool
}

extension RecommendedCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(isInYourCollections)
    }

    static func == (lhs: RecommendedCollectionViewCellModel, rhs: RecommendedCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id
    }
}

