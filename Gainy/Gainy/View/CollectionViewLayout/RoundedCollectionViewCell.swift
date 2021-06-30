import UIKit

class RoundedCollectionViewCell: UICollectionViewCell {
    // MARK: Internal

    override func didMoveToSuperview() {
        layer.cornerRadius = Constant.cornerRadius
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }

    // MARK: Private

    private enum Constant {
        static let cornerRadius = 8.0 as CGFloat
    }
}
