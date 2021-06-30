import UIKit

class RoundedCollectionViewCell: UICollectionViewCell {
    override func didMoveToSuperview() {
        layer.cornerRadius = Constant.cornerRadius
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }

    private enum Constant {
        static let cornerRadius = 8.0 as CGFloat
    }
}
