import GainyAPI

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
            value_change_1w: Float(dto.metrics?.valueChange_1w ?? 0.0),
            value_change_1m: Float(dto.metrics?.valueChange_1m ?? 0.0),
            value_change_3m: Float(dto.metrics?.valueChange_3m ?? 0.0),
            value_change_1y: Float(dto.metrics?.valueChange_1y ?? 0.0),
            value_change_5y: Float(dto.metrics?.valueChange_5y ?? 0.0),
            performance: dto.metrics?.performanceRank ?? 0,
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
            value_change_1w: Float(dto.metrics?.valueChange_1w ?? 0.0),
            value_change_1m: Float(dto.metrics?.valueChange_1m ?? 0.0),
            value_change_3m: Float(dto.metrics?.valueChange_3m ?? 0.0),
            value_change_1y: Float(dto.metrics?.valueChange_1y ?? 0.0),
            value_change_5y: Float(dto.metrics?.valueChange_5y ?? 0.0),
            performance: dto.metrics?.performanceRank ?? 0,
            isInYourCollections: UserProfileManager.shared.favoriteCollections.contains(dto.id ?? -1)
        )
    }
}
