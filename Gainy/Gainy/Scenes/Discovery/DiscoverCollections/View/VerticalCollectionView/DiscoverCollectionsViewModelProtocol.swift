protocol DiscoverCollectionsViewModelProtocol {
    var noCollections: [NoCollectionViewModel] {get set}
    var watchlistCollections: [YourCollectionViewCellModel] { get set }
    var yourCollections: [YourCollectionViewCellModel] { get set }
    var topGainers: [HomeTickersCollectionViewCellModel] { get set }
    var topLosers: [HomeTickersCollectionViewCellModel] { get set }
    var recommendedCollections: [RecommendedCollectionViewCellModel] { get set }
    var addedRecs: [Int: RecommendedCollectionViewCellModel] { get set }
}

protocol DiscoveryViewModelProtocol {
    var yourCollections: [YourCollectionViewCellModel] { get set }
    
    var topCollections: [RecommendedCollectionViewCellModel] { get set }
    var recommendedCollections: [RecommendedCollectionViewCellModel] { get set }
    
    var addedRecs: [Int: RecommendedCollectionViewCellModel] { get set }
    
    var gridDataSource: DiscoveryGridDataSource {get set}
    var shelfDataSource: DiscoveryShelfDataSource {get set}
    
}
