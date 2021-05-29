final class CoordinatorFactory: CoordinatorFactoryProtocol {
    // MARK: - CoordinatorFactoryProtocol

    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator {
        let coordinator = MainCoordinator(router: router,
                                          coordinatorFactory: coordinatorFactory,
                                          viewControllerFactory: viewControllerFactory)
        return coordinator
    }
}
