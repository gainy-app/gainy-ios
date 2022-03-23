import UIKit
import Kingfisher
import SkeletonView

protocol CollectionHorizontalViewDelegate: AnyObject {
    func comparePressed(view: CollectionHorizontalView)
    func settingsPressed(view: CollectionHorizontalView)
    func stockSortPressed(view: CollectionHorizontalView)
    func stocksViewModeChanged(view: CollectionHorizontalView, isGrid: Bool)
}

final class CollectionHorizontalView: UIView {
    // MARK: Lifecycle
    
    weak var delegate: CollectionHorizontalViewDelegate?
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        isSkeletonable = true
        addSubview(backImageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(stocksLabel)
        addSubview(stocksAmountLabel)
        addSubview(settingsButton)
        addSubview(extraActionButton)
        addSubview(sortByButton)
        
        addSubview(growContainer)
        growContainer.addSubview(growLbl)
        growContainer.addSubview(arrowImgView)
        growContainer.addSubview(growValueLbl)
        growContainer.isHidden = true
        
        addSubview(sortSmallButton)
        sortSmallButton.isHidden = true
        
        addSubview(showListViewButton)
        addSubview(showGridViewButton)
        
        layer.cornerRadius = 0.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
        
        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white
        skeletonCornerRadius = 16
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
    
    var shortCollection: RemoteShortCollectionDetails? = nil {
        didSet {
            if shortCollection != nil {
                self.backImageView.layer.cornerRadius = 0
                self.backImageView.skeletonCornerRadius = 0
                self.sortSmallButton.isHidden = false
                self.growContainer.isHidden = false
                
                self.growContainer.translatesAutoresizingMaskIntoConstraints = false
                self.growContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
                self.growContainer.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
                self.growContainer.autoSetDimension(.height, toSize: 24)
//                self.growContainer.autoSetDimension(.width, toSize: 151)
                self.growContainer.cornerRadius = 12
                
                self.growLbl.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
                self.growLbl.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.growLbl.autoSetDimension(.width, toSize: 68)

                self.arrowImgView.autoSetDimensions(to: CGSize.init(width: 8, height: 8))
                self.arrowImgView.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.arrowImgView.autoPinEdge(.left, to: .right, of: self.growLbl, withOffset: 4)
                
                self.growValueLbl.autoAlignAxis(toSuperviewAxis: .horizontal)
                self.growValueLbl.autoSetDimension(.height, toSize: 16)
                self.growValueLbl.autoPinEdge(.left, to: .right, of: self.arrowImgView, withOffset: 4)
                self.growValueLbl.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
                
                if (shortCollection!.metrics?.relativeDailyChange ?? 0.0) > 0.0 {
                    growContainer.backgroundColor = UIColor.Gainy.secondaryGreen
                    arrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                    arrowImgView.tintColor = UIColor.Gainy.mainText
                    growLbl.textColor = UIColor.Gainy.mainText
                    growValueLbl.textColor = UIColor.Gainy.mainText
                    
                } else {
                    growContainer.backgroundColor = UIColor.Gainy.mainRed
                    arrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                    arrowImgView.tintColor = .white
                    growLbl.textColor = .white
                    growValueLbl.textColor = .white
                }
                growValueLbl.text = (shortCollection!.metrics?.relativeDailyChange ?? 0.0).percent
                growValueLbl.sizeToFit()
                growContainer.sizeToFit()
                
                self.settingsButton.isHidden = true
                self.extraActionButton.isHidden = true
                self.sortByButton.isHidden = true
            }
        }
    }
    
    private var imageUrl: String = ""
    private var imageName: String = ""
    private var imageLoaded: Bool = false
    
    lazy var growContainer: CornerView = {
        let cornerView = CornerView()
        return cornerView
    }()
    
    lazy var arrowImgView: UIImageView = {
        let arrowImgView = UIImageView()
        return arrowImgView
    }()
    
    lazy var growLbl: UILabel = {
        let growLbl = UILabel()
        growLbl.font = UIFont(name: "SFCompactRounded-Semibold", size: 12)
        growLbl.text = "Today gain".uppercased()
        return growLbl
    }()
    
    lazy var growValueLbl: UILabel = {
        let growValueLbl = UILabel()
        growValueLbl.font = UIFont(name: "SFCompactRounded-Semibold", size: 16)
        return growValueLbl
    }()
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isOpaque = true
        imageView.backgroundColor = UIColor.Gainy.gray
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.skeletonCornerRadius = 16
        return imageView
    }()
    
    lazy var blackAlphaView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFill
        view.isOpaque = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        backImageView.addSubview(view)
        view.autoPinEdgesToSuperviewEdges()
        view.layer.cornerRadius = 16.0
        view.clipsToBounds = true
        return view
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
        label.isScrollEnabled = false
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
    
    
    private var settingsViews: [UIView] = []
    
    lazy var extraActionButton: ResponsiveButton = {
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
                         action: #selector(extraActionButtonTapped(_:)),
                         for: .touchUpInside)
        button.isHidden = true
        
