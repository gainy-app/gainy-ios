import UIKit

class ViewControllerFactory {
    func instantiateDiscoverCollections() -> DiscoverCollectionsViewController {
        let vc = DiscoverCollectionsViewController()
        vc.viewModel = DiscoverCollectionsViewModel()
        return vc
    }
}
