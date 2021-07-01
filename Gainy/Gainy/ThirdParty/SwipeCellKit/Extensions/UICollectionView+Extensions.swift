import UIKit

extension UICollectionView {
    var swipeCells: [SwipeCollectionViewCell] {
        visibleCells.compactMap { $0 as? SwipeCollectionViewCell }
    }

    func hideSwipeCell() {
        swipeCells.forEach { $0.hideSwipe(animated: true) }
    }

    func setGestureEnabled(_ enabled: Bool) {
        gestureRecognizers?.forEach {
            guard $0 != panGestureRecognizer else { return }

            $0.isEnabled = enabled
        }
    }
}
