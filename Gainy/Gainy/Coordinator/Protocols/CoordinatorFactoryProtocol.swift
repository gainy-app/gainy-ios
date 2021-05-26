protocol CoordinatorFactoryProtocol {
    func makeAuthCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> AuthCoordinator
    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator
}
