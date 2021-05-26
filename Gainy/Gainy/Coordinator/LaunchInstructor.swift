import Foundation

private var onboardingWasShown = true
private var isAutorized = true

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
