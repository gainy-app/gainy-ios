protocol DiscoverCollectionsViewControllerProtocol: BaseViewControllerProtocol {
    var onGoToCollectionDetails: (() -> Void)? { get set }
    var onRemovingCollectionFromYourCollections: (() -> Void)? { get set }
}