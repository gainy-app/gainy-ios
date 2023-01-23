struct YourCollectionViewCellModel {
    let id: Int
    let image: String
    let imageUrl: String
    let name: String
    let description: String
    let stocksAmount: Int
    let matchScore: Int
    let dailyGrow: Float
    let value_change_1w: Float
    let value_change_1m: Float
    let value_change_3m: Float
    let value_change_1y: Float
    let value_change_5y: Float
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
