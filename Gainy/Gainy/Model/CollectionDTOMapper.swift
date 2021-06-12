enum CollectionDTOMapper {
    static func map(_ dto: CollectionsQuery.Data.Collection) -> Collection {
        guard let id = Int(dto.id), let stocksAmount = Int(dto.stocksCount) else {
            return Collection(
                id: 0,
                image: dto.name.lowercased(),
                name: dto.name,
                description: dto.description,
                stocksAmount: 0,
                isInYourCollections: dto.favoriteCollections.first?.isDefault ?? false
            )
        }

        return Collection(
            id: id,
            image: dto.name.lowercased(),
            name: dto.name,
            description: dto.description,
            stocksAmount: stocksAmount,
            isInYourCollections: dto.favoriteCollections.first?.isDefault ?? false
        )
    }
}
