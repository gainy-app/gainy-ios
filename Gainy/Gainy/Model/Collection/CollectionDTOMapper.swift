enum CollectionDTOMapper {
    static func map(_ dto: DiscoverCollectionsQuery.Data.AppCollection) -> Collection {
        
        //TODO: - profileFavoriteCollections check current User Profile ID
        return Collection(
            id: dto.id,
            image: dto.name.lowercased(),
            imageUrl: dto.imageUrl,
            name: dto.name,
            description: dto.description ?? "",
            stocksAmount: Int(dto.collectionSymbolsAggregate.aggregate?.count ?? 0),
            isInYourCollections: dto.profileFavoriteCollections.count > 0
        )
    }
}
