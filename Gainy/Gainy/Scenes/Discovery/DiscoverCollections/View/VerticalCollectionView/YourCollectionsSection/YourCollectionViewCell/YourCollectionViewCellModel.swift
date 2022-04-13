struct YourCollectionViewCellModel {
    let id: Int
    let image: String
    let imageUrl: String
    let name: String
    let description: String
    let stocksAmount: Int
    let matchScore: Int
    let dailyGrow: Float
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

// TODO: 1: rename viewmodel to view state
