import Foundation

final class CollectionDetailsViewModel: NSObject, CollectionDetailsViewModelProtocol {
    var initialCollectionIndex = 0
    var collectionDetails = [CollectionDetailViewCellModel]()
    
    //MARK: - Pagination
    
    var collectionOffset: Int = 0
    var hasMorePages: Bool = true
    
    var collectionLoadLimit: Int {
        20
    }
}
