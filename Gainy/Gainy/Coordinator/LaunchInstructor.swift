import Foundation

enum LaunchInstructor {
   
    case main, onboarding
    
    // MARK: Internal

    // MARK: - Public methods

    static func configure(isAutorized autorized: Bool) -> LaunchInstructor {
        
        if autorized {
            return .main
        }
        
        return .onboarding
    }
}
