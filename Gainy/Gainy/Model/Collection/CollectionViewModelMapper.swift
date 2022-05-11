enum CollectionViewModelMapper {
    static func map(_ model: Collection) -> YourCollectionViewCellModel {
        YourCollectionViewCellModel(
            id: model.id,
            image: model.image,
            imageUrl: model.imageUrl,
            name: model.name,
            description: model.description,
            stocksAmount: model.stocksAmount,
            matchScore: model.matchScore,
            dailyGrow: model.dailyGrow,
            recommendedIdentifier: nil
        )
    }

    static func map(_ model: Collection) -> RecommendedCollectionViewCellModel {
        RecommendedCollectionViewCellModel(
            id: model.id,
            image: model.image,
            imageUrl: model.imageUrl,
            name: model.name,
            description: model.description,
            stocksAmount: model.stocksAmount,
            matchScore: model.matchScore,
            dailyGrow: model.dailyGrow,
            isInYourCollections: model.isInYourCollections
        )
    }
}
