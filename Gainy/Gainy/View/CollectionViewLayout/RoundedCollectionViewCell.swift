import UIKit

class RoundedCollectionViewCell: UICollectionViewCell {
    // MARK: Internal

    override func didMoveToSuperview() {
        contentView.layer.cornerRadius = Constant.cornerRadius
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
    }

    // MARK: Private

    private enum Constant {
        static let cornerRadius = 16.0 as CGFloat
    }
}
