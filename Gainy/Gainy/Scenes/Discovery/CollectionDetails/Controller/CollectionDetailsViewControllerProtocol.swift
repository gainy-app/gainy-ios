protocol CollectionDetailsViewControllerProtocol: BaseViewControllerProtocol {
    var onDiscoverCollections: ((Bool) -> Void)? { get set }
    var onShowCardDetails: ((RemoteTickerDetails) -> Void)? { get set }
}
