import Firebase
import UIKit

final class OnboardingCoordinator: BaseCoordinator, CoordinatorFinishOutput {
    // MARK: Lifecycle

    init(router: RouterProtocol,
         coordinatorFactory: CoordinatorFactoryProtocol,
         viewControllerFactory: ViewControllerFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        self.viewControllerFactory = viewControllerFactory
    }

    // MARK: Internal

    // MARK: CoordinatorFinishOutput

    var finishFlow: (() -> Void)?

    // MARK: Coordinator

    override func start() {
        if !isLoggedIn {
            showLaunchScreenViewController()
        } else {
            assertionFailure("Error: Onboarding flow should not be launched if the user is already logged in!")
        }
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
        router.push(vc)
    }
    
    public func popModule() {
        
        router.popModule()
    }
    
    public func popToRootModule() {
        
        router.popToRootModule(animated: true)
    }
    
    /// FIRUser status
    var isLoggedIn: Bool {
        let currentUser: User? = Auth.auth().currentUser
        return currentUser != nil
    }

    // MARK: Private

    // MARK: Properties

    private let router: RouterProtocol
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private(set) var viewControllerFactory: ViewControllerFactory

    // MARK: Functions
    
    private func showLaunchScreenViewController() {
        let vc = viewControllerFactory.instantiateOnboarding(coordinator: self)
        vc.coordinator = self
        router.setRootModule(vc, hideBar: true)
    }
}

