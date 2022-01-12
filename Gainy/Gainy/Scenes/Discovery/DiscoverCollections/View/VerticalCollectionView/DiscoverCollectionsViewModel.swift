import Foundation

final class DiscoverCollectionsViewModel: NSObject, DiscoverCollectionsViewModelProtocol {
    var noCollections: [NoCollectionViewModel] = [NoCollectionViewModel()]
    var watchlistCollections: [YourCollectionViewCellModel] = []
    var yourCollections: [YourCollectionViewCellModel] = []
    var recommendedCollections: [RecommendedCollectionViewCellModel] = []
    
    //Temp cache of removed items
    var addedRecs: [Int : RecommendedCollectionViewCellModel] = [:]
}
