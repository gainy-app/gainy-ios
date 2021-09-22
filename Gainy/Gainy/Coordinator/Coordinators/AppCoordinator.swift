import FirebaseAuth

final class AppCoordinator: BaseCoordinator {
    // MARK: Lifecycle

    // MARK: Init

    init(authorizationManager: AuthorizationManager, router: Router, coordinatorFactory: CoordinatorFactory) {
        
        self.authorizationManager = authorizationManager
        self.router = router
        self.coordinatorFactory = coordinatorFactory
        super.init()
    }

    // MARK: Coordinator

    override func start(with option: DeepLinkOption?) {
        
        self.updateLaunchInstructor()
        
        if let launchInstructor = self.launchInstructor {
            if option != nil {
                // TODO: process
            } else {
                switch launchInstructor {
                case .main: runMainFlow()
                case .onboarding: runOnboardingFlow()
                }
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private let authorizationManager: AuthorizationManager
    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private var launchInstructor: LaunchInstructor?
    private let viewControllerFactory = ViewControllerFactory()

    private var currentCoordinator: Coordinator?
    
    // MARK: Functions
    
    private func runOnboardingFlow() {
        let coordinator = coordinatorFactory.makeOnboardingCoordinatorBox(
            authorizationManager: authorizationManager,
            router: router,
            coordinatorFactory: CoordinatorFactory(),
            viewControllerFactory: ViewControllerFactory()
        )
        self.currentCoordinator = coordinator
        coordinator.finishFlow = { [weak self] in
            guard let self = self else {return}
            self.removeDependency(coordinator)
            
            if let coordinator = self.currentCoordinator {
                self.removeDependency(coordinator)
                self.currentCoordinator = nil
            }
            self.start()
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
            guard let self = self else {return}
                        
            self.removeDependency(coordinator)
            
            if let coordinator = self.currentCoordinator {
                self.removeDependency(coordinator)
                self.currentCoordinator = nil
            }
            self.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func updateLaunchInstructor() {
        
        let isAutorized = (self.authorizationManager.authorizationStatus == .authorizedFully)
        self.launchInstructor = LaunchInstructor.configure(isAutorized: isAutorized)
    }
}
