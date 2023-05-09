import GainyAPI

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
            performance: model.performance,
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
            performance: model.performance,
            isInYourCollections: model.isInYourCollections
        )
    }
    
    static func mapFromShort(_ dto: RemoteShortCollectionDetails) -> RecommendedCollectionViewCellModel {
        RecommendedCollectionViewCellModel(
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
    
    static func mapFromFull(_ dto: RemoteCollectionDetails) -> RecommendedCollectionViewCellModel {
        RecommendedCollectionViewCellModel(
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
