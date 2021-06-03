import UIKit

class RoundedCornerView: UICollectionViewCell {
    static let cornerRadius = 8.0 as CGFloat

    override func draw(_: CGRect) {
        let borderPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: RoundedCornerView.cornerRadius
        )
        borderPath.fill()
    }
}
