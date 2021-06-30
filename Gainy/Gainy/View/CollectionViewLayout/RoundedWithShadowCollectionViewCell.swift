import UIKit

class RoundedWithShadowCollectionViewCell: UICollectionViewCell {
    override func didMoveToSuperview() {
        layer.cornerRadius = Constant.cornerRadius
        layer.cornerCurve = .continuous
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        // cell shadow section
        contentView.layer.cornerRadius = Constant.cornerRadius
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1
        layer.cornerRadius = Constant.cornerRadius

        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
    }

    private enum Constant {
        static let cornerRadius = 8.0 as CGFloat
    }
}
