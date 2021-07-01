import UIKit

/**
 The `SwipeActionTransitioningContext` type provides information relevant to a specific action as transitioning occurs.
 */
struct SwipeActionTransitioningContext {
    // MARK: Lifecycle

    init(actionIdentifier: String?,
         button: UIButton,
         newPercentVisible: CGFloat,
         oldPercentVisible: CGFloat,
         wrapperView: UIView) {
        self.actionIdentifier = actionIdentifier
        self.button = button
        self.newPercentVisible = newPercentVisible
        self.oldPercentVisible = oldPercentVisible
        self.wrapperView = wrapperView
    }

    // MARK: Internal

    /// The unique action identifier.
    let actionIdentifier: String?

    /// The button that is changing.
    let button: UIButton

    /// The old visibility percentage between 0.0 and 1.0.
    let newPercentVisible: CGFloat

    /// The new visibility percentage between 0.0 and 1.0.
    let oldPercentVisible: CGFloat

    let wrapperView: UIView

    /// Sets the background color behind the action button.
    ///
    /// - parameter color: The background color.
    func setBackgroundColor(_ color: UIColor?) {
        wrapperView.backgroundColor = color
    }
}
