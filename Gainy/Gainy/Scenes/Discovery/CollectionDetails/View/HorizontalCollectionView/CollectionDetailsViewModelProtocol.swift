protocol CollectionDetailsViewModelProtocol {
    var initialCollectionIndex: Int { get set }
    var collectionDetails: [CollectionDetailViewCellModel] { get set }
    
    var collectionOffset: Int {get set}
    var hasMorePages: Bool {get set}
    var collectionLoadLimit: Int {get}
}
