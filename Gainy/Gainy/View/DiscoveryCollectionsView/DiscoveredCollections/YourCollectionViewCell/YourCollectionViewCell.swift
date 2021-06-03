import UIKit

extension YourCollectionViewCell: UIGestureRecognizerDelegate {}

class YourCollectionViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        self.addSubview(nameLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(stocksLabel)
        self.addSubview(stocksAmountLabel)
        self.addSubview(deleteButton)

        self.backgroundColor = UIColor.Gainy.white

        setupSwipeGesture()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let hMargin: CGFloat = 16
        let topMargin: CGFloat = 16

        nameLabel.frame = CGRect(
            x: hMargin,
            y: topMargin,
            width: bounds.width - (hMargin + 96),
            height: 20
        )

        descriptionLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + nameLabel.bounds.height + 4,
            width: bounds.width - (hMargin + 128),
            height: 34
        )

        stocksLabel.frame = CGRect(
            x: bounds.width - (60 + hMargin),
            y: topMargin,
            width: 60,
            height: 12
        )

        stocksAmountLabel.frame = CGRect(
            x: bounds.width - (60 + hMargin),
            y: topMargin + stocksLabel.bounds.height,
            width: 60,
            height: 24
        )

        deleteButton.frame = CGRect(
            x: bounds.width + 16,
            y: (bounds.height / 2) - 24,
            width: 48,
            height: 48
        )
    }

    // MARK: Internal

    // MARK: Properties

    lazy var nameLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var descriptionLabel: UITextView = {
        let label = UITextView()

        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
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

        label.font = UIFont.roundedFont(ofSize: 9, weight: .medium)
        label.textColor = UIColor.Gainy.white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "STOCKS"
        label.sizeToFit()

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.roundedFont(ofSize: 28, weight: .semibold)
        label.textColor = UIColor.Gainy.yellow

        label.numberOfLines = 1
        label.textAlignment = .right

        return label
    }()

    lazy var deleteButton: UIButton = {
        let button = UIButton()

        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.Gainy.back

        button.setImage(UIImage(named: "trash"), for: .normal)
        button.addTarget(self,
                         action: #selector(self.deleteButtonTapped(_:)),
                         for: .touchUpInside)

        return button
    }()

    var onDeleteButtonPressed: (() -> Void) = {}

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if deleteButton.frame.contains(point) {
            return deleteButton
        }

        return super.hitTest(point, with: event)
    }

    override func draw(_: CGRect) {
        let borderPath = UIBezierPath(roundedRect: self.bounds,
                                      cornerRadius: cornerRadius)
        UIColor.orange.set() // TODO: update with a picture
        borderPath.fill()
    }

    func setupSwipeGesture() {
        leftSwipeGesture = UISwipeGestureRecognizer(target: self,
                                                    action: #selector(swipedLeft(_:)))
        leftSwipeGesture.delegate = self
        leftSwipeGesture.direction = .left

        rightSwipeGesture = UISwipeGestureRecognizer(target: self,
                                                     action: #selector(swipedRight(_:)))
        rightSwipeGesture.delegate = self

        self.addGestureRecognizer(leftSwipeGesture)
        self.addGestureRecognizer(rightSwipeGesture)
    }

    // MARK: Functions

    func configureWith(name: String, description: String, stocksAmount: Int, imageName: String) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(imageName)-discovered")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        self.backgroundView = imageView

        nameLabel.text = name
        nameLabel.sizeToFit()

        descriptionLabel.text = description
        descriptionLabel.sizeToFit()

        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()

        setNeedsLayout()
        layoutIfNeeded()
    }

    // MARK: Private

    // MARK: Types

    private enum Constant {
        static let swipeAnimationDurations: TimeInterval = 0.3
        static let swipeHorizontalShift: CGFloat = 40.0
    }

    // MARK: Properties

    private let cornerRadius: CGFloat = 8

    private var leftSwipeGesture: UISwipeGestureRecognizer!
    private var rightSwipeGesture: UISwipeGestureRecognizer!
    private var originalCellCenter: CGPoint!

    // MARK: Functions

    @objc
    private func swipedLeft(_: UISwipeGestureRecognizer) {
        self.originalCellCenter = CGPoint(x: (self.superview?.center.x)!, y: self.center.y)

        UIView.animate(withDuration: Constant.swipeAnimationDurations) {
            self.transform = CGAffineTransform(translationX: -Constant.swipeHorizontalShift,
                                               y: 0)
            self.center = CGPoint(x: self.originalCellCenter.x - Constant.swipeHorizontalShift,
                                  y: self.originalCellCenter.y)
        }
    }

    @objc
    private func swipedRight(_: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: Constant.swipeAnimationDurations) {
            self.center = self.originalCellCenter
            self.transform = CGAffineTransform(rotationAngle: 0)
        }
    }

    @objc
    private func deleteButtonTapped(_: UIButton) {
        onDeleteButtonPressed()
    }
}
