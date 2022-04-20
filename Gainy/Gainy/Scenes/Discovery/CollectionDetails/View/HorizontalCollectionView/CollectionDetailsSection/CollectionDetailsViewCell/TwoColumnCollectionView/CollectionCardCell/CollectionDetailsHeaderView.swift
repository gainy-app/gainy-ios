import UIKit
import SkeletonView
import Combine
import PureLayout

enum CollectionDetailsHeaderViewState: Int, Codable {
    
    case grid
    case table
    case chart
    
    static func heightForState(state: CollectionDetailsHeaderViewState) -> Int {
        
        switch state {
        case .grid: return 146
        case .table: return 173
        case .chart: return 482
        }
    }
}

final class CollectionDetailsHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithState(state: CollectionDetailsHeaderViewState) {
        
    }
}
