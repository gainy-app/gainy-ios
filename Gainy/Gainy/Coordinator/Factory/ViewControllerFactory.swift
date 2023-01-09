import UIKit
import GainyAPI

final class ViewControllerFactory {
    
    weak var authorizationManager: AuthorizationManager?
    
    var isLightTheme: Bool {
        false
    }
    
    private let tabNames: [String] = ["Home", "Discovery", "Portfolio", "Profile"]
    var selectedColor: UIColor {
        isLightTheme ? UIColor(named: "mainText")! : UIColor(named: "tabbar_tint_color")!
    }
    
    var unselectedColor: UIColor {
        isLightTheme ? UIColor.init(hexString: "#687379", alpha: 1.0)!: UIColor(named: "tabbar_disabled_color")!
    }
    
    func instantiateMainTab(coordinator: MainCoordinator) -> MainTabBarViewController {
        let vc = MainTabBarViewController.instantiate(.discovery)
        return vc
    }
    
    func instantiateLaunchScreen(coordinator: OnboardingCoordinator) -> LaunchScreenViewController {
        let vc = LaunchScreenViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        vc.authorizationManager = authorizationManager
        return vc
    }
    
    func instantiateIntroduction(coordinator: OnboardingCoordinator) -> IntroductionViewController {
        let vc = IntroductionViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiatePersonalizationPickInterests(coordinator: OnboardingCoordinator) -> PersonalizationPickInterestsViewController {
        let vc = PersonalizationPickInterestsViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiatePersonalizationIndicators(coordinator: OnboardingCoordinator?) -> PersonalizationIndicatorsViewController {
        let vc = PersonalizationIndicatorsViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiateOnboardingFinalizing(coordinator: OnboardingCoordinator) -> OnboardingFinalizingViewController {
        let vc = OnboardingFinalizingViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiateAuthorization(coordinator: OnboardingCoordinator) -> AuthorizationViewController {
        let vc = AuthorizationViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func initializeBetaDisclaimer(coordinator: OnboardingCoordinator) -> BetaDisclaimerViewController {
        let vc = BetaDisclaimerViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiatePersonalInfo(coordinator: OnboardingCoordinator) -> PersonalInfoViewController {
        let vc = PersonalInfoViewController.instantiate(.onboarding)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiateEditProfileCollectionInfo(coordinator: MainCoordinator) -> EditProfileCollectionViewController {
        let vc = EditProfileCollectionViewController.instantiate(.profile)
        vc.coordinator = coordinator
        return vc
    }
    
    func instantiateEditPersonalInfo() -> EditPersonalInfoViewController {
        let vc = EditPersonalInfoViewController.instantiate(.profile)
        return vc
    }
    
    func instantiatePrivacy() -> PrivacyViewController {
        let vc = PrivacyViewController.instantiate(.profile)
        return vc
    }
    
    func instantiateStatements(coordinator: MainCoordinator) -> StatementsViewController {
        let vc = StatementsViewController.instantiate(.profile)
        vc.mainCoordinator = coordinator
        return vc
    }
    
    func instantiateStatementDetails() -> StatementDetailsViewController {
        let vc = StatementDetailsViewController.instantiate(.profile)
        return vc
    }
    
    func instantiateProfileSubscription(coordinator: MainCoordinator) -> ProfileSubscriptionViewController {
        let vc = ProfileSubscriptionViewController.instantiate(.profile)
        vc.mainCoordinator = coordinator
        return vc
    }
    
    func instantiateDiscoverCollections(coordinator: MainCoordinator) -> DiscoverCollectionsViewController {
        let vc = DiscoverCollectionsViewController()
        vc.coordinator = coordinator
        vc.viewModel = DiscoverCollectionsViewModel()
        vc.authorizationManager = authorizationManager
        setupTabWithIndex(vc: vc, tab: .discovery)
        vc.onGoToCollectionDetails = { initialCollectionIndex in
            let detailsVC = coordinator.viewControllerFactory.instantiateCollectionDetails(coordinator: coordinator)
            coordinator.showCollectionDetailsViewController(with: initialCollectionIndex, for: detailsVC)
        }
        return vc
    }
    
    func instantiateCollectionDetails(coordinator: MainCoordinator) -> CollectionDetailsViewController {
        let vc = CollectionDetailsViewController()
        vc.viewModel = CollectionDetailsViewModel()
        vc.coordinator = coordinator
        vc.authorizationManager = authorizationManager
        setupTabWithIndex(vc: vc, tab: .discovery)
        vc.onDiscoverCollections = { showNextButton in
            coordinator.showDiscoverCollectionsViewController()
//            coordinator.showDiscoverCollectionsViewController(showNextButton: showNextButton) {initialCollectionIndex in
//                coordinator.showCollectionDetailsViewController(with: initialCollectionIndex, for: vc)
//            } onSwapItems:  { source, dest in
//                vc.swapItemsAt(source, destId: dest)
//            } onItemDelete: { section, itemId in
//                vc.deleteItem(itemId)
//            }
        }
        vc.onShowCardDetails = { tickers, index in
            vc.postLeaveAnalytics()
            coordinator.showCardsDetailsViewController(tickers.compactMap({TickerInfo(ticker: $0)}), index: index)
        }
        return vc
    }
    
    func instantiateBrokersList() -> BrokersViewController {
        let vc = BrokersViewController.instantiate(.discovery)
        return vc
    }
    
    func instantiateTickerDetails() -> TickerViewController {
        let vc = TickerViewController.instantiate(.discovery)
        return vc
    }
    
    func instantiateTickersPages() -> TickersDetailsViewController {
        let vc = TickersDetailsViewController.instantiate(.discovery)
        return vc
    }
    
    func instantiateMetricsList() -> MetricsViewController {
        let vc = MetricsViewController.instantiate(.discovery)
        return vc
    }
    
    func instantiateCollectionDetails(colID: Int, collection: RemoteShortCollectionDetails? = nil) -> SingleCollectionDetailsViewController {
        let vc = SingleCollectionDetailsViewController.instantiate(.discovery)
        vc.collectionId = colID
        vc.shortCollection = collection
        return vc
    }
    
    func instantiateCompareDetails(model: CollectionDetailViewCellModel) -> SingleCollectionDetailsViewController {
        let vc = SingleCollectionDetailsViewController.instantiate(.discovery)
        vc.collectionId = Constants.CollectionDetails.compareCollectionID
        vc.model = model
        return vc
    }
    
    func instantiateBuyingPower() -> BuyingPowerDetailsViewController {
        let vc = BuyingPowerDetailsViewController.instantiate(.portfolio)
        return vc
    }
    
    func instantiateDemoController(_ index: Int) -> BaseViewController {
        let vc = BaseViewController()
        setupTabWithIndex(vc: vc, tab: CustomTabBar.Tab.init(rawValue: index) ?? .discovery)
        return vc
    }
    
    func instantiatePurchases() -> PurchaseViewController {
        let vc = PurchaseViewController.instantiate(.purchases)
        return vc
    }
    
    func instantiatePromoPurchases() -> PromoPurchaseViewController {
        let vc = PromoPurchaseViewController.instantiate(.purchases)
        return vc
    }
    
    func instantiateNotificationsView() -> HomeNotificationsViewController {
        let vc = HomeNotificationsViewController.instantiate(.home)
        vc.isModalInPresentation = true
        return vc
    }
    
    func instantiateNotificationView() -> HomeNotificationViewController {
        let vc = HomeNotificationViewController.instantiate(.home)
        return vc
    }
    
    /// Populating TabBarItem for specific tab
    /// - Parameters:
    ///   - vc: BaseViewController to update
    ///   - tab: Tab name
    private func setupTabWithIndex(vc: BaseViewController, tab: CustomTabBar.Tab) {
        let index = tab.rawValue
        vc.tabBarItem = UITabBarItem(title: tabNames[index], image: UIImage(named: "tab\(index)_passive")!.withRenderingMode(.alwaysOriginal),
                                     selectedImage: UIImage(named: "tab\(index)_active")!.withRenderingMode(.alwaysOriginal))
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
    }
    
    func instantiatePortfolioVC(coordinator: MainCoordinator) -> PortfolioViewController {
        let vc = PortfolioViewController.instantiate(.portfolio)
        vc.mainCoordinator = coordinator
        setupTabWithIndex(vc: vc, tab: .portfolio)
        return vc
    }
    
    func instantiateHomeVC(coordinator: MainCoordinator) -> HomeViewController {
        let vc = HomeViewController.instantiate(.home)
        vc.mainCoordinator = coordinator
        vc.authorizationManager = authorizationManager
        setupTabWithIndex(vc: vc, tab: .home)
        return vc
    }
    
    func instantiateWatchlistVC() -> WatchlistViewController {
        let vc = WatchlistViewController.instantiate(.home)
        return vc
    }
    
    func instantiateAnalyticsVC() -> AnalyticsViewController {
        let vc = AnalyticsViewController.instantiate(.analytics)
        //setupTabWithIndex(vc: vc, tab: .analytics)
        return vc
    }
    
    func instantiateProfileVC(coordinator: MainCoordinator) -> ProfileViewController {
        let vc = ProfileViewController.instantiate(.profile)
        vc.mainCoordinator = coordinator
        vc.authorizationManager = authorizationManager
        setupTabWithIndex(vc: vc, tab: .profile)
        return vc
    }
}
