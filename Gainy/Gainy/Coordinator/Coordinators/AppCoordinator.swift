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

    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeMainCoordinatorBox(
            router: router,
            coordinatorFactory: CoordinatorFactory(),
            viewControllerFactory: ViewControllerFactory()
        )
        coordinator.finishFlow = { [weak self, unowned coordinator] in
            self?.removeDependency(coordinator)
            self?.launchInstructor = LaunchInstructor.configure()
            self?.start()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}
