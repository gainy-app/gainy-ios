import UIKit
import Kingfisher

protocol CollectionHorizontalViewDelegate: AnyObject {
    func stockSortPressed(view: CollectionHorizontalView)
    func stocksViewModeChanged(view: CollectionHorizontalView, isGrid: Bool)
}

final class CollectionHorizontalView: UIView {
    // MARK: Lifecycle

    weak var delegate: CollectionHorizontalViewDelegate?
    override init(frame _: CGRect) {
        super.init(frame: .zero)

        addSubview(backImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(stocksLabel)
        addSubview(stocksAmountLabel)
        addSubview(settingsButton)
        addSubview(sortByButton)
        addSubview(showListViewButton)
        addSubview(showGridViewButton)

        layer.cornerRadius = 16.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        layer.isOpaque = true
        backgroundColor = .clear
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    var onSettingsButtonPressed: (() -> Void)?
    var onSortByButtonPressed: (() -> Void)?
    var onShowListViewButtonPressed: (() -> Void)?
    var onShowGridViewButtonPressed: (() -> Void)?

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

        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor.Gainy.white

        label.numberOfLines = 0
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
        label.sizeToFit() // TODO: 1: if there's such code?

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

    // TODO: 1: use custom SettingsButton
    lazy var settingsButton: ResponsiveButton = {
        let button = ResponsiveButton()

        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.backgroundColor = UIColor.Gainy.white

        let slidersIconImageView = UIImageView(
            frame: CGRect(x: 8, y: 4, width: 16, height: 16)
        )
        slidersIconImageView.image = UIImage(named: "sliders")

        button.addSubview(slidersIconImageView)

        let textLabel = UILabel(
            frame: CGRect(x: 8 + 16 + 2, y: 4, width: 42, height: 16)
        )

        textLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        textLabel.textColor = UIColor.Gainy.grayNotDark
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = "Settings"

        button.addSubview(textLabel)

        button.addTarget(self,
                         action: #selector(settingsButtonTapped(_:)),
                         for: .touchUpInside)

        return button
    }()

    // TODO: 1: use custom button
    lazy var sortByButton: ResponsiveButton = {
        let button = ResponsiveButton()

        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.backgroundColor = UIColor.Gainy.white

        let reorderIconImageView = UIImageView(
            frame: CGRect(x: 8, y: 4, width: 16, height: 16)
        )
        reorderIconImageView.image = UIImage(named: "reorder")

        button.addSubview(reorderIconImageView)

        let sortByLabel = UILabel(
            frame: CGRect(x: 8 + 16 + 2, y: 4, width: 36, height: 16)
        )

        sortByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        sortByLabel.textColor = UIColor.Gainy.grayNotDark
        sortByLabel.numberOfLines = 1
        sortByLabel.textAlignment = .center
        sortByLabel.text = "Sort by"
        button.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)

        button.addSubview(sortByLabel)

        let textLabel = UILabel(
            frame: CGRect(x: 8 + 16 + 2 + 36 + 2, y: 4, width: 77, height: 16)
        )

        textLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        textLabel.textColor = UIColor.Gainy.grayNotDark
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = ""
        textLabel.minimumScaleFactor = 0.1
        sortLbl = textLabel
        button.addSubview(textLabel)

//        button.bounds = button.frame.insetBy(dx: 4, dy: 8)

        return button
    }()
    
    private var sortLbl: UILabel?
    
    func updateChargeLbl(_ sort: String) {
        sortLbl?.text = sort
    }
    
    private var collectionId: Int = 0
    
    @objc private func sortTapped() {
        delegate?.stockSortPressed(view: self)
    }

    // TODO: 1: use custom button
    lazy var showListViewButton: ResponsiveButton = {
        let button = ResponsiveButton()

        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.layer.cornerCurve = .continuous

        button.setImage(UIImage(named: "list"), for: .normal)

        button.addTarget(self,
                         action: #selector(showListViewButtonTapped(_:)),
                         for: .touchUpInside)

        return button
    }()

    // TODO: 1: use custom button
    lazy var showGridViewButton: ResponsiveButton = {
        let button = ResponsiveButton()

        button.backgroundColor = UIColor.Gainy.blue
        
        button.layer.cornerRadius = 4
        button.layer.cornerCurve = .continuous

        button.setImage(UIImage(named: "grid"), for: .normal)

        button.addTarget(self,
                         action: #selector(showGridViewButtonTapped(_:)),
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
            print("-----\(receivedSize), \(totalSize)")
        } completionHandler: { result in
            print("-----\(result)")
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
        
        let hMargin: CGFloat = 16
        let topMarginLeftSide: CGFloat = 16
        let topMarginRightSide: CGFloat = 19
        let bottomMargin: CGFloat = 16

        let availableWidth = bounds.width - (hMargin + 71)
        let descLabelFont = UIFont(name: "SFProDisplay-Regular", size: 14)
        let neededSize = descriptionLabel.text.size(
            withAttributes: [
                NSAttributedString.Key.font: descLabelFont as Any,
            ]
        )

        let nameHeight: CGFloat = 27
        let minDescHeight: CGFloat = neededSize.width > availableWidth ? 32 : 16
//        let pairedHeight = nameHeight + 4 + minDescHeight

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
            y: topMarginLeftSide + nameLabel.bounds.height + 8,
            width: bounds.width - (hMargin + 71),
            height: minDescHeight
        )

        stocksLabel.frame = CGRect(
            x: bounds.width - (45 + hMargin),
            y: topMarginRightSide,
            width: 45,
            height: 10
        )

        stocksAmountLabel.frame = CGRect(
            x: bounds.width - (80 + hMargin),
            y: topMarginRightSide + stocksLabel.bounds.height + 3,
            width: 80,
            height: 33
        )

        settingsButton.frame = CGRect(
            x: hMargin,
            y: bounds.height - (24 + bottomMargin),
            width: 76,
            height: 24
        )

        sortByButton.frame = CGRect(
            x: hMargin + 84,
            y: bounds.height - (24 + bottomMargin),
            width: 149,
            height: 24
        )

        showListViewButton.frame = CGRect(
            x: bounds.width - (24 + 8 + 24 + hMargin),
            y: bounds.height - (24 + bottomMargin),
            width: 24,
            height: 24
        )

        showGridViewButton.frame = CGRect(
            x: bounds.width - (24 + hMargin),
            y: bounds.height - (24 + bottomMargin),
            width: 24,
            height: 24
        )
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if deleteButton.frame.contains(point) {
//            return deleteButton
//        }

        super.hitTest(point, with: event)
    }

    func configureWith(
        name: String,
        description: String,
        stocksAmount: String,
        imageName: String,
        imageUrl: String,
        collectionId: Int
    ) {
        backImageView.image = UIImage(named: imageName)
        
        self.imageLoaded = false
        self.imageUrl = imageUrl
        
        nameLabel.text = name
        nameLabel.sizeToFit()

        descriptionLabel.text = description
        descriptionLabel.sizeToFit()

        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()
        
        self.collectionId = collectionId
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionId)
        sortLbl?.text = settings.sorting.title
        
        showListViewButton.backgroundColor = settings.viewMode == .list ?  UIColor.Gainy.blue : .clear
        showGridViewButton.backgroundColor = settings.viewMode == .list ?  .clear :  UIColor.Gainy.blue

        layoutIfNeeded()
    }

    // MARK: Private

    // MARK: Functions

    @objc
    private func settingsButtonTapped(_: UIButton) {
        GainyAnalytics.logEvent("settings_pressed", params: ["collectionID" : collectionId])
        NotificationManager.shared.showMessage(title: "Beta version", text: "Sorry, feature in development", cancelTitle: "OK", actions: nil)
    }

    @objc
    private func showListViewButtonTapped(_: UIButton) {
        showListViewButton.backgroundColor = UIColor.Gainy.blue
        showGridViewButton.backgroundColor = .clear
        delegate?.stocksViewModeChanged(view: self, isGrid: false)
        CollectionsDetailsSettingsManager.shared.changeViewModeForId(self.collectionId, viewMode: .list)
    }

    @objc
    private func showGridViewButtonTapped(_: UIButton) {
        showListViewButton.backgroundColor = .clear
        showGridViewButton.backgroundColor = UIColor.Gainy.blue
        delegate?.stocksViewModeChanged(view: self, isGrid: true)
        CollectionsDetailsSettingsManager.shared.changeViewModeForId(self.collectionId, viewMode: .grid)
    }
}
