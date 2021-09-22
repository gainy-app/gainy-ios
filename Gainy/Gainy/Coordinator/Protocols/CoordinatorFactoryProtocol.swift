protocol CoordinatorFactoryProtocol {
    func makeMainCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator
    
    func makeOnboardingCoordinatorBox(authorizationManager: AuthorizationManager,
                                      router: RouterProtocol,
                                      coordinatorFactory: CoordinatorFactoryProtocol,
                                      viewControllerFactory: ViewControllerFactory) -> OnboardingCoordinator
}
