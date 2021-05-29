import Foundation

private var onboardingWasShown = true
private var isAutorized = true

enum LaunchInstructor {
    case main

    // MARK: Internal

    // MARK: - Public methods

    static func configure(tutorialWasShown _: Bool = onboardingWasShown,
                          isAutorized _: Bool = isAutorized) -> LaunchInstructor {
        .main
    }
}
