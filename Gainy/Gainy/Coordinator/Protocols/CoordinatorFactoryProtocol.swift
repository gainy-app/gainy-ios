protocol CoordinatorFactoryProtocol {
    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator
    
    func makeOnboardingCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> OnboardingCoordinator
}
