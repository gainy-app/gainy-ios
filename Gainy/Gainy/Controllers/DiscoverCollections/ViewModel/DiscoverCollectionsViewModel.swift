import Foundation

class DiscoverCollectionsViewModel: NSObject, DiscoverCollectionsViewModelProtocol {
    var yourCollections: [YourCollectionViewCellModel] = []
    var recommendedCollections: [RecommendedCollectionViewCellModel] = []
}
