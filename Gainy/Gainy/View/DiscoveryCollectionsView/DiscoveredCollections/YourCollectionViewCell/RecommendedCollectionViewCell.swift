import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(stocksLabel)
        addSubview(stocksAmountLabel)
        addSubview(plusButton)

        backgroundColor = UIColor.Gainy.white
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    private(set) var buttonState: RecommendedCellButtonState = .unchecked

    var onPlusButtonPressed: (() -> Void) = {} // TODO: rename onDelete.. here and

    lazy var nameLabel: UITextView = {
        let label = UITextView()

        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.automaticallyAdjustsScrollIndicatorInsets = false
        label.contentInsetAdjustmentBehavior = .never
        label.contentInset = UIEdgeInsets(top: -8, left: 0,
                                          bottom: 0, right: 0)

        return label
    }()

    lazy var descriptionLabel: UITextView = {
        let label = UITextView()

        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.automaticallyAdjustsScrollIndicatorInsets = false
        label.contentInsetAdjustmentBehavior = .never
        label.contentInset = UIEdgeInsets(top: -8, left: 0,
                                          bottom: 0, right: 0)

        return label
    }()

    lazy var stocksLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.roundedFont(ofSize: 9, weight: .medium)
        label.textColor = UIColor.Gainy.white
        label.numberOfLines = 2
        label.textAlignment = .left

        label.text = "STOCKS"
        label.sizeToFit()

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont.roundedFont(ofSize: 28, weight: .semibold)
        label.textColor = UIColor.Gainy.yellow

        label.numberOfLines = 1
        label.textAlignment = .left

        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()

        button.layer.cornerRadius = 14
        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(plusButtonTapped(_:)),
                         for: .touchUpInside)

        var shadows = UIView()
        shadows.frame = button.frame
        shadows.clipsToBounds = false
        button.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 6
        layer0.shadowOffset = CGSize(width: 0, height: 2)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)

        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let hMargin: CGFloat = 8
        let tMargin: CGFloat = 12
        let bMargin: CGFloat = 8

        let minNameHeight: CGFloat = nameLabel.text.count > 11 ? 35 : 18
        nameLabel.frame = CGRect(
            x: hMargin - 4,
            y: tMargin,
            width: bounds.width - (hMargin + hMargin) + 4,
            height: minNameHeight
        )

        descriptionLabel.frame = CGRect(
            x: hMargin - 4,
            y: tMargin + nameLabel.bounds.height + 4,
            width: bounds.width - (hMargin + hMargin) + 4,
            height: 42
        )

        stocksLabel.frame = CGRect(
            x: hMargin,
            y: bounds.height - (10 + 24 + bMargin),
            width: 60,
            height: 10
        )

        stocksAmountLabel.frame = CGRect(
            x: hMargin,
            y: bounds.height - (24 + bMargin),
            width: 60,
            height: 24
        )

        plusButton.frame = CGRect(
            x: bounds.width - (28 + hMargin),
            y: bounds.height - (28 + bMargin),
            width: 28,
            height: 28
        )
    }


    // MARK: Functions

    override func draw(_: CGRect) {
        let borderPath = UIBezierPath(roundedRect: self.bounds,
                                      cornerRadius: cornerRadius)
        UIColor.orange.set() // TODO: update with a picture
        borderPath.fill()
    }

    func configureWith(name: String,
                       description: String,
                       stocksAmount: Int,
                       imageName: String,
                       plusButtonState: RecommendedCellButtonState) {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(imageName)-recommended")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        self.backgroundView = imageView

        nameLabel.text = name
        nameLabel.sizeToFit()

        descriptionLabel.text = description
        descriptionLabel.sizeToFit()

        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()

        buttonState = plusButtonState
        buttonState == .checked
            ? setButtonChecked()
            : setButtonUnchecked()

        setNeedsLayout()
    }

    func setButtonUnchecked() {
        buttonState = .unchecked
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
    }

    func setButtonChecked() {
        buttonState = .checked
        plusButton.setImage(UIImage(named: "check"), for: .normal)
    }

    // MARK: Private

    // MARK: Properties

    private let cornerRadius: CGFloat = 8

    // MARK: Functions

    @objc
    private func plusButtonTapped(_: UIButton) {
        if buttonState == .unchecked {
            buttonState = .checked
            onPlusButtonPressed()
        }
    }
}
