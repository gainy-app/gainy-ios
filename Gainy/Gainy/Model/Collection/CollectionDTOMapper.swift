enum CollectionDTOMapper {
    static func map(_ dto: DiscoverCollectionsQuery.Data.Collection) -> Collection {
        
        //TODO: - profileFavoriteCollections check current User Profile ID
        return Collection(
            id: dto.id ?? -1,
            image: dto.name?.lowercased() ?? "",
            imageUrl: dto.imageUrl ?? "",
            name: dto.name ?? "",
            description: dto.description ?? "",
            stocksAmount: Int(dto.tickerCollectionsAggregate.aggregate?.count ?? 0),
            isInYourCollections: false
        )
    }
}
