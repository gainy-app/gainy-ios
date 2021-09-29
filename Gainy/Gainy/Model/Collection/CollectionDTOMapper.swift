enum CollectionDTOMapper {
    static func map(_ dto: RemoteShortCollectionDetails) -> Collection {
        
        return Collection(
            id: dto.id ?? -1,
            image: dto.name?.lowercased() ?? "",
            imageUrl: dto.imageUrl ?? "",
            name: dto.name ?? "",
            description: dto.description ?? "",
            stocksAmount: Int(dto.tickerCollectionsAggregate.aggregate?.count ?? 0),
            isInYourCollections: DemoUserContainer.shared.favoriteCollections.contains(dto.id ?? -1)
        )
    }
}
