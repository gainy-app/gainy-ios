protocol DiscoverCollectionsViewControllerProtocol: BaseViewControllerProtocol {
    var onGoToCollectionDetails: ((Int) -> Void)? { get set }
    var onRemoveCollectionFromYourCollections: (() -> Void)? { get set }
    var onSwapItems: ((Int, Int) -> Void)? { get set }
    var onItemDelete: ((DiscoverCollectionsSection, Int) -> Void)? { get set }
}
