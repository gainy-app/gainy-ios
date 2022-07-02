import UIKit

protocol SwipeActionsViewDelegate: AnyObject {
    func swipeActionsView(_ swipeActionsView: SwipeActionsView, didSelect action: SwipeAction)
}

class SwipeActionsView: UIView {
    // MARK: Lifecycle

    init(contentEdgeInsets: UIEdgeInsets,
         maxSize: CGSize,
         safeAreaInsetView: UIView,
         options: SwipeOptions,
         orientation: SwipeActionsOrientation,
         actions: [SwipeAction]) {
        self.safeAreaInsetView = safeAreaInsetView
        self.options = options
        self.orientation = orientation
        self.actions = actions.reversed()

        switch options.transitionStyle {
        case .border:
            transitionLayout = BorderTransitionLayout()
        }

        self.layoutContext = ActionsViewLayoutContext(numberOfActions: actions.count,
                                                      orientation: orientation)

        super.init(frame: .zero)

        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false


        fillRemoteBack()

        buttons = addButtons(for: self.actions,
                             withMaximum: maxSize,
                             contentEdgeInsets: contentEdgeInsets)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    weak var delegate: SwipeActionsViewDelegate?

    let transitionLayout: SwipeTransitionLayout
    var layoutContext: ActionsViewLayoutContext

    var expansionAnimator: SwipeAnimator?

    weak var safeAreaInsetView: UIView?
    let orientation: SwipeActionsOrientation
    let actions: [SwipeAction]
    let options: SwipeOptions

    var buttons: [SwipeActionButton] = []

    var minimumButtonWidth: CGFloat = 0
    private(set) var expanded = false

    var maximumImageHeight: CGFloat {
        actions.reduce(0) { initial, next in
            max(initial, next.image?.size.height ?? 0)
        }
    }

    var safeAreaMargin: CGFloat {
        guard let scrollView = self.safeAreaInsetView else {
            return 0
        }

        return scrollView.safeAreaInsets.right
    }

    var visibleWidth: CGFloat = 0 {
        didSet {
            // If necessary, adjust for safe areas
            visibleWidth = max(0, visibleWidth - safeAreaMargin)

            layoutContext = ActionsViewLayoutContext.newContext(for: self)

            transitionLayout.container(view: self, didChangeVisibleWidthWithContext: layoutContext)

            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    var preferredWidth: CGFloat {
        minimumButtonWidth * CGFloat(actions.count) + safeAreaMargin
    }

    var contentSize: CGSize {
        CGSize(width: visibleWidth, height: bounds.height)
    }

    func addButtons(
        for actions: [SwipeAction],
        withMaximum size: CGSize,
        contentEdgeInsets: UIEdgeInsets
    ) -> [SwipeActionButton] {
        let buttons: [SwipeActionButton] = actions.map { action in
            let actionButton = SwipeActionButton(action: action)
            actionButton.addTarget(self,
                                   action: #selector(actionTapped(button:)),
                                   for: .touchUpInside)
            actionButton.autoresizingMask = [
                .flexibleHeight,
                orientation == .right ? .flexibleRightMargin : .flexibleLeftMargin,
            ]
            actionButton.contentEdgeInsets = buttonEdgeInsets(fromOptions: options)
            return actionButton
        }

        let maximum = options.maximumButtonWidth ?? (size.width - 30) / CGFloat(actions.count)
        let minimum = options.minimumButtonWidth ?? min(maximum, 74)
        minimumButtonWidth = buttons.reduce(minimum) { initial, next in
            max(initial, next.preferredWidth(maximum: maximum))
        }

        buttons.enumerated().forEach { index, button in
            let action = actions[index]
            let frame = CGRect(origin: .zero,
                               size: CGSize(width: bounds.width, height: bounds.height))
            let wrapperView = SwipeActionButtonWrapperView(frame: frame,
                                                           action: action,
                                                           orientation: orientation,
                                                           contentWidth: minimumButtonWidth)
            wrapperView.translatesAutoresizingMaskIntoConstraints = false
            wrapperView.addSubview(button)

            addSubview(wrapperView)

            button.frame = wrapperView.contentRect
            button.maximumImageHeight = maximumImageHeight
            button.verticalAlignment = options.buttonVerticalAlignment

            wrapperView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            wrapperView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

            let topConstraint = wrapperView.topAnchor.constraint(equalTo: topAnchor,
                                                                 constant: contentEdgeInsets.top)
            topConstraint.priority = contentEdgeInsets.top == 0 ? .required : .defaultHigh
            topConstraint.isActive = true

            let bottomConstraint = wrapperView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                       constant: -1 * contentEdgeInsets.bottom)
            bottomConstraint.priority = contentEdgeInsets.bottom == 0 ? .required : .defaultHigh
            bottomConstraint.isActive = true

            if contentEdgeInsets != .zero {
                let heightConstraint = wrapperView
                    .heightAnchor
                    .constraint(greaterThanOrEqualToConstant: button.intrinsicContentSize.height)
                heightConstraint.priority = .required
                heightConstraint.isActive = true
            }
        }
        return buttons
    }

    @objc
    func actionTapped(button: SwipeActionButton) {
        guard let index = buttons.firstIndex(of: button) else { return }

        delegate?.swipeActionsView(self, didSelect: actions[index])
    }

    func buttonEdgeInsets(fromOptions _: SwipeOptions) -> UIEdgeInsets {
        let padding: CGFloat = 8
        return UIEdgeInsets(
            top: padding,
            left: padding,
            bottom: padding,
            right: padding
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        for subview in subviews.enumerated() {
            transitionLayout.layout(view: subview.element, atIndex: subview.offset, with: layoutContext)
        }

        if expanded {
            subviews.last?.frame.origin.x = 0 + bounds.origin.x
        }
    }
}

class SwipeActionButtonWrapperView: UIView {
    // MARK: Lifecycle

    init(frame: CGRect, action: SwipeAction, orientation _: SwipeActionsOrientation, contentWidth: CGFloat) {
        contentRect = CGRect(x: 0, y: 0, width: contentWidth, height: frame.height)

        super.init(frame: frame)

        configureBackgroundColor(with: action)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let contentRect: CGRect
    var actionBackgroundColor: UIColor?

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        if let actionBackgroundColor = self.actionBackgroundColor, let context = UIGraphicsGetCurrentContext() {
            actionBackgroundColor.setFill()
            context.fill(rect)
        }
    }

    func configureBackgroundColor(with action: SwipeAction) {
        guard action.hasBackgroundColor else {
            isOpaque = false
            return
        }

        if let backgroundColor = action.backgroundColor {
            actionBackgroundColor = backgroundColor
        } else {
            switch action.style {
            default:
                actionBackgroundColor = UIColor.clear
            }
        }
    }
}
