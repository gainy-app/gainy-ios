import Foundation

private var onboardingWasShown = false
private var isAutorized = false

enum LaunchInstructor {
    case main
    case auth
    case onboarding

    // MARK: Internal

    // MARK: - Public methods

    static func configure(tutorialWasShown: Bool = onboardingWasShown,
                          isAutorized: Bool = isAutorized) -> LaunchInstructor {
        switch (tutorialWasShown, isAutorized) {
        case (true, false), (false, false): return .auth
        case (false, true): return .onboarding
        case (true, true): return .main
        }
    }
}
