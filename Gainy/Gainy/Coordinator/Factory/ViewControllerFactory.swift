import UIKit

final class ViewControllerFactory {
    func instantiateDiscoverCollections() -> DiscoverCollectionsViewController {
        let vc = DiscoverCollectionsViewController()
        vc.viewModel = DiscoverCollectionsViewModel()
        return vc
    }

    func instantiateCollectionDetails() -> CollectionDetailsViewController {
        let vc = CollectionDetailsViewController()
        vc.viewModel = CollectionDetailsViewModel()
        return vc
    }
}
