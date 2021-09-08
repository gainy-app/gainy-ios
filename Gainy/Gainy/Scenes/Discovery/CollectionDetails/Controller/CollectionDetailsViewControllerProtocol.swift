protocol CollectionDetailsViewControllerProtocol: BaseViewControllerProtocol {
    var onDiscoverCollections: (() -> Void)? { get set }
    var onShowCardDetails: ((DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker) -> Void)? { get set }
}
