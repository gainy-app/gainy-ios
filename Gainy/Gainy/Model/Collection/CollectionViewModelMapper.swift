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
            value_change_1w: model.value_change_1w,
            value_change_1m: model.value_change_1m,
            value_change_3m: model.value_change_3m,
            value_change_1y: model.value_change_1y,
            value_change_5y: model.value_change_5y,
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
            value_change_1w: model.value_change_1w,
            value_change_1m: model.value_change_1m,
            value_change_3m: model.value_change_3m,
            value_change_1y: model.value_change_1y,
            value_change_5y: model.value_change_5y,
            isInYourCollections: model.isInYourCollections
        )
    }
}
