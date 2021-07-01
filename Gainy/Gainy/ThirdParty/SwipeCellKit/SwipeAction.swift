import UIKit

/// Constants that help define the appearance of action buttons.
enum SwipeActionStyle: Int {
    /// Apply a style that reflects standard non-destructive actions.
    case `default`
}

/**
 The `SwipeAction` object defines a single action to present when the user swipes horizontally in a table/collection item.

 This class lets you define one or more custom actions to display for a given item in your table/collection.
 Each instance of this class represents a single action to perform and includes the text, formatting information,
 and behavior for the corresponding button.
 */
class SwipeAction: NSObject {
    // MARK: Lifecycle

    /**
      Constructs a new `SwipeAction` instance.

      - parameter style: The style of the action button.
      - parameter handler: The closure to execute when the user taps the button associated with this action.
     */
    init(style: SwipeActionStyle, handler: ((SwipeAction, IndexPath) -> Void)?) {
//        self.title = title
        self.style = style
        self.handler = handler
    }

    // MARK: Internal

    /// An optional unique action identifier.
    var identifier: String?

//    /// The title of the action button.
//    ///
//    /// - note: You must specify a title or an image.
//    var title: String?

    /// The style applied to the action button.
    var style: SwipeActionStyle

//    /// The object that is notified as transitioning occurs.
//    var transitionDelegate: SwipeActionTransitioning?

//    /// The font to use for the title of the action button.
//    ///
//    /// - note: If you do not specify a font, a 15pt system font is used.
//    var font: UIFont?

//    /// The text color of the action button.
//    ///
//    /// - note: If you do not specify a color, white is used.
//    var textColor: UIColor?

//    /// The highlighted text color of the action button.
//    ///
//    /// - note: If you do not specify a color, `textColor` is used.
//    var highlightedTextColor: UIColor?

    /// The image used for the action button.
    ///
    /// - note: You must specify a title or an image.
    var image: UIImage?

    /// The highlighted image used for the action button.
    ///
    /// - note: If you do not specify a highlight image, the default `image` is used for the highlighted state.
    var highlightedImage: UIImage?

    /// The closure to execute when the user taps the button associated with this action.
    var handler: ((SwipeAction, IndexPath) -> Void)?

    /// The background color of the action button.
    ///
    /// - note: Use this property to specify the background color for your button.
    ///         If you do not specify a value for this property, the framework assigns a default color based on the value in the style property.
    var backgroundColor: UIColor?

//    /// The visual effect to apply to the action button.
//    ///
//    /// - note: Assigning a visual effect object to this property adds that effect to the background of the action button.
//    var backgroundEffect: UIVisualEffect?

    /// A Boolean value that determines whether the actions menu is automatically hidden upon selection.
    ///
    /// - note: When set to `true`, the actions menu is automatically hidden when the action is selected. The default value is `false`.
    var hidesWhenSelected = false

    var completionHandler: ((ExpansionFulfillmentStyle) -> Void)?

    /**
     Calling this method performs the configured expansion completion animation including deletion, if necessary. Calling this method more than once has no effect.

     You should only call this method from the implementation of your action `handler` method.

     - parameter style: The desired style for completing the expansion action.
     */
    func fulfill(with style: ExpansionFulfillmentStyle) {
        completionHandler?(style)
    }
}

/// Describes how expansion should be resolved once the action has been fulfilled.
enum ExpansionFulfillmentStyle {
    /// Implies the item will be deleted upon action fulfillment.
    case delete

//    /// Implies the item will be reset and the actions view hidden upon action fulfillment.
//    case reset
}

// MARK: - Internal

extension SwipeAction {
    var hasBackgroundColor: Bool {
        backgroundColor != .clear
    }
}
