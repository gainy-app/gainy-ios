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
    
    func makeOnboardingCoordinatorBox(router: RouterProtocol,
                                coordinatorFactory: CoordinatorFactoryProtocol,
                                viewControllerFactory: ViewControllerFactory) -> OnboardingCoordinator {
        
        let coordinator = OnboardingCoordinator(router: router,
                                          coordinatorFactory: coordinatorFactory,
                                          viewControllerFactory: viewControllerFactory)
        return coordinator
    }
}
