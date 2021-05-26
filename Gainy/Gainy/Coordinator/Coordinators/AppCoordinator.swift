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
            case .auth: break // TODO: use if makes sense: runAFlow()
            case .main: runMainFlow()
            case .onboarding: break // TODO: remove
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private let coordinatorFactory: CoordinatorFactoryProtocol
    private let router: RouterProtocol
    private var launchInstructor = LaunchInstructor.configure()
    private let viewControllerFactory = ViewControllerFactory()

    // MARK: Functions

//    private func runAFlow() {
//        let coordinator = self.coordinatorFactory.makeAuthCoordinatorBox(
//            router: self.router,
//            coordinatorFactory: self.coordinatorFactory,
//            viewControllerFactory: self.viewControllerFactory
//        )
//        coordinator.finishFlow = { [unowned self, unowned coordinator] in
//            self.removeDependency(coordinator)
//            self.launchInstructor = LaunchInstructor.configure()
//            self.start()
//        }
//        self.addDependency(coordinator)
//        coordinator.start()
//    }

    private func runMainFlow() {
        let coordinator = self.coordinatorFactory.makeMainCoordinatorBox(
            router: self.router,
            coordinatorFactory: CoordinatorFactory(),
            viewControllerFactory: ViewControllerFactory()
        )
        coordinator.finishFlow = { [unowned self, unowned coordinator] in
            self.removeDependency(coordinator)
            self.launchInstructor = LaunchInstructor.configure()
            self.start()
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
}
