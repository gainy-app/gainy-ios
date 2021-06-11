import UIKit

final class YourCollectionViewCell: RoundedCornerView {
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
        backgroundColor = UIColor.Gainy.white

        setupSwipeGesture()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    var onDeleteButtonPressed: (() -> Void)?
    var onDragSessionStarted: (() -> Void)?

    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
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

        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 28)
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
        let topMargin: CGFloat = 16

        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )

        nameLabel.frame = CGRect(
            x: hMargin,
            y: topMargin,
            width: bounds.width - (hMargin + 128),
            height: 20
        )

        descriptionLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + nameLabel.bounds.height + 8,
            width: bounds.width - (hMargin + 96),
            height: 34
        )

        stocksLabel.frame = CGRect(
            x: bounds.width - (45 + hMargin),
            y: topMargin,
            width: 45,
            height: 12
        )

        stocksAmountLabel.frame = CGRect(
            x: bounds.width - (55 + hMargin),
            y: topMargin + stocksLabel.bounds.height,
            width: 55,
            height: 33
        )

        deleteButton.frame = CGRect(
            x: bounds.width + 16,
            y: (bounds.height / 2) - 24,
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

    func setupSwipeGesture() {
        leftSwipeGesture = UISwipeGestureRecognizer(target: self,
                                                    action: #selector(leftSwiped(_:)))
        leftSwipeGesture.delegate = self
        leftSwipeGesture.direction = .left

        rightSwipeGesture = UISwipeGestureRecognizer(target: self,
                                                     action: #selector(rightSwiped(_:)))
        rightSwipeGesture.delegate = self

        addGestureRecognizer(leftSwipeGesture)
        addGestureRecognizer(rightSwipeGesture)
    }

    // MARK: Functions

    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
        if dragState == .lifting {
            onDragSessionStarted?()
        }

        switch dragState {
        case .dragging:
            layer.opacity = 0
        case .none:
            layer.opacity = 1
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
        backImageView.image = UIImage(named: imageName + "-discovered")

        nameLabel.text = name
        nameLabel.sizeToFit()

        descriptionLabel.text = description
        descriptionLabel.sizeToFit()

        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()

        layoutIfNeeded()
    }

    // MARK: Private

    // MARK: Types

    private enum Constant {
        static let swipeAnimationDurations: TimeInterval = 0.15
        static let swipeHorizontalShift: CGFloat = 40.0
    }

    // MARK: Properties

    private var leftSwipeGesture: UISwipeGestureRecognizer!
    private var rightSwipeGesture: UISwipeGestureRecognizer!
    private var originalCellCenter: CGPoint!

    // MARK: Functions

    @objc
    private func leftSwiped(_: UISwipeGestureRecognizer) {
        originalCellCenter = CGPoint(x: (superview?.center.x)!, y: center.y)

        UIView.animate(withDuration: Constant.swipeAnimationDurations) {
            self.transform = CGAffineTransform(translationX: -Constant.swipeHorizontalShift,
                                               y: 0)
            self.center = CGPoint(x: self.originalCellCenter.x - Constant.swipeHorizontalShift,
                                  y: self.originalCellCenter.y)
        }
    }

    @objc
    private func rightSwiped(_: UISwipeGestureRecognizer) {
        if let originalCellCenter = self.originalCellCenter {
            UIView.animate(withDuration: Constant.swipeAnimationDurations) {
                self.center = originalCellCenter
                self.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }

    @objc
    private func deleteButtonTapped(_: UIButton) {
        onDeleteButtonPressed?()
    }
}

extension YourCollectionViewCell: UIGestureRecognizerDelegate {}
