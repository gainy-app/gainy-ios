import UIKit

/**
 The `SwipeCollectionViewCellDelegate` protocol is adopted by
 an object that manages the display of action buttons when the item is swiped.
 */
protocol SwipeCollectionViewCellDelegate: AnyObject {
    /**
     Asks the delegate for the actions to display in response to a swipe in the specified item.

     - parameter collectionView: The collection view object which owns the item requesting this information.

     - parameter indexPath: The index path of the item.

     - parameter orientation: The side of the item requesting this information.

     - returns: An array of `SwipeAction` objects representing the actions for the item.
                Each action you provide is used to create a button that the user can tap.
                Returning `nil` will prevent swiping for the supplied orientation.
     */
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForItemAt indexPath: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> [SwipeAction]?

    /**
     Asks the delegate for the display options to be used while presenting the action buttons.

     - parameter collectionView: The collection view object which owns the item requesting this information.

     - parameter indexPath: The index path of the item.

     - parameter orientation: The side of the item requesting this information.

     - returns: A `SwipeOptions` instance which configures the behavior of the action buttons.

     - note: If not implemented, a default `SwipeOptions` instance is used.
     */
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsOptionsForItemAt indexPath: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> SwipeOptions
}

/**
 Default implementation of `SwipeCollectionViewCellDelegate` methods
 */
extension SwipeCollectionViewCellDelegate {
    func collectionView(
        _: UICollectionView,
        editActionsOptionsForItemAt _: IndexPath,
        for _: SwipeActionsOrientation
    ) -> SwipeOptions {
        SwipeOptions()
    }
}
