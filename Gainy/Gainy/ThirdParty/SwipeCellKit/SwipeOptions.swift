import UIKit

/// :nodoc:
typealias SwipeTableOptions = SwipeOptions

/// The `SwipeOptions` class provides options for transistion and expansion behavior for swiped cell.
struct SwipeOptions {
    // MARK: Lifecycle

    /// Constructs a new `SwipeOptions` instance with default options.
    init() {}

    // MARK: Internal

    /// The transition style. Transition is the style of how the action buttons are exposed during the swipe.
    var transitionStyle: SwipeTransitionStyle = .border

    /// The expansion style. Expansion is the behavior when the cell is swiped past a defined threshold.
    var expansionStyle: SwipeExpansionStyle?

    /// The object that is notified when expansion changes.
    ///
    /// - note: If an `expansionDelegate` is not provided, and the expanding action is configured
    ///         with a clear background, the system automatically uses the default
    ///         `ScaleAndAlphaExpansion` to show/hide underlying actions.
    var expansionDelegate: SwipeExpanding?

    /// The background color behind the action buttons.
    var backgroundColor: UIColor?

    /// The largest allowable button width.
    ///
    /// - note: By default, the value is set to the table/collection view divided by the number
    ///         of action buttons minus some additional padding.
    ///         If the value is set to 0, then word wrapping will not occur and the buttons will grow
    ///         as large as needed to fit the entire title/image.
    var maximumButtonWidth: CGFloat?

    /// The smallest allowable button width.
    ///
    /// - note: By default, the system chooses an appropriate size.
    var minimumButtonWidth: CGFloat?

    /// The vertical alignment mode used for when a button image and title are present.
    var buttonVerticalAlignment: SwipeVerticalAlignment = .center

    /// The amount of space, in points, between the border and the button image or title.
    var buttonPadding: CGFloat?
}

/// Describes the transition style. Transition is the style of how the action buttons are exposed during the swipe.
enum SwipeTransitionStyle {
    /// The visible action area is equally divide between all action buttons.
    case border
}

/// Describes which side of the cell that the action buttons will be displayed.
enum SwipeActionsOrientation: CGFloat {
    /// The left side of the cell.
    case left = -1

    /// The right side of the cell.
    case right = 1

    // MARK: Internal

    var scale: CGFloat {
        rawValue
    }
}

/// Describes the alignment mode used when action button images and titles are provided.
enum SwipeVerticalAlignment {
    /// The action button image height and full title height are used to create the aligment rectange.
    ///
    /// - note: Buttons with varying number of lines will not be consistently aligned across the swipe view.
    case center
}
