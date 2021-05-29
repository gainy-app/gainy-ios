struct RecommendedCollectionViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
    let buttonState: RecommendedCellButtonState
}

extension RecommendedCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: RecommendedCollectionViewCellModel, rhs: RecommendedCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id
    }
}
