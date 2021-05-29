struct YourCollectionViewCellModel {
    let id: Int
    let image: String
    let name: String
    let description: String
    let stocksAmount: Int
}

//class YourCollectionViewCellModel {
//    var id: Int
//    var image: String
//    var name: String
//    var description: String
//    var stocksAmount: Int
//
//    init(id: Int,
//         image: String,
//         name: String,
//         description: String,
//         stocksAmount: Int) {
//        self.id = id
//        self.image = image
//        self.name = name
//        self.description = description
//        self.stocksAmount = stocksAmount
//    }
//}

extension YourCollectionViewCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: YourCollectionViewCellModel, rhs: YourCollectionViewCellModel) -> Bool {
        lhs.id == rhs.id
    }
}
