import UIKit

final class ViewControllerFactory {
    func instantiateDiscoverCollections() -> DiscoverCollectionsViewController {
        let vc = DiscoverCollectionsViewController()
        vc.viewModel = DiscoverCollectionsViewModel()
        return vc
    }

    func instantiateDiscoverCards() -> DiscoverCardsViewController {
        let vc = DiscoverCardsViewController()
        vc.viewModel = DiscoverCardsViewModel()
        return vc
    }
}
