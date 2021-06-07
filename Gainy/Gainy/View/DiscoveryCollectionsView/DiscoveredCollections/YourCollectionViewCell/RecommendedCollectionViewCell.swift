import UIKit

class RecommendedCollectionViewCell: RoundedCornerView {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        addSubview(backImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(stocksLabel)
        addSubview(stocksAmountLabel)
        addSubview(plusButton)

        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    private(set) var buttonState: RecommendedCellButtonState = .unchecked

    var onPlusButtonPressed: (() -> Void)?

    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.isOpaque = true

        return imageView
    }()

    lazy var nameLabel: UITextView = {
        let label = UITextView()

        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.automaticallyAdjustsScrollIndicatorInsets = false
        label.contentInsetAdjustmentBehavior = .never
        label.textContainerInset = .zero
        label.textContainer.lineFragmentPadding = 0
        label.contentInset = UIEdgeInsets(top: -4, left: 0,
                                          bottom: 0, right: 0)

        return label
    }()

    lazy var descriptionLabel: UITextView = {
        let label = UITextView()

        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.automaticallyAdjustsScrollIndicatorInsets = false
        label.contentInsetAdjustmentBehavior = .never
        label.textContainerInset = .zero
        label.textContainer.lineFragmentPadding = 0
        label.contentInset = UIEdgeInsets(top: -4, left: 0,
                                          bottom: 0, right: 0)

        return label
    }()

    lazy var stocksLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Medium", size: 9)
        label.textColor = UIColor.Gainy.white
        label.numberOfLines = 2
        label.textAlignment = .left

        label.text = "STOCKS"
        label.sizeToFit()

        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 28)
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

        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let hMargin: CGFloat = 8
        let tMargin: CGFloat = 12
        let bMargin: CGFloat = 8

        let minNameHeight: CGFloat = nameLabel.text.count > 12 ? 35 : 18
        nameLabel.frame = CGRect(
            x: hMargin,
            y: tMargin,
            width: bounds.width - (hMargin + hMargin),
            height: minNameHeight
        )

        descriptionLabel.frame = CGRect(
            x: hMargin,
            y: tMargin + nameLabel.bounds.height + 4,
            width: bounds.width - (hMargin + hMargin),
            height: 43
        )

        stocksLabel.frame = CGRect(
            x: hMargin,
            y: bounds.height - (12 + 24 + bMargin),
            width: 45,
            height: 12
        )

        stocksAmountLabel.frame = CGRect(
            x: hMargin,
            y: bounds.height - (24 + bMargin),
            width: 55,
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

    func configureWith(
        name: String,
        description: String,
        stocksAmount: String,
        imageName: String,
        plusButtonState: RecommendedCellButtonState
    ) {
        backImageView.image = UIImage(named: imageName + "-recommended")

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

    // MARK: Functions

    @objc
    private func plusButtonTapped(_: UIButton) {
        if let tapHandler = onPlusButtonPressed, buttonState == .unchecked {
            buttonState = .checked
            tapHandler()
        }
    }
}
