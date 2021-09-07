import Foundation

enum LaunchInstructor {
   
    case main, onboarding, signin, signup
    
    // MARK: Internal

    // MARK: - Public methods

    static func configure(withOnboardingWasShown onboardingWasShown: Bool,
                          isAutorized autorized: Bool) -> LaunchInstructor {
        
        if autorized {
            return .main
        }
        
        if !onboardingWasShown {
            return .onboarding
        }
        
        return .signin
    }
}
