protocol DiscoverCollectionsViewModelProtocol {
    var noCollections: [NoCollectionViewModel] {get set}
    var watchlistCollections: [YourCollectionViewCellModel] { get set }
    var yourCollections: [YourCollectionViewCellModel] { get set }
    var topGainers: [HomeTickersCollectionViewCellModel] { get set }
    var topLosers: [HomeTickersCollectionViewCellModel] { get set }
    var recommendedCollections: [RecommendedCollectionViewCellModel] { get set }
    var addedRecs: [Int: RecommendedCollectionViewCellModel] { get set }
}
