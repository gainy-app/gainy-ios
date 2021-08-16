import UIKit

final class ViewControllerFactory {
    
    var isLightTheme: Bool {
        false
    }
    
    private let tabNames: [String] = ["Discovery", "Portfolio", "Analytics", "Profile"]
    var selectedColor: UIColor {
        isLightTheme ? UIColor(named: "tabbar_tint_color")! : UIColor(named: "tabbar_tint_color")!
    }
        
    var unselectedColor: UIColor {
        isLightTheme ? UIColor(named: "tabbar_disabled_color")!: UIColor(named: "tabbar_disabled_color")!
    }
    
    func instantiateMainTab(coordinator: MainCoordinator) -> MainTabBarViewController {
        let vc = MainTabBarViewController()
        vc.setViewControllers([instantiateDiscoverCollections(coordinator: coordinator), instantiateDemoController(2), instantiateDemoController(3), instantiateDemoController(4)], animated: false)
        return vc
    }
    
    func instantiateDiscoverCollections(coordinator: MainCoordinator) -> DiscoverCollectionsViewController {
        let vc = DiscoverCollectionsViewController()
        vc.viewModel = DiscoverCollectionsViewModel()
        vc.tabBarItem = UITabBarItem(title: "Discovery", image: UIImage(named: "tab1_passive")!.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: "tab1_active")!.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        vc.onGoToCollectionDetails = { initialPosition in
            coordinator.showCollectionDetailsViewController(with: initialPosition)
        }
        return vc
    }

    func instantiateCollectionDetails() -> CollectionDetailsViewController {
        let vc = CollectionDetailsViewController()
        vc.viewModel = CollectionDetailsViewModel()
        return vc
    }

    func instantiateCardDetails() -> CardDetailsViewController {
        let vc = CardDetailsViewController()
        vc.viewModel = CardDetailsViewModel()
        return vc
    }
    
    func instantiateDemoController(_ index: Int) -> BaseViewController {
        let vc = BaseViewController()
        
        vc.tabBarItem = UITabBarItem(title: tabNames[index - 1], image: UIImage(named: "tab\(index)_passive")!.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: "tab\(index)_active")!.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
        return vc
    }
}
