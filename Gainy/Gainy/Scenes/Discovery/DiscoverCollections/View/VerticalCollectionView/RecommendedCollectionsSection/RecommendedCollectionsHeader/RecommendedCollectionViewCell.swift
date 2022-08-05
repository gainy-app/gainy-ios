import UIKit
import Kingfisher
import PureLayout
import Deviice

final class RecommendedCollectionViewCell: RoundedCollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(backImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.addSubview(msLabel)
        contentView.addSubview(msCircle)
        
        contentView.addSubview(gainsView)
        gainsView.addSubview(growArrowImgView)
        gainsView.addSubview(gainsLabel)
        
        contentView.addSubview(plusButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
               
        descriptionLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        descriptionLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
        descriptionLabel.autoSetDimension(.height, toSize: 45, relation: .lessThanOrEqual)
        
        msLabel.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
        msLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16.0)
        msLabel.autoSetDimensions(to: .init(width: 24, height: 24))
        
        msCircle.autoSetDimensions(to: .init(width: 22, height: 22))
        msCircle.autoAlignAxis(.horizontal, toSameAxisOf: msLabel, withMultiplier: 1.0)
        msCircle.autoAlignAxis(.vertical, toSameAxisOf: msLabel, withMultiplier: 1.0)
        
        gainsView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
        gainsView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 48)
        gainsView.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -35, relation: .lessThanOrEqual)
        gainsView.autoSetDimension(.height, toSize: 24)
        
        growArrowImgView.autoPinEdge(.leading, to: .leading, of: gainsView, withOffset: 8)
        growArrowImgView.autoAlignAxis(.horizontal, toSameAxisOf: gainsView, withMultiplier: 1.0)
        growArrowImgView.autoSetDimensions(to: .init(width: 8, height: 8))
        
        gainsLabel.autoPinEdge(.leading, to: .leading, of: gainsView, withOffset: 20)
        gainsLabel.autoPinEdge(.trailing, to: .trailing, of: gainsView, withOffset: -8)
        gainsLabel.autoAlignAxis(.horizontal, toSameAxisOf: gainsView, withMultiplier: 1.0)
        
        plusButton.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: 0)
        plusButton.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: 0)
        plusButton.autoSetDimensions(to: .init(width: 56, height: 56))
        
        layer.isOpaque = true
        fillRemoteBack()
        contentView.fillRemoteBack()
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
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
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

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 0
        return label
    }()

    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Semibold", size: Deviice.current.size == .screen4Dot7Inches ? 20 : 26)
        label.textColor = UIColor.Gainy.yellow

        label.numberOfLines = 1
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        return label
    }()

    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.contentMode = .scaleAspectFill
        button.addTarget(self,
                         action: #selector(plusButtonTapped(_:)),
                         for: .touchUpInside)
        return button
    }()
    
    //MARK: - MS
    
    lazy var msLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .compactRoundedSemibold(12.0)
        label.layer.cornerRadius = 12.0
        label.clipsToBounds = true
        return label
    }()
    
    lazy var msCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "match_score_col")
        return imageView
    }()
    
    //MARK: - Gains
    
    lazy var gainsView: UIView = {
        let stocksView = UIView()
        stocksView.layer.cornerRadius = 12.0
        stocksView.clipsToBounds = true
        return stocksView
    }()
    
    lazy var gainsLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .compactRoundedSemibold(14.0)
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    lazy var growArrowImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "match_score_col")
        return imageView
    }()

    private func loadImage() {
        
        guard self.imageLoaded == false, backImageView.bounds.size.width > 0, backImageView.bounds.size.height > 0 else {
            return
        }
        if self.updateImageBasedOnTag() {
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
    
    func updateImageBasedOnTag() -> Bool {
        
        if Constants.CollectionDetails.top20ID == self.tag {
            backImageView.image = UIImage(named: "top20CollectionBgSmall")
            self.imageLoaded = true
            return true
        }
        if Constants.CollectionDetails.watchlistCollectionID == self.tag {
            backImageView.image = UIImage(named: "watchlistCollectionBackgroundImage")
            self.imageLoaded = true
            return true
        }
        
        return false
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

        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )
        
        loadImage()
        
        let hMargin: CGFloat = 8
        let tMargin: CGFloat = 8
        let bMargin: CGFloat = 8
        
        
        let isTop20 = false//(Constants.CollectionDetails.top20ID == self.tag) ? true : false
        self.nameLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.white
        self.descriptionLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.white
        self.stocksAmountLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.yellow
        self.layer.borderWidth = isTop20 ? 1.0 : 0.0
        self.layer.borderColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0)?.cgColor : UIColor.clear.cgColor
        self.layer.cornerRadius = isTop20 ? 8.0 : 0.0
        _ = self.updateImageBasedOnTag()
    }


    // MARK: Functions

    func configureWith(
        name: String,
        imageUrl: String,
        description: String,
        stocksAmount: Int,
        matchScore: Int,
        dailyGrow: Float,
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

        if dailyGrow > 0.0 {
            gainsView.backgroundColor = UIColor.Gainy.secondaryGreen
            growArrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
            growArrowImgView.tintColor = UIColor.Gainy.mainText
            gainsLabel.textColor = UIColor.Gainy.mainText
            
        } else {
            gainsView.backgroundColor = UIColor.Gainy.mainRed
            growArrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
            growArrowImgView.tintColor = .white
            gainsLabel.textColor = .white
        }
        gainsLabel.text = dailyGrow.percentUnsigned
        
        msLabel.text = "\(Int(matchScore))"
        msLabel.backgroundColor = MatchScoreManager.circleColorFor(matchScore) 

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
        plusButton.setImage(UIImage(named: "add_to_wl_rec"), for: .normal)
    }

    func setButtonChecked() {
        buttonState = .checked
        plusButton.setImage(UIImage(named: "remove_from_wl_rec"), for: .normal)
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