        return button
    }()
    
    lazy var settingsButton: ResponsiveButton = {
        let button = ResponsiveButton()
        settingsViews.removeAll()
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.backgroundColor = UIColor.Gainy.white
        
        let slidersIconImageView = UIImageView(
            frame: CGRect(x: 8, y: 4, width: 16, height: 16)
        )
        slidersIconImageView.image = UIImage(named: "sliders")
        
        button.addSubview(slidersIconImageView)
        settingsViews.append(slidersIconImageView)
        let textLabel = UILabel(
            frame: CGRect(x: 8 + 16 + 2, y: 4, width: 42, height: 16)
        )
        
        textLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        textLabel.textColor = UIColor.Gainy.grayNotDark
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = "Settings"
        
        button.addSubview(textLabel)
        settingsViews.append(textLabel)
        button.addTarget(self,
                         action: #selector(settingsButtonTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    func setSettingsTitle(_ title: String) {
        settingsButton.backgroundColor = UIColor(hexString: "0062FF", alpha: 1.0)
        settingsButton.setTitle(title, for: .normal)
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        settingsViews.forEach({$0.alpha = 0.0})
    }
    
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
    
    var isCompare: Bool = false {
        didSet {
            extraActionButton.isHidden = false
            setSettingsTitle("Add Stocks")
        }
    }
    
    private var collectionId: Int = 0
    
    @objc private func sortTapped() {
        delegate?.stockSortPressed(view: self)
    }
    
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
    
    lazy var sortSmallButton: ResponsiveButton = {
        let button = ResponsiveButton()
        
        button.backgroundColor = .clear
        button.layer.cornerRadius = 4
        button.layer.cornerCurve = .continuous
        
        button.setImage(UIImage(named: "sortSmall"), for: .normal)
        
        button.addTarget(self,
                         action: #selector(sortTapped),
                         for: .touchUpInside)
        
        return button
    }()
    
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
        self.blackAlphaView.isHidden = true
        if Constants.CollectionDetails.top20ID == self.tag {
            backImageView.image = UIImage(named: "top20CollectionBgBig")
            self.imageLoaded = true
            return
        }
        if Constants.CollectionDetails.watchlistCollectionID == self.tag {
            backImageView.image = UIImage(named: "watchlistCollectionBackgroundImage")
            self.imageLoaded = true
            self.blackAlphaView.isHidden = false
            return
        }
        
        var image = UIImage(named: imageName)
        if image == nil {
            image = UIImage(named: imageUrl)
        }
        backImageView.image = image
        self.imageLoaded = (image != nil)
        if imageLoaded {
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
        
        
        let hMargin: CGFloat = 16
        let topMarginLeftSide: CGFloat = (self.shortCollection != nil) ? 56 : 16
        let topMarginRightSide: CGFloat = (self.shortCollection != nil) ? 60 : 19
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
        
        loadImage()
        
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
        
        resize(textView: descriptionLabel)
        
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
        
        if isCompare {
            extraActionButton.frame = CGRect(
                x: hMargin,
                y: bounds.height - (24 + bottomMargin),
                width: 76,
                height: 24
            )
            
            settingsButton.frame = CGRect(
                x: hMargin,
                y: bounds.height - (24 + bottomMargin) * 2.0,
                width: 76,
                height: 24
            )
        } else {
            extraActionButton.frame = CGRect(
                x: hMargin,
                y: bounds.height - (24 + bottomMargin),
                width: 76,
                height: 24
            )
            
            settingsButton.frame = CGRect(
                x: hMargin,
                y: bounds.height - (24 + bottomMargin),
                width: 76,
                height: 24
            )
        }
        
        sortByButton.frame = CGRect(
            x: hMargin + 84,
            y: bounds.height - (24 + bottomMargin),
            width: 149,
            height: 24
        )
        
        sortSmallButton.frame = CGRect(
            x: bounds.width - (24 + 8 + 24 + 8 + 24 + hMargin),
            y: bounds.height - (24 + bottomMargin),
            width: 24,
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
        
        let isTop20 = (Constants.CollectionDetails.top20ID == self.tag) ? true : false
        self.stocksLabel.textColor = isTop20 ? UIColor(hexString: "#09141F", alpha: 1.0) : UIColor.Gainy.white
        self.nameLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.white
        self.descriptionLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.white
        self.stocksAmountLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.yellow
    }
    
    fileprivate func resize(textView: UITextView) {
        var newFrame = textView.frame
        let width = newFrame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: width,
                                                   height: CGFloat.greatestFiniteMagnitude))
        newFrame.size = CGSize(width: width, height: newSize.height)
        textView.frame = newFrame
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
        
        self.imageName = imageName
        self.imageUrl = imageUrl
        self.imageLoaded = false
        
        nameLabel.text = name
        nameLabel.sizeToFit()
        
        descriptionLabel.text = description
        descriptionLabel.sizeToFit()
        
        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()
        
        self.collectionId = collectionId
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionId)
        sortLbl?.text = settings.sortingText()
        
        showListViewButton.backgroundColor = settings.viewMode == .list ?  UIColor.Gainy.blue : .clear
        showGridViewButton.backgroundColor = settings.viewMode == .list ?  .clear :  UIColor.Gainy.blue
        
        layoutIfNeeded()
    }
    
    // MARK: Private
    
    // MARK: Functions
    
    @objc
    private func extraActionButtonTapped(_: UIButton) {
        GainyAnalytics.logEvent("settings_pressed", params: ["collectionID" : collectionId])
        delegate?.settingsPressed(view: self)
    }
    
    @objc
    private func settingsButtonTapped(_: UIButton) {
        if isCompare {
            GainyAnalytics.logEvent("add_stock_to_compare_pressed", params: ["collectionID" : collectionId])
            delegate?.comparePressed(view: self)
        } else {
            GainyAnalytics.logEvent("settings_pressed", params: ["collectionID" : collectionId])
            delegate?.settingsPressed(view: self)
        }
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
