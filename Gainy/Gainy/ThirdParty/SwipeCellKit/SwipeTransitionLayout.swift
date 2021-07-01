import UIKit

// MARK: - Layout Protocol

protocol SwipeTransitionLayout {
    func container(view: UIView, didChangeVisibleWidthWithContext context: ActionsViewLayoutContext)
    func layout(view: UIView, atIndex index: Int, with context: ActionsViewLayoutContext)
    func visibleWidthsForViews(with context: ActionsViewLayoutContext) -> [CGFloat]
}

// MARK: - Layout Context

struct ActionsViewLayoutContext {
    // MARK: Lifecycle

    init(numberOfActions: Int, orientation: SwipeActionsOrientation, contentSize: CGSize = .zero, visibleWidth: CGFloat = 0, minimumButtonWidth: CGFloat = 0) {
        self.numberOfActions = numberOfActions
        self.orientation = orientation
        self.contentSize = contentSize
        self.visibleWidth = visibleWidth
        self.minimumButtonWidth = minimumButtonWidth
    }

    // MARK: Internal

    let numberOfActions: Int
    let orientation: SwipeActionsOrientation
    let contentSize: CGSize
    let visibleWidth: CGFloat
    let minimumButtonWidth: CGFloat

    static func newContext(for actionsView: SwipeActionsView) -> ActionsViewLayoutContext {
        ActionsViewLayoutContext(numberOfActions: actionsView.actions.count,
                                 orientation: actionsView.orientation,
                                 contentSize: actionsView.contentSize,
                                 visibleWidth: actionsView.visibleWidth,
                                 minimumButtonWidth: actionsView.minimumButtonWidth)
    }
}

// MARK: - Supported Layout Implementations

class BorderTransitionLayout: SwipeTransitionLayout {
    func container(view _: UIView, didChangeVisibleWidthWithContext _: ActionsViewLayoutContext) {}

    func layout(view: UIView, atIndex index: Int, with context: ActionsViewLayoutContext) {
        let diff = context.visibleWidth - context.contentSize.width
        view.frame.origin.x = (CGFloat(index) * context.contentSize.width / CGFloat(context.numberOfActions) + diff) * context.orientation.scale
    }

    func visibleWidthsForViews(with context: ActionsViewLayoutContext) -> [CGFloat] {
        let diff = context.visibleWidth - context.contentSize.width
        let visibleWidth = context.contentSize.width / CGFloat(context.numberOfActions) + diff

        // visible widths are all the same regardless of the action view position
        return (0..<context.numberOfActions).map { _ in visibleWidth }
    }
}
