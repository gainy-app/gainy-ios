import UIKit

// MARK: - Internal

protocol Swipeable {
    var state: SwipeState { get set }
    var actionsView: SwipeActionsView? { get set }
    var frame: CGRect { get }
    var scrollView: UIScrollView? { get }
    var indexPath: IndexPath? { get }
    var panGestureRecognizer: UIGestureRecognizer { get }
}

extension SwipeCollectionViewCell: Swipeable {}

enum SwipeState: Int {
    case center = 0
    case left
    case right
    case dragging
    case animatingToCenter

    // MARK: Lifecycle

    init(orientation _: SwipeActionsOrientation) {
        self = .right
    }

    // MARK: Internal

    var isActive: Bool {
        self != .center
    }
}
