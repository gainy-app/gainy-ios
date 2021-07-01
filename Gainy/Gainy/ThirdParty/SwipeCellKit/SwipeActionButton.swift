import UIKit

class SwipeActionButton: UIButton {
    // MARK: Lifecycle

    convenience init(action: SwipeAction) {
        self.init(frame: .zero)

        contentHorizontalAlignment = .center

        accessibilityLabel = action.accessibilityLabel

        setImage(action.image, for: .normal)
        setImage(action.highlightedImage ?? action.image, for: .highlighted)
    }

    // MARK: Internal

    var spacing: CGFloat = 8

    var maximumImageHeight: CGFloat = 0
    var verticalAlignment: SwipeVerticalAlignment = .center


    var currentSpacing: CGFloat {
        (currentTitle?.isEmpty == false && imageHeight > 0) ? spacing : 0
    }

    var alignmentRect: CGRect {
        let contentRect = self.contentRect(forBounds: bounds)
        let titleHeight = titleBoundingRect(with: contentRect.size).integral.height
        let totalHeight = imageHeight + titleHeight + currentSpacing

        return contentRect.center(size: CGSize(width: contentRect.width, height: totalHeight))
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: contentEdgeInsets.top + alignmentRect.height + contentEdgeInsets.bottom)
    }

    func preferredWidth(maximum: CGFloat) -> CGFloat {
        let width = maximum > 0 ? maximum : CGFloat.greatestFiniteMagnitude
        let textWidth = titleBoundingRect(
            with: CGSize(
                width: width,
                height: CGFloat.greatestFiniteMagnitude
            )
        ).width
        let imageWidth = currentImage?.size.width ?? 0

        return min(
            width,
            max(textWidth, imageWidth) + contentEdgeInsets.left + contentEdgeInsets.right
        )
    }

    func titleBoundingRect(with size: CGSize) -> CGRect {
        guard let title = currentTitle, let font = titleLabel?.font else { return .zero }

        return title.boundingRect(with: size,
                                  options: [.usesLineFragmentOrigin],
                                  attributes: [NSAttributedString.Key.font: font],
                                  context: nil).integral
    }

    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = contentRect.center(size: titleBoundingRect(with: contentRect.size).size)
        rect.origin.y = alignmentRect.minY + imageHeight + currentSpacing
        return rect.integral
    }

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var rect = contentRect.center(size: currentImage?.size ?? .zero)
        rect.origin.y = alignmentRect.minY + (imageHeight - rect.height) / 2
        return rect
    }

    // MARK: Private

    private var imageHeight: CGFloat {
        currentImage == nil ? 0 : maximumImageHeight
    }
}

extension CGRect {
    func center(size: CGSize) -> CGRect {
        let dx = width - size.width
        let dy = height - size.height

        return CGRect(x: origin.x + dx * 0.5,
                      y: origin.y + dy * 0.5,
                      width: size.width,
                      height: size.height)
    }
}
