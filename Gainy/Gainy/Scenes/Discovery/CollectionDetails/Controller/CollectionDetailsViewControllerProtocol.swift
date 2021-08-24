protocol CollectionDetailsViewControllerProtocol: BaseViewControllerProtocol {
    var onDiscoverCollections: (() -> Void)? { get set }
    var onShowCardDetails: ((DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker) -> Void)? { get set }
}
