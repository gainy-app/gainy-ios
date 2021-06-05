protocol DiscoverCollectionsViewControllerProtocol: BaseViewControllerProtocol {
    var onGoToDiscoverCards: (() -> Void)? { get set }
    var onRemovingCollectionFromYourCollections: (() -> Void)? { get set }
}
