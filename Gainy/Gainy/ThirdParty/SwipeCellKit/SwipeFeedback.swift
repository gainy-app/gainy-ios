import UIKit

final class SwipeFeedback {
    // MARK: Lifecycle

    init(style: Style) {
        switch style {
        case .light:
            feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        }
    }

    // MARK: Internal

    enum Style {
        case light
    }

    func prepare() {
        feedbackGenerator?.prepare()
    }

    func impactOccurred() {
        feedbackGenerator?.impactOccurred()
    }

    // MARK: Private

    private var _feedbackGenerator: Any?

    private var feedbackGenerator: UIImpactFeedbackGenerator? {
        get {
            _feedbackGenerator as? UIImpactFeedbackGenerator
        }
        set {
            _feedbackGenerator = newValue
        }
    }
}
