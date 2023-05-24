import Foundation

final class DiscoverCollectionsViewModel: NSObject, DiscoverCollectionsViewModelProtocol {
    var noCollections: [NoCollectionViewModel] = [NoCollectionViewModel()]
    var watchlistCollections: [YourCollectionViewCellModel] = []
    var yourCollections: [YourCollectionViewCellModel] = []
    var recommendedCollections: [RecommendedCollectionViewCellModel] = []
    
    //Temp cache of removed items
    var addedRecs: [Int : RecommendedCollectionViewCellModel] = [:]
    
    //MARK: - Gainers
    var topGainers: [HomeTickersCollectionViewCellModel] = []
    var topLosers: [HomeTickersCollectionViewCellModel] = []

    
}

final class DiscoveryViewModel: NSObject, DiscoveryViewModelProtocol {
    var yourCollections: [YourCollectionViewCellModel] = []
    
    var topCollections: [RecommendedCollectionViewCellModel] = []
    var recommendedCollections: [RecommendedCollectionViewCellModel] = [] {
        didSet {
            gridDataSource.recommendedCollections = recommendedCollections
            shelfDataSource.updateCollections(recommendedCollections, shelfCols: shelfs)
        }
    }
    var shelfs: [DiscoverySectionCollection] = []
    
    //Temp cache of removed items
    var addedRecs: [Int : RecommendedCollectionViewCellModel] = [:]
    
    //new sources for Collection
    var gridDataSource: DiscoveryGridDataSource = DiscoveryGridDataSource()
    var shelfDataSource: DiscoveryShelfDataSource = DiscoveryShelfDataSource()
    
}
