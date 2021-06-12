import UIKit

class RoundedCornerView: UICollectionViewCell {
    // MARK: Internal

    override func draw(_: CGRect) {
        let borderPath = maskBezierPath()
        borderPath.fill()

        let mask = CAShapeLayer()
        mask.path = borderPath.cgPath
        self.layer.mask = mask
    }

    // MARK: Private

    // MARK: Types

    private enum Constant {
        static let cornerRadius = 8.0 as CGFloat
    }

    // MARK: Functions

    private func maskBezierPath() -> UIBezierPath {
        let path = UIBezierPath()

        path.append(
            UIBezierPath(
                roundedRect: bounds,
                cornerRadius: Constant.cornerRadius
            )
        )

        path.append(
            UIBezierPath(
                roundedRect: CGRect(
                    x: bounds.width + 16,
                    y: 20,
                    width: 48,
                    height: 48
                ),
                cornerRadius: Constant.cornerRadius
            )
        )

        return path
    }
}
