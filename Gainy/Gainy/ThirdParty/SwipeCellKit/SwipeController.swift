import Foundation
import UIKit

protocol SwipeControllerDelegate: AnyObject {
    func swipeController(
        _ controller: SwipeController,
        canBeginEditingSwipeableFor orientation: SwipeActionsOrientation
    ) -> Bool

    func swipeController(
        _ controller: SwipeController,
        editActionsForSwipeableFor orientation: SwipeActionsOrientation
    ) -> [SwipeAction]?

    func swipeController(
        _ controller: SwipeController,
        editActionsOptionsForSwipeableFor orientation: SwipeActionsOrientation
    ) -> SwipeOptions
}

class SwipeController: NSObject {
    // MARK: Lifecycle

    init(swipeable: UIView & Swipeable, actionsContainerView: UIView) {
        self.swipeable = swipeable
        self.actionsContainerView = actionsContainerView

        super.init()

        configure()
    }

    // MARK: Internal

    weak var swipeable: (UIView & Swipeable)?
    weak var actionsContainerView: UIView?

    weak var delegate: SwipeControllerDelegate?
    weak var scrollView: UIScrollView?

    var animator: SwipeAnimator?

    let elasticScrollRatio: CGFloat = 0.4

    var originalCenter: CGFloat = 0
    var scrollRatio: CGFloat = 1.0
    var originalLayoutMargins: UIEdgeInsets = .zero

    lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        gesture.delegate = self
        return gesture
    }()

    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        gesture.delegate = self
        return gesture
    }()

    @objc
    func handlePan(gesture: UIPanGestureRecognizer) {
        guard let target = actionsContainerView, var swipeable = self.swipeable else { return }

        let velocity = gesture.velocity(in: target)

        if delegate?.swipeController(
            self,
            canBeginEditingSwipeableFor: velocity.x > 0 ? .left : .right
        ) == false {
            return
        }

        switch gesture.state {
        case .began:
            if let swipeable = scrollView?
                .swipeables
                .first(where: { $0.state == .dragging }) as? UIView,
                self.swipeable != nil,
                swipeable != self.swipeable! {
                return
            }

            stopAnimatorIfNeeded()

            originalCenter = target.center.x

            if swipeable.state == .center || swipeable.state == .animatingToCenter {
                let orientation: SwipeActionsOrientation = velocity.x > 0 ? .left : .right

                showActionsView(for: orientation)
            }
        case .changed:
            guard
                let actionsView = swipeable.actionsView,
                let actionsContainerView = self.actionsContainerView,
                swipeable.state.isActive
            else {
                return
            }

            if swipeable.state == .animatingToCenter {
                let swipedCell = scrollView?
                    .swipeables
                    .first { $0.state == .dragging || $0.state == .right } as? UIView

                if let swipedCell = swipedCell,
                   self.swipeable != nil,
                   swipedCell != self.swipeable! {
                    return
                }
            }

            let translation = gesture.translation(in: target).x
            scrollRatio = 1.0

            // Check if dragging past the center of the opposite direction of action view, if so
            // then we need to apply elasticity
            if (translation + originalCenter - swipeable.bounds.midX) * actionsView.orientation.scale > 0 {
                target.center.x = gesture.elasticTranslation(in: target,
                                                             withLimit: .zero,
                                                             fromOriginalCenter: CGPoint(x: originalCenter,
                                                                                         y: 0)).x
                swipeable.actionsView?.visibleWidth = abs((swipeable as Swipeable).frame.minX)
                scrollRatio = elasticScrollRatio
                return
            }

            target.center.x = gesture.elasticTranslation(
                in: target,
                withLimit: CGSize(width: actionsView.preferredWidth, height: 0),
                fromOriginalCenter: CGPoint(x: originalCenter, y: 0),
                applyingRatio: elasticScrollRatio
            ).x
            swipeable.actionsView?.visibleWidth = abs(actionsContainerView.frame.minX)

            if (target.center.x - originalCenter) / translation != 1.0 {
                scrollRatio = elasticScrollRatio
            }
        case .ended, .cancelled, .failed:
            guard let actionsContainerView = self.actionsContainerView else { return }
            if swipeable.state.isActive == false && swipeable.bounds.midX == target.center.x {
                return
            }

            swipeable.state = targetState(forVelocity: velocity)

            let targetOffset = targetCenter(active: swipeable.state.isActive)
            let distance = targetOffset - actionsContainerView.center.x
            let normalizedVelocity = velocity.x * scrollRatio / distance

            animate(toOffset: targetOffset, withInitialVelocity: normalizedVelocity) { _ in
                if self.swipeable?.state == .center {
                    self.reset()
                }
            }
        default: break
        }
    }

    @discardableResult
    func showActionsView(for orientation: SwipeActionsOrientation) -> Bool {
        guard let actions = delegate?.swipeController(self,
                                                      editActionsForSwipeableFor: orientation),
            !actions.isEmpty
        else {
            return false
        }
        guard let swipeable = self.swipeable else { return false }

        originalLayoutMargins = swipeable.layoutMargins

        configureActionsView(with: actions, for: orientation)

        return true
    }

    func configureActionsView(with actions: [SwipeAction], for orientation: SwipeActionsOrientation) {
        guard var swipeable = self.swipeable,
              let actionsContainerView = self.actionsContainerView,
              let scrollView = self.scrollView else {
            return
        }

        let options = delegate?
            .swipeController(self, editActionsOptionsForSwipeableFor: orientation) ?? SwipeOptions()

        swipeable.actionsView?.removeFromSuperview()
        swipeable.actionsView = nil

        let contentEdgeInsets = UIEdgeInsets.zero

        let actionsView = SwipeActionsView(contentEdgeInsets: contentEdgeInsets,
                                           maxSize: swipeable.bounds.size,
                                           safeAreaInsetView: scrollView,
                                           options: options,
                                           orientation: orientation,
                                           actions: actions)
        actionsView.delegate = self

        actionsContainerView.addSubview(actionsView)

        actionsView.heightAnchor.constraint(equalTo: swipeable.heightAnchor).isActive = true
        actionsView.widthAnchor.constraint(equalTo: swipeable.widthAnchor, multiplier: 2).isActive = true
        actionsView.topAnchor.constraint(equalTo: swipeable.topAnchor).isActive = true
        actionsView.leftAnchor.constraint(equalTo: actionsContainerView.rightAnchor).isActive = true

        actionsView.setNeedsUpdateConstraints()

        swipeable.actionsView = actionsView

        swipeable.state = .dragging
    }

    func animate(
        toOffset offset: CGFloat,
        duration: Double = 0.7,
        withInitialVelocity velocity: CGFloat = 0,
        completion: ((Bool) -> Void)? = nil
    ) {
        stopAnimatorIfNeeded()

        swipeable?.layoutIfNeeded()

        let animator: SwipeAnimator = {
            if velocity != 0 {
                let velocity = CGVector(dx: velocity, dy: velocity)
                let parameters = UISpringTimingParameters(
                    mass: 1.0,
                    stiffness: 100,
                    damping: 18,
                    initialVelocity: velocity
                )
                return UIViewPropertyAnimator(duration: 0.0, timingParameters: parameters)
            } else {
                return UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0)
            }
        }()

        animator.addAnimations {
            guard let swipeable = self.swipeable, let actionsContainerView = self.actionsContainerView else { return }

            actionsContainerView.center = CGPoint(x: offset, y: actionsContainerView.center.y)
            swipeable.actionsView?.visibleWidth = abs(actionsContainerView.frame.minX)
            swipeable.layoutIfNeeded()
        }

        if let completion = completion {
            animator.addCompletion(completion: completion)
        }

        self.animator = animator

        animator.startAnimation()
    }

    func stopAnimatorIfNeeded() {
        if animator?.isRunning == true {
            animator?.stopAnimation(true)
        }
    }

    @objc
    func handleTap(gesture _: UITapGestureRecognizer) {
        hideSwipe(animated: true)
    }

    func targetState(forVelocity velocity: CGPoint) -> SwipeState {
        guard let actionsView = swipeable?.actionsView else { return .center }

        return (velocity.x > 0 && !actionsView.expanded) ? .center : .right
    }

    func targetCenter(active: Bool) -> CGFloat {
        guard let swipeable = self.swipeable else { return 0 }
        guard let actionsView = swipeable.actionsView, active == true else { return swipeable.bounds.midX }

        return swipeable.bounds.midX - actionsView.preferredWidth * actionsView.orientation.scale
    }

    func configure() {
        swipeable?.addGestureRecognizer(tapGestureRecognizer)
        swipeable?.addGestureRecognizer(panGestureRecognizer)
    }

    func reset() {
        swipeable?.state = .center

        swipeable?.actionsView?.removeFromSuperview()
        swipeable?.actionsView = nil
    }
}

