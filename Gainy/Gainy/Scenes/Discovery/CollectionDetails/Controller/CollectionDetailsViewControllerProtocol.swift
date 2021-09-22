protocol CollectionDetailsViewControllerProtocol: BaseViewControllerProtocol {
    var onDiscoverCollections: (() -> Void)? { get set }
    var onShowCardDetails: ((RemoteTickerDetails) -> Void)? { get set }
}
