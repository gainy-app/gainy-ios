protocol CoordinatorFactoryProtocol {
    func makeMainCoordinatorBox(authorizationManager: AuthorizationManager,
                                router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> MainCoordinator
    
    func makeOnboardingCoordinatorBox(authorizationManager: AuthorizationManager,
                                      router: RouterProtocol,
                                      coordinatorFactory: CoordinatorFactoryProtocol,
                                      viewControllerFactory: ViewControllerFactory) -> OnboardingCoordinator
}
