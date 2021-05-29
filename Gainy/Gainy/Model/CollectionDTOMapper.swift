// TODO: check force unwraps
enum CollectionDTOMapper {
    static func map(_ dto: CollectionsQuery.Data.Collection) -> Collection {
        Collection(
            id: Int(dto.id)!,
            image: dto.image,
            name: dto.name,
            description: dto.description,
            stocksAmount: Int(dto.stocksCount)!,
            isInYourCollections: dto.favoriteCollections.first?.isDefault ?? false
        )
    }
}
