struct RecommendedCollectionViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
    let buttonState: RecommendedCellButtonState
}

//class RecommendedCollectionViewCellModel {
//    var id: Int
//    var image: String
//    var name: String
//    var description: String
//    var stocksAmount: Int
//    var buttonState: RecommendedCellButtonState
//
//    init(id: Int,
//         image: String,
//         name: String,
//         description: String,
//         stocksAmount: Int,
//         buttonState: RecommendedCellButtonState) {
//        self.id = id
//        self.image = image
//        self.name = name
//        self.description = description
//        self.stocksAmount = stocksAmount
//        self.buttonState = buttonState
//    }
//}

extension RecommendedCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
//        hasher.combine(buttonState)
    }

    static func == (lhs: RecommendedCollectionViewCellModel, rhs: RecommendedCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id // && lhs.buttonState == rhs.buttonState
    }
}
