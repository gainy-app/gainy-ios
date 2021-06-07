import UIKit

class RoundedCornerView: UICollectionViewCell {
    // MARK: Internal

    override func draw(_: CGRect) {
        let borderPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: Constant.cornerRadius
        )
        borderPath.fill()
    }

    // MARK: Private

    private enum Constant {
        static let cornerRadius = 8.0 as CGFloat
    }
}
