protocol CollectionDetailsViewControllerProtocol: BaseViewControllerProtocol {
    var onDiscoverCollections: (() -> Void)? { get set }
    var onShowCardDetails: (() -> Void)? { get set }
}
