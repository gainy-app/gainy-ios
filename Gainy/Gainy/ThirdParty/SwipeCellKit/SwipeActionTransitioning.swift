import UIKit

/**
 Adopt the `SwipeActionTransitioning` protocol in objects that implement custom appearance of actions during transition.
 */
protocol SwipeActionTransitioning {
    /**
     Tells the delegate that transition change has occured.
     */
    func didTransition(with context: SwipeActionTransitioningContext) -> Void
}

/**
 The `SwipeActionTransitioningContext` type provides information relevant to a specific action as transitioning occurs.
 */
struct SwipeActionTransitioningContext {
    // MARK: Lifecycle

    init(actionIdentifier: String?, button: UIButton, newPercentVisible: CGFloat, oldPercentVisible: CGFloat, wrapperView: UIView) {
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

/**
 A scale transition object drives the custom appearance of actions during transition.

 As button's percentage visibility crosses the `threshold`,
 the `ScaleTransition` object will animate from `initialScale` to `identity`.

 The default settings provide a "pop-like" effect as the buttons are exposed more than 50%.
 */
struct ScaleTransition: SwipeActionTransitioning {
    // MARK: Lifecycle

    /**
      Contructs a new `ScaleTransition` instance.

     - parameter duration: The duration of the animation.

     - parameter initialScale: The initial scale factor used before the action button percent visible is greater than the threshold.

     - parameter threshold: The percent visible threshold that triggers the scaling animation.

     - returns: The new `ScaleTransition` instance.
     */
    init(duration: Double = 0.15, initialScale: CGFloat = 0.8, threshold: CGFloat = 0.5) {
        self.duration = duration
        self.initialScale = initialScale
        self.threshold = threshold
    }

    // MARK: Internal

    /// Returns a `ScaleTransition` instance with default transition options.
    static var `default`: ScaleTransition { ScaleTransition() }

    /// The duration of the animation.
    let duration: Double

    /// The initial scale factor used before the action button percent visible is greater than the threshold.
    let initialScale: CGFloat

    /// The percent visible threshold that triggers the scaling animation.
    let threshold: CGFloat

    /// :nodoc:
    func didTransition(with context: SwipeActionTransitioningContext) {
        if context.oldPercentVisible == 0 {
            context.button.transform = .init(scaleX: initialScale, y: initialScale)
        }

        if context.oldPercentVisible < threshold && context.newPercentVisible >= threshold {
            UIView.animate(withDuration: duration) {
                context.button.transform = .identity
            }
        } else if context.oldPercentVisible >= threshold && context.newPercentVisible < threshold {
            UIView.animate(withDuration: duration) {
                context.button.transform = .init(scaleX: self.initialScale, y: self.initialScale)
            }
        }
    }
}
