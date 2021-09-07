final class AppCoordinator: BaseCoordinator {
    // MARK: Lifecycle

    // MARK: Init

    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }

    // MARK: Internal

    // MARK: Coordinator

    override func start(with option: DeepLinkOption?) {
        if option != nil {
            // TODO: process
        } else {
            switch launchInstructor {
            case .main: runMainFlow()
            case .onboarding: runOnboardingFlow()
            case .signin: runSignInFlow()
            case .signup: runSignUpFlow()
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private var launchInstructor = LaunchInstructor.configure(withOnboardingWasShown: false, isAutorized: false)
    private let viewControllerFactory = ViewControllerFactory()

    private var currentCoordinator: Coordinator?
    
    // MARK: Functions
    
    private func runSignUpFlow() {
        
    }
    
    private func runSignInFlow() {
        
    }
    
    private func runOnboardingFlow() {
        let coordinator = coordinatorFactory.makeOnboardingCoordinatorBox(
            router: router,
            coordinatorFactory: CoordinatorFactory(),
            viewControllerFactory: ViewControllerFactory()
        )
        self.currentCoordinator = coordinator
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            
            // TODO: get is authorized
            self?.launchInstructor = LaunchInstructor.configure(withOnboardingWasShown: true, isAutorized: true)
            if let coordinator = self?.currentCoordinator {
                self?.removeDependency(coordinator)
                self?.currentCoordinator = nil
            }
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinatorBox(
            router: router,
            coordinatorFactory: CoordinatorFactory(),
            viewControllerFactory: ViewControllerFactory()
        )
        self.currentCoordinator = coordinator
        coordinator.finishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.launchInstructor = LaunchInstructor.configure(withOnboardingWasShown: true, isAutorized: true)
            if let coordinator = self?.currentCoordinator {
                self?.removeDependency(coordinator)
                self?.currentCoordinator = nil
            }
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
