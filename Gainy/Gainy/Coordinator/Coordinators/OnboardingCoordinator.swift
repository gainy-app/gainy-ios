import Firebase
import UIKit

final class OnboardingCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: Lifecycle

    init(authorizationManager: AuthorizationManager,
         router: RouterProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol,
         viewControllerFactory: ViewControllerFactory) {
        self.authorizationManager = authorizationManager
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
        self.profileInfoBuilder = ProfileInfoBuilder.init()
        self.onboardingInfoBuilder = OnboardingInfoBuilder.init()
        self.profileInfoBuilder.avatarURLString = ""
        self.profileInfoBuilder.gender = 0
    }

    // MARK: Internal

    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: Coordinator

    override func start() {
        if self.authorizationManager.authorizationStatus != .authorizedFully {
            showLaunchScreenViewController()
        } else {
            assertionFailure("Error: Onboarding flow should not be launched if the user is already logged in!")
        }
    }
    
    public func setRootIntroductionViewController() {
        let vc = viewControllerFactory.instantiateIntroduction(coordinator: self)
        vc.coordinator = self
        self.dismissModule()
        router.setRootModule(vc)
    }
    
    public func pushIntroductionViewController() {
        let vc = viewControllerFactory.instantiateIntroduction(coordinator: self)
        vc.coordinator = self
        router.push(vc)
    }
    
    public func pushPersonalizationPickInterestsViewController() {
        let vc = viewControllerFactory.instantiatePersonalizationPickInterests(coordinator: self)
        vc.coordinator = self
        router.push(vc)
    }
    
    public func pushPersonalizationIndicatorsViewController() {
        let vc = viewControllerFactory.instantiatePersonalizationIndicators(coordinator: self)
        vc.coordinator = self
        router.push(vc)
    }
    
    public func pushOnboardingFinalizingViewController() {
        let vc = viewControllerFactory.instantiateOnboardingFinalizing(coordinator: self)
        vc.coordinator = self
        vc.authorizationManager = self.authorizationManager
        router.push(vc)
    }
    
    public func presentAuthorizationViewController(isOnboardingDone: Bool? = nil) {
        
        let vc = viewControllerFactory.instantiateAuthorization(coordinator: self)
        vc.coordinator = self
        vc.authorizationManager = self.authorizationManager
        vc.onboardingDone = isOnboardingDone
        let navigationController = UINavigationController.init(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        router.present(navigationController)
        self.authenticationNavigationController = navigationController
    }
    
    public func pushPersonalInfoViewController(isOnboardingDone: Bool? = nil) {
        let vc = viewControllerFactory.instantiatePersonalInfo(coordinator: self)
        vc.coordinator = self
        vc.authorizationManager = self.authorizationManager
        vc.onboardingDone = isOnboardingDone
        if let authenticationNavigationController = self.authenticationNavigationController {
            authenticationNavigationController.pushViewController(vc, animated: true)
        } else {
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            router.present(navigationController)
            self.authenticationNavigationController = navigationController
        }
    }
    
    public func presentOnboardingFinalizingViewController() {
        let vc = viewControllerFactory.instantiateOnboardingFinalizing(coordinator: self)
        vc.coordinator = self
        vc.coordinator = self
        vc.authorizationManager = self.authorizationManager
        if let authenticationNavigationController = self.authenticationNavigationController {
            authenticationNavigationController.pushViewController(vc, animated: true)
        } else {
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            router.present(navigationController)
            self.authenticationNavigationController = navigationController
        }
    }
    
    public func dismissModule() {
        
        router.dismissModule()
        self.authenticationNavigationController = nil
    }
    
    public func popModule() {
        
        router.popModule()
    }
    
    public func popToRootModule() {
        
        router.popToRootModule(animated: true)
    }

    // MARK: Private

    // MARK: Properties

    private let authorizationManager: AuthorizationManager
    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private(set) var viewControllerFactory: ViewControllerFactory
    private var authenticationNavigationController: UINavigationController?
    
    private(set) var profileInfoBuilder: ProfileInfoBuilder
    private(set) var onboardingInfoBuilder: OnboardingInfoBuilder
    
    // MARK: Functions
    
    private func showLaunchScreenViewController() {
        let vc = viewControllerFactory.instantiateLaunchScreen(coordinator: self)
        vc.coordinator = self
        router.setRootModule(vc, hideBar: true)
    }
}

