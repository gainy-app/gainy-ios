enum CollectionViewModelMapper {
    static func map(_ model: Collection) -> YourCollectionViewCellModel {
        YourCollectionViewCellModel(
            id: model.id,
            image: model.image,
            name: model.name,
            description: model.description,
            stocksAmount: model.stocksAmount,
            indexInRecommended: nil
        )
    }

    static func map(_ model: Collection) -> RecommendedCollectionViewCellModel {
        RecommendedCollectionViewCellModel(
            id: model.id,
            image: model.image,
            name: model.name,
            description: model.description,
            stocksAmount: model.stocksAmount,
            buttonState: model.isInYourCollections ? .checked : .unchecked
        )
    }
}
