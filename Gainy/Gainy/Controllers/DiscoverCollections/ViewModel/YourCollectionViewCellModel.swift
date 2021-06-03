struct YourCollectionViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: String
    let recommendedIdentifier: RecommendedCollectionViewCellModel?
}

extension YourCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: YourCollectionViewCellModel, rhs: YourCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id
    }
}
