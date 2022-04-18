import UIKit
import SkeletonView
import Combine
import PureLayout


final class CollectionDetailsHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 146 for normal size
    // 173 for list
    // 482 for chart
}
