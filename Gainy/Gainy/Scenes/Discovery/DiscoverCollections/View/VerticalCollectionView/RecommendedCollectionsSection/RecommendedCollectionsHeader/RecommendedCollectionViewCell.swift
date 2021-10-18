import UIKit
import Kingfisher
import PureLayout

final class RecommendedCollectionViewCell: RoundedCollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(backImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stocksAmountLabel)
        contentView.addSubview(plusButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 8)
        
        
        descriptionLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 8)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -8)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 4)
        descriptionLabel.autoSetDimension(.height, toSize: 43)
        
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

    private var imageUrl: String = ""
    private var imageLoaded: Bool = false
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isOpaque = true        
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
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
        label.minimumScaleFactor = 0.1
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

    private func loadImage() {
        
        guard self.imageLoaded == false, backImageView.bounds.size.width > 0, backImageView.bounds.size.height > 0 else {
            return
        }
        
        let processor = DownsamplingImageProcessor(size: backImageView.bounds.size)
        backImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) { receivedSize, totalSize in
//            print("-----\(receivedSize), \(totalSize)")
        } completionHandler: { result in
//            print("-----\(result)")
        }
        self.imageLoaded = true
    }
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        if window != nil {
            self.imageLoaded = false
            loadImage()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        loadImage()
        
        let hMargin: CGFloat = 8
        let tMargin: CGFloat = 8
        let bMargin: CGFloat = 8


        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
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
        
        backImageView.contentMode = .scaleAspectFill
        self.imageLoaded = false
        self.imageUrl = imageUrl
        setNeedsLayout()

        nameLabel.text = name

        descriptionLabel.text = description
        descriptionLabel.sizeToFit()

        stocksAmountLabel.text = stocksAmount

        buttonState = plusButtonState
        buttonState == .checked
            ? setButtonChecked()
            : setButtonUnchecked()

        layoutIfNeeded()
    }
    
    func setButtonChecked(isChecked: Bool) {
        if isChecked {
            setButtonChecked()
        } else {
            setButtonUnchecked()
        }
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
        } else if let tapHandler = onCheckButtonPressed, buttonState == .checked {
            buttonState = .unchecked
            tapHandler()
        }
    }
}
