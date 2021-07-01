import UIKit

extension UIScrollView {
    var swipeables: [Swipeable] {
        switch self {
        case let collectionView as UICollectionView:
            return collectionView.swipeCells
        default:
            return []
        }
    }

    func hideSwipeables() {
        switch self {
        case let collectionView as UICollectionView:
            collectionView.hideSwipeCell()
        default:
            return
        }
    }
}
