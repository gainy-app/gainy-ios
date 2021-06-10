import Foundation

class CollectionDetailsViewModel: NSObject, CollectionDetailsViewModelProtocol {
    var initialCollectionIndex = 0
    var collectionDetails = [CollectionDetailViewCellModel]()
}
