final class CoordinatorFactory: CoordinatorFactoryProtocol {
    // MARK: - CoordinatorFactoryProtocol

    func makeAuthCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> AuthCoordinator {
        let coordinator = AuthCoordinator(router: router,
                                          coordinatorFactory: coordinatorFactory,
                                          viewControllerFactory: viewControllerFactory)
        return coordinator
    }

    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator {
        let coordinator = MainCoordinator(router: router,
                                          coordinatorFactory: coordinatorFactory,
                                          viewControllerFactory: viewControllerFactory)
        return coordinator
    }

    func makeProfileCoordinatorBox(router: RouterProtocol,
                                   coordinatorFactory: CoordinatorFactoryProtocol,
                                   viewControllerFactory: ViewControllerFactory) -> ProfileCoordinator {
        let coordinator = ProfileCoordinator(router: router,
                                             coordinatorFactory: coordinatorFactory,
                                             viewControllerFactory: viewControllerFactory)
        return coordinator
    }
}
