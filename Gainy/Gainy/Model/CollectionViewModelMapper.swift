enum CollectionViewModelMapper {
    static func map(_ model: Collection) -> YourCollectionViewCellModel {
        YourCollectionViewCellModel(
            id: model.id,
            image: model.image,
            name: model.name,
            description: model.description,
            stocksAmount: "\(model.stocksAmount)",
            recommendedIdentifier: nil
        )
    }

    static func map(_ model: Collection) -> RecommendedCollectionViewCellModel {
        RecommendedCollectionViewCellModel(
            id: model.id,
            image: model.image,
            name: model.name,
            description: model.description,
            stocksAmount: "\(model.stocksAmount)",
            isInYourCollections: model.isInYourCollections
        )
    }
}
