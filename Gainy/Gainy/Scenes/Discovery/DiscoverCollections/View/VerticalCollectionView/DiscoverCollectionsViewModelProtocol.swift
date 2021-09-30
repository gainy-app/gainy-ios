protocol DiscoverCollectionsViewModelProtocol {
    var noCollections: [NoCollectionViewModel] {get set}
    var yourCollections: [YourCollectionViewCellModel] { get set }
    var recommendedCollections: [RecommendedCollectionViewCellModel] { get set }
}
