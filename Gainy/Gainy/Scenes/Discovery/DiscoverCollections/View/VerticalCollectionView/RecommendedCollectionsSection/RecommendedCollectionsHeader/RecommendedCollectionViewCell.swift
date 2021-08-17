import UIKit
import Kingfisher

final class RecommendedCollectionViewCell: RoundedCollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(backImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stocksAmountLabel)
        contentView.addSubview(plusButton)

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
    var onCheckButtonPressed: (() -> Void)?

    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        let tMargin: CGFloat = 8
        let bMargin: CGFloat = 8

        let availableWidth = bounds.width - (hMargin + hMargin)
        let nameLabelFont = UIFont(name: "SFProDisplay-Bold", size: 16)
        let neededSize = nameLabel.text.size(
            withAttributes: [
                NSAttributedString.Key.font: nameLabelFont as Any,
            ]
        )

        let minNameHeight: CGFloat = neededSize.width > availableWidth ? 40 : 20

        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )

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

        stocksAmountLabel.frame = CGRect(
            x: hMargin,
            y: bounds.height - (28 + bMargin),
            width: 55,
            height: 28
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
        imageUrl: String,
        description: String,
        stocksAmount: String,
        imageName: String,
        plusButtonState: RecommendedCellButtonState
    ) {
        backImageView.kf.setImage(with: URL(string: imageUrl))

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

        layoutIfNeeded()
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
        //TODO: - Uncomment later
//        if let tapHandler = onPlusButtonPressed, buttonState == .unchecked {
//            buttonState = .checked
//            tapHandler()
//        } else if let tapHandler = onCheckButtonPressed, buttonState == .checked {
//            buttonState = .unchecked
//            tapHandler()
//        }
    }
}
