import UIKit

final class YourCollectionViewCell: RoundedCollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        addSubview(backImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(stocksLabel)
        addSubview(stocksAmountLabel)
        addSubview(deleteButton)

        layer.isOpaque = true
        backgroundColor = .black
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    var onDeleteButtonPressed: (() -> Void)?
    var onCellLifted: (() -> Void)?
    var onCellStopDragging: (() -> Void)?

    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isOpaque = true

        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionLabel: UITextView = {
        let label = UITextView()

        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.automaticallyAdjustsScrollIndicatorInsets = false
        label.contentInsetAdjustmentBehavior = .never
        label.contentInset = UIEdgeInsets(top: -8, left: -4,
                                          bottom: 0, right: 0)

        return label
    }()

    lazy var stocksLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Medium", size: 9)
        label.textColor = UIColor.Gainy.white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "STOCKS"
        label.sizeToFit()

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 32)
        label.textColor = UIColor.Gainy.yellow

        label.numberOfLines = 1
        label.textAlignment = .right

        return label
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()

        button.layer.cornerRadius = 6
        button.layer.cornerCurve = .continuous
        button.backgroundColor = UIColor.Gainy.back

        button.setImage(UIImage(named: "trash"), for: .normal)
        button.addTarget(self,
                         action: #selector(deleteButtonTapped(_:)),
                         for: .touchUpInside)

        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let hMargin: CGFloat = 16

        let availableWidth = bounds.width - (hMargin + 71)
        let descLabelFont = UIFont(name: "SFProDisplay-Regular", size: 14)
        let neededSize = descriptionLabel.text.size(
            withAttributes: [
                NSAttributedString.Key.font: descLabelFont as Any,
            ]
        )

        let nameHeight: CGFloat = 24
        let minDescHeight: CGFloat = neededSize.width > availableWidth ? 32 : 16
        let pairedHeight = nameHeight + 4 + minDescHeight


        let topMarginRightSide: CGFloat = 20
        let topMarginLeftSide = (bounds.height - pairedHeight) / 2

        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )

        nameLabel.frame = CGRect(
            x: hMargin,
            y: topMarginLeftSide,
            width: bounds.width - (hMargin + 71),
            height: nameHeight
        )

        descriptionLabel.frame = CGRect(
            x: hMargin,
            y: topMarginLeftSide + nameLabel.bounds.height + 4,
            width: bounds.width - (hMargin + 71),
            height: minDescHeight
        )

        stocksLabel.frame = CGRect(
            x: bounds.width - (45 + hMargin),
            y: topMarginRightSide,
            width: 45,
            height: 16
        )

        stocksAmountLabel.frame = CGRect(
            x: bounds.width - (80 + hMargin),
            y: topMarginRightSide + stocksLabel.bounds.height,
            width: 80,
            height: 33
        )

        deleteButton.frame = CGRect(
            x: bounds.width + 16,
            y: (bounds.height - 48) / 2,
            width: 48,
            height: 48
        )
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if deleteButton.frame.contains(point) {
            return deleteButton
        }

        return super.hitTest(point, with: event)
    }

    // MARK: Functions

    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
        switch dragState {
        case .lifting:
            onCellLifted?()
        case .dragging:
            layer.opacity = 0
        case .none:
            layer.opacity = 1
            onCellStopDragging?()
        default:
            return
        }
    }

    func configureWith(
        name: String,
        description: String,
        stocksAmount: String,
        imageName: String
    ) {
        backImageView.image = UIImage(named: imageName)

        nameLabel.text = name
        nameLabel.sizeToFit()

        descriptionLabel.text = description
        descriptionLabel.sizeToFit()

        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()

        layoutIfNeeded()
    }

    func shiftCellLeftAndShowDeleteButton() {
        originalCellCenter = CGPoint(x: (superview?.center.x)!, y: center.y)

        UIView.animate(withDuration: Constant.swipeAnimationDurations) {
            self.transform = CGAffineTransform(translationX: -Constant.swipeHorizontalShift,
                                               y: 0)
            self.center = CGPoint(x: self.originalCellCenter.x - Constant.swipeHorizontalShift,
                                  y: self.originalCellCenter.y)
        }
    }

    func resetCellStateAndHideDeleteButton() {
        if let originalCellCenter = self.originalCellCenter {
            UIView.animate(withDuration: Constant.swipeAnimationDurations) {
                self.center = originalCellCenter
                self.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }

    // MARK: Private

    // MARK: Types

    private enum Constant {
        static let swipeAnimationDurations: TimeInterval = 0.15
        static let swipeHorizontalShift: CGFloat = 40.0
    }

    // MARK: Properties

    private var originalCellCenter: CGPoint!

    // MARK: Functions

    @objc
    private func deleteButtonTapped(_: UIButton) {
        onDeleteButtonPressed?()
    }
}
