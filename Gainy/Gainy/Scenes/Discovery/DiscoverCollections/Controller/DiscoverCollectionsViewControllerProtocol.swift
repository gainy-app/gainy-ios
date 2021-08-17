protocol DiscoverCollectionsViewControllerProtocol: BaseViewControllerProtocol {
    var onGoToCollectionDetails: ((Int) -> Void)? { get set }
    var onRemoveCollectionFromYourCollections: (() -> Void)? { get set }
}
