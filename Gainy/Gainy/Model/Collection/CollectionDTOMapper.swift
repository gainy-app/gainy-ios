enum CollectionDTOMapper {
    static func map(_ dto: RemoteShortCollectionDetails) -> Collection {
        
        return Collection(
            id: dto.id ?? -1,
            image: dto.name?.lowercased() ?? "",
            imageUrl: dto.imageUrl ?? "",
            name: dto.name ?? "",
            description: dto.description ?? "",
            stocksAmount: Int(dto.size ?? 0),
            matchScore: Int(dto.matchScore?.matchScore ?? 0),
            dailyGrow: dto.metrics?.relativeDailyChange ?? 0.0,
            isInYourCollections: UserProfileManager.shared.favoriteCollections.contains(dto.id ?? -1)
        )
    }
    
    static func map(_ dto: RemoteCollectionDetails) -> Collection {
        
        return Collection(
            id: dto.id ?? -1,
            image: dto.name?.lowercased() ?? "",
            imageUrl: dto.imageUrl ?? "",
            name: dto.name ?? "",
            description: dto.description ?? "",
            stocksAmount: Int(dto.size ?? 0),
            matchScore: Int(dto.matchScore?.matchScore ?? 0),
            dailyGrow: dto.metrics?.relativeDailyChange ?? 0.0,
            isInYourCollections: UserProfileManager.shared.favoriteCollections.contains(dto.id ?? -1)
        )
    }
}
