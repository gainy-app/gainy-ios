import UIKit

/// Describes the expansion style.  Expansion is the behavior when the cell is swiped past a defined threshold.
struct SwipeExpansionStyle {
    // MARK: Lifecycle

    /**
     Contructs a new `SwipeExpansionStyle` instance.

     - parameter target: The relative target expansion threshold. Expansion will occur at the specified value.

     - parameter additionalTriggers: Additional triggers to useful for determining if expansion should occur.

     - parameter elasticOverscroll: Specifies if buttons should expand to fully fill overscroll, or expand at a percentage relative to the overscroll.

     - parameter completionAnimation: Specifies the expansion animation completion style.

     - returns: The new `SwipeExpansionStyle` instance.
     */
    init(target: Target, additionalTriggers: [Trigger] = [], elasticOverscroll: Bool = false, completionAnimation: CompletionAnimation = .bounce) {
        self.target = target
        self.additionalTriggers = additionalTriggers
        self.elasticOverscroll = elasticOverscroll
        self.completionAnimation = completionAnimation
    }

    // MARK: Internal

    /// The relative target expansion threshold. Expansion will occur at the specified value.
    let target: Target

    /// Additional triggers to useful for determining if expansion should occur.
    let additionalTriggers: [Trigger]

    /// Specifies if buttons should expand to fully fill overscroll, or expand at a percentage relative to the overscroll.
    let elasticOverscroll: Bool

    /// Specifies the expansion animation completion style.
    let completionAnimation: CompletionAnimation

    /// Specifies the minimum amount of overscroll required if the configured target is less than the fully exposed action view.
    var minimumTargetOverscroll: CGFloat = 20

    /// The amount of elasticity applied when dragging past the expansion target.
    ///
    /// - note: Default value is 0.2.
    ///         Valid range is from 0.0 for no movement past the expansion target,
    ///         to 1.0 for unrestricted movement with dragging.
    var targetOverscrollElasticity: CGFloat = 0.2

    var minimumExpansionTranslation: CGFloat = 8.0

    func shouldExpand(view: Swipeable, gesture: UIPanGestureRecognizer, in superview: UIView, within frame: CGRect? = nil) -> Bool {
        guard let actionsView = view.actionsView, let gestureView = gesture.view else { return false }
        guard abs(gesture.translation(in: gestureView).x) > minimumExpansionTranslation else { return false }

        let xDelta = floor(abs(frame?.minX ?? view.frame.minX))
        if xDelta <= actionsView.preferredWidth {
            return false
        } else if xDelta > targetOffset(for: view) {
            return true
        }

        // Use the frame instead of superview as Swipeable may not be full width of superview
        let referenceFrame: CGRect = frame != nil ? view.frame : superview.bounds
        for trigger in additionalTriggers {
            if trigger.isTriggered(view: view, gesture: gesture, in: superview, referenceFrame: referenceFrame) {
                return true
            }
        }

        return false
    }

    func targetOffset(for view: Swipeable) -> CGFloat {
        target.offset(for: view, minimumOverscroll: minimumTargetOverscroll)
    }
}

extension SwipeExpansionStyle {
    /// Describes the relative target expansion threshold. Expansion will occur at the specified value.
    enum Target {
        /// The target is specified by a percentage.
        case percentage(CGFloat)

        /// The target is specified by a edge inset.
        case edgeInset(CGFloat)

        // MARK: Internal

        func offset(for view: Swipeable, minimumOverscroll: CGFloat) -> CGFloat {
            guard let actionsView = view.actionsView else { return .greatestFiniteMagnitude }

            let offset: CGFloat = {
                switch self {
                case .percentage(let value):
                    return view.frame.width * value
                case .edgeInset(let value):
                    return view.frame.width - value
                }
            }()

            return max(actionsView.preferredWidth + minimumOverscroll, offset)
        }
    }

    /// Describes additional triggers to useful for determining if expansion should occur.
    enum Trigger {
        /// The trigger is specified by a touch occuring past the supplied percentage in the superview.
        case touchThreshold(CGFloat)

        /// The trigger is specified by the distance in points past the fully exposed action view.
        case overscroll(CGFloat)

        // MARK: Internal

        func isTriggered(view: Swipeable, gesture: UIPanGestureRecognizer, in superview: UIView, referenceFrame: CGRect) -> Bool {
            guard let actionsView = view.actionsView else { return false }

            switch self {
            case .touchThreshold(let value):
                let location = gesture.location(in: superview).x - referenceFrame.origin.x
                let locationRatio = (referenceFrame.width - location) / referenceFrame.width
                return locationRatio > value
            case .overscroll(let value):
                return abs(view.frame.minX) > actionsView.preferredWidth + value
            }
        }
    }

    /// Describes the expansion animation completion style.
    enum CompletionAnimation {
        /// The expansion will completely fill the item.
        case fill(FillOptions)

        /// The expansion will bounce back from the trigger point and hide the action view, resetting the item.
        case bounce
    }

    /// Specifies the options for the fill completion animation.
    struct FillOptions {
        /// Describes when the action handler will be invoked with respect to the fill animation.
        enum HandlerInvocationTiming {
            /// The action handler is invoked with the fill animation.
            case with

            /// The action handler is invoked after the fill animation completes.
            case after
        }

        /// The fulfillment style describing how expansion should be resolved once the action has been fulfilled.
        let autoFulFillmentStyle: ExpansionFulfillmentStyle?

        /// The timing which specifies when the action handler will be invoked with respect to the fill animation.
        let timing: HandlerInvocationTiming

        /**
         Returns a `FillOptions` instance with automatic fulfillemnt.

         - parameter style: The fulfillment style describing how expansion should be resolved once the action has been fulfilled.

         - parameter timing: The timing which specifies when the action handler will be invoked with respect to the fill animation.

         - returns: The new `FillOptions` instance.
         */
        static func automatic(_ style: ExpansionFulfillmentStyle, timing: HandlerInvocationTiming) -> FillOptions {
            FillOptions(autoFulFillmentStyle: style, timing: timing)
        }

        /**
         Returns a `FillOptions` instance with manual fulfillemnt.

         - parameter timing: The timing which specifies when the action handler will be invoked with respect to the fill animation.

         - returns: The new `FillOptions` instance.
         */
        static func manual(timing: HandlerInvocationTiming) -> FillOptions {
            FillOptions(autoFulFillmentStyle: nil, timing: timing)
        }
    }
}

extension SwipeExpansionStyle.Target: Equatable {
    /// :nodoc:
    static func == (lhs: SwipeExpansionStyle.Target, rhs: SwipeExpansionStyle.Target) -> Bool {
        switch (lhs, rhs) {
        case (.percentage(let lhs), .percentage(let rhs)):
            return lhs == rhs
        case (.edgeInset(let lhs), .edgeInset(let rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

extension SwipeExpansionStyle.CompletionAnimation: Equatable {
    /// :nodoc:
    static func == (lhs: SwipeExpansionStyle.CompletionAnimation, rhs: SwipeExpansionStyle.CompletionAnimation) -> Bool {
        switch (lhs, rhs) {
        case (.fill, .fill):
            return true
        case (.bounce, .bounce):
            return true
        default:
            return false
        }
    }
}