extension SwipeController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == tapGestureRecognizer {
            if UIAccessibility.isVoiceOverRunning {
                scrollView?.hideSwipeables()
            }

            let swipedCell = scrollView?.swipeables.first {
                $0.state.isActive ||
                    $0.panGestureRecognizer.state == .began ||
                    $0.panGestureRecognizer.state == .changed ||
                    $0.panGestureRecognizer.state == .ended
            }
            return swipedCell == nil ? false : true
        }

        if gestureRecognizer == panGestureRecognizer,
           let view = gestureRecognizer.view,
           let gestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer {
            let translation = gestureRecognizer.translation(in: view)
            return abs(translation.y) <= abs(translation.x)
        }

        return true
    }
}

extension SwipeController: SwipeActionsViewDelegate {
    func swipeActionsView(_: SwipeActionsView, didSelect action: SwipeAction) {
        perform(action: action)
    }

    func perform(action: SwipeAction) {
        perform(action: action, hide: action.hidesWhenSelected)
    }

    func perform(action: SwipeAction, hide: Bool) {
        guard let indexPath = swipeable?.indexPath else { return }

        if hide {
            hideSwipe(animated: true)
        }

        action.handler?(action, indexPath)
    }

    func hideSwipe(animated: Bool, completion: ((Bool) -> Void)? = nil) {
        guard var swipeable = self.swipeable, let actionsContainerView = self.actionsContainerView else { return }
        guard swipeable.state == .left || swipeable.state == .right else { return }
        guard let _ = swipeable.actionsView else { return }

        swipeable.state = .animatingToCenter

        let targetCenter = self.targetCenter(active: false)

        if animated {
            animate(toOffset: targetCenter) { complete in
                self.reset()
                completion?(complete)
            }
        } else {
            actionsContainerView.center = CGPoint(x: targetCenter, y: actionsContainerView.center.y)
            swipeable.actionsView?.visibleWidth = abs(actionsContainerView.frame.minX)
            reset()
        }
    }

    func setSwipeOffset(_ offset: CGFloat, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard var swipeable = self.swipeable, let actionsContainerView = self.actionsContainerView else { return }

        guard offset != 0 else {
            hideSwipe(animated: animated, completion: completion)
            return
        }

        let orientation: SwipeActionsOrientation = offset > 0 ? .left : .right
        let targetState = SwipeState(orientation: orientation)

        if swipeable.state != targetState {
            guard showActionsView(for: orientation) else { return }

            scrollView?.hideSwipeables()

            swipeable.state = targetState
        }

        let maxOffset = min(swipeable.bounds.width, abs(offset)) * orientation.scale * -1
        let targetCenter = abs(offset) == CGFloat.greatestFiniteMagnitude
            ? self.targetCenter(active: true)
            : swipeable.bounds.midX + maxOffset

        if animated {
            animate(toOffset: targetCenter) { complete in
                completion?(complete)
            }
        } else {
            actionsContainerView.center.x = targetCenter
            swipeable.actionsView?.visibleWidth = abs(actionsContainerView.frame.minX)
        }
    }
}
