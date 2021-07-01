import UIKit

/**
 The `SwipeCollectionViewCell` class extends `UICollectionViewCell` and provides more flexible options for cell swiping behavior.


 The default behavior closely matches the stock Mail.app.
 If you want to customize the transition style (ie. how the action buttons are exposed),
 or the expansion style (the behavior when the row is swiped passes a defined threshold),
 you can return the appropriately configured `SwipeOptions` via the `SwipeCollectionViewCellDelegate` delegate.
 */
class SwipeCollectionViewCell: RoundedCollectionViewCell {
    // MARK: Lifecycle

    /// :nodoc:
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    /// :nodoc:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    deinit {
        collectionView?.panGestureRecognizer.removeTarget(self, action: nil)
    }

    // MARK: Open

    /// :nodoc:
    override open var frame: CGRect {
        set { super.frame = state.isActive ? CGRect(origin: CGPoint(x: frame.minX, y: newValue.minY), size: newValue.size) : newValue }
        get { super.frame }
    }

    /// :nodoc:
    override open var isHighlighted: Bool {
        set {
            guard state == .center else { return }
            super.isHighlighted = newValue
        }
        get { super.isHighlighted }
    }

    /// :nodoc:
    override open var layoutMargins: UIEdgeInsets {
        get {
            frame.origin.x != 0 ? swipeController.originalLayoutMargins : super.layoutMargins
        }
        set {
            super.layoutMargins = newValue
        }
    }

    /// :nodoc:
    override open func prepareForReuse() {
        super.prepareForReuse()

        reset()
        resetSelectedState()
    }

    /// :nodoc:
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()

        var view: UIView = self
        while let superview = view.superview {
            view = superview

            if let collectionView = view as? UICollectionView {
                self.collectionView = collectionView

                swipeController.scrollView = scrollView

                collectionView.panGestureRecognizer.removeTarget(self, action: nil)
                collectionView.panGestureRecognizer.addTarget(self, action: #selector(handleCollectionPan(gesture:)))
                return
            }
        }
    }

    /// :nodoc:
    override open func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)

        if newWindow == nil {
            reset()
        }
    }

    // Override so we can accept touches anywhere within the cell's original frame.
    // This is required to detect touches on the `SwipeActionsView` sitting alongside the
    // `SwipeCollectionViewCell`.
    /// :nodoc:
    override open func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        guard let superview = superview else { return false }

        let point = convert(point, to: superview)

        if !UIAccessibility.isVoiceOverRunning {
            for cell in collectionView?.swipeCells ?? [] {
                if (cell.state == .left || cell.state == .right) && !cell.contains(point: point) {
                    collectionView?.hideSwipeCell()
                    return false
                }
            }
        }

        return contains(point: point)
    }

    // Override hitTest(_:with:) here so that we can make sure our `actionsView` gets the touch event
    //   if it's supposed to, since otherwise, our `contentView` will swallow it and pass it up to
    //   the collection view.
    /// :nodoc:
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard
            let actionsView = actionsView,
            isHidden == false
        else { return super.hitTest(point, with: event) }

        let modifiedPoint = actionsView.convert(point, from: self)
        return actionsView.hitTest(modifiedPoint, with: event) ?? super.hitTest(point, with: event)
    }

    /// :nodoc:
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        swipeController.gestureRecognizerShouldBegin(gestureRecognizer)
    }

    /// :nodoc:
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        swipeController.traitCollectionDidChange(from: previousTraitCollection, to: self.traitCollection)
    }

    // MARK: Internal

    /// The object that acts as the delegate of the `SwipeCollectionViewCell`.
    weak var delegate: SwipeCollectionViewCellDelegate?

    var state = SwipeState.center
    var actionsView: SwipeActionsView?
    var swipeController: SwipeController!
    var isPreviouslySelected = false

    weak var collectionView: UICollectionView?

    var scrollView: UIScrollView? {
        collectionView
    }

    var indexPath: IndexPath? {
        collectionView?.indexPath(for: self)
    }

    var panGestureRecognizer: UIGestureRecognizer
    {
        swipeController.panGestureRecognizer
    }

    func configure() {
        contentView.clipsToBounds = false

        if contentView.translatesAutoresizingMaskIntoConstraints == true {
            contentView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                contentView.topAnchor.constraint(equalTo: self.topAnchor),
                contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }

        swipeController = SwipeController(swipeable: self, actionsContainerView: contentView)
        swipeController.delegate = self
    }

    func contains(point: CGPoint) -> Bool {
        frame.contains(point)
    }

    @objc
    func handleCollectionPan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            hideSwipe(animated: true)
        }
    }

    func reset() {
        contentView.clipsToBounds = false
        swipeController.reset()
        collectionView?.setGestureEnabled(true)
    }

    func resetSelectedState() {
        if isPreviouslySelected {
            if let collectionView = collectionView, let indexPath = collectionView.indexPath(for: self) {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            }
        }
        isPreviouslySelected = false
    }
}

extension SwipeCollectionViewCell: SwipeControllerDelegate {
    func swipeController(_: SwipeController, canBeginEditingSwipeableFor _: SwipeActionsOrientation) -> Bool {
        true
    }

    func swipeController(_: SwipeController, editActionsForSwipeableFor orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard let collectionView = collectionView, let indexPath = collectionView.indexPath(for: self) else { return nil }

        return delegate?.collectionView(collectionView, editActionsForItemAt: indexPath, for: orientation)
    }

    func swipeController(_: SwipeController, editActionsOptionsForSwipeableFor orientation: SwipeActionsOrientation) -> SwipeOptions {
        guard let collectionView = collectionView, let indexPath = collectionView.indexPath(for: self) else { return SwipeOptions() }

        return delegate?.collectionView(collectionView, editActionsOptionsForItemAt: indexPath, for: orientation) ?? SwipeOptions()
    }

    func swipeController(_: SwipeController, visibleRectFor _: UIScrollView) -> CGRect? {
        guard let collectionView = collectionView else { return nil }

        return delegate?.visibleRect(for: collectionView)
    }

    func swipeController(_: SwipeController, willBeginEditingSwipeableFor orientation: SwipeActionsOrientation) {
        guard let collectionView = collectionView, let indexPath = collectionView.indexPath(for: self) else { return }

        // Remove highlight and deselect any selected cells
        super.isHighlighted = false
        isPreviouslySelected = isSelected
        collectionView.deselectItem(at: indexPath, animated: false)

        delegate?.collectionView(collectionView, willBeginEditingItemAt: indexPath, for: orientation)
    }

    func swipeController(_: SwipeController, didEndEditingSwipeableFor _: SwipeActionsOrientation) {
        guard let collectionView = collectionView, let indexPath = collectionView.indexPath(for: self), let actionsView = self.actionsView else { return }

        resetSelectedState()

        delegate?.collectionView(collectionView, didEndEditingItemAt: indexPath, for: actionsView.orientation)
    }

    func swipeController(_: SwipeController, didDeleteSwipeableAt indexPath: IndexPath) {
        collectionView?.deleteItems(at: [indexPath])
    }
}
