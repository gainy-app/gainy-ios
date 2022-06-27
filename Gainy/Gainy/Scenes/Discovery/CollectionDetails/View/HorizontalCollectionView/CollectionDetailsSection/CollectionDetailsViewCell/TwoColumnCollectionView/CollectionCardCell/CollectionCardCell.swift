import UIKit
import PureLayout
import SkeletonView

final class CollectionCardCell: RoundedWithShadowCollectionViewCell {
    // MARK: Lifecycle
    
    var tickerSymbol: String? = nil
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        self.isSkeletonable = true
        
        contentView.addSubview(symbolBackView)
        symbolBackView.addSubview(tickerSymbolLabel)
        symbolBackView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        symbolBackView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
        tickerSymbolLabel.autoPinEdge(.top, to: .top, of: symbolBackView, withOffset: 2)
        tickerSymbolLabel.autoPinEdge(.left, to: .left, of: symbolBackView, withOffset: 4)
        tickerSymbolLabel.autoPinEdge(.right, to: .right, of: symbolBackView, withOffset: -4)
        tickerSymbolLabel.autoPinEdge(.bottom, to: .bottom, of: symbolBackView, withOffset: -2)
        
        contentView.addSubview(matchScoreButton)
        contentView.addSubview(matchLabel)
        contentView.addSubview(matchCircle)
        matchCircle.autoSetDimensions(to: CGSize.init(width: 22, height: 22))
        matchLabel.autoSetDimensions(to: CGSize.init(width: 24.0, height: 24.0))
        matchScoreButton.autoSetDimensions(to: CGSize.init(width: 24.0, height: 24.0))
        matchLabel.layer.cornerRadius = 24.0 / 2.0
        matchLabel.clipsToBounds = true
        matchScoreButton.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        matchScoreButton.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        matchCircle.autoPinEdge(.top, to: .top, of: contentView, withOffset: 17)
        matchCircle.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -17)
        matchLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        matchLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        
        contentView.addSubview(companyNameLabel)
        companyNameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 56)
        companyNameLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
        companyNameLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -16.0)
        companyNameLabel.autoSetDimension(.height, toSize: 32, relation: NSLayoutConstraint.Relation.lessThanOrEqual)
        
    
        
        contentView.addSubview(todayLabel)
        todayLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        todayLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40)
        todayLabel.autoSetDimension(.height, toSize: 16)
        
        contentView.addSubview(percentArrowImgView)
        percentArrowImgView.autoAlignAxis(.horizontal, toSameAxisOf: todayLabel)
        percentArrowImgView.autoPinEdge(.left, to: .right, of: todayLabel, withOffset: 4)
        
        contentView.addSubview(tickerPercentChangeLabel)
        tickerPercentChangeLabel.autoAlignAxis(.horizontal, toSameAxisOf: todayLabel)
        tickerPercentChangeLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 40)
        tickerPercentChangeLabel.autoSetDimension(.height, toSize: 16)
        tickerPercentChangeLabel.autoPinEdge(.left, to: .right, of: percentArrowImgView, withOffset: 4)
        
        contentView.addSubview(tickerTotalPriceLabel)
        tickerTotalPriceLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
        tickerTotalPriceLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        tickerTotalPriceLabel.autoSetDimension(.height, toSize: 24)
       
        contentView.addSubview(addRemoveWatchlistButton)
        addRemoveWatchlistButton.autoSetDimensions(to: CGSize.init(width: 40, height: 40))
        addRemoveWatchlistButton.autoPinEdge(toSuperviewEdge: .right)
        addRemoveWatchlistButton.autoPinEdge(toSuperviewEdge: .bottom)
        
        layer.isOpaque = true
        backgroundColor = RemoteConfigManager.shared.mainButtonColor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    // MARK: Properties
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        
        // smth like: UIFont.Gainy.SFProDisplay
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var symbolBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Gainy.tickerSymbol.withAlphaComponent(0.15)
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var tickerSymbolLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedSemibold(12.0)
        label.textColor = UIColor.Gainy.tickerSymbol
        label.numberOfLines = 1
        label.layer.cornerRadius = 4.0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedSemibold(14.0)
        label.textColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
        
        label.text = "Today"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var percentArrowImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow-up-green")
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var tickerPercentChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedSemibold(14)
        label.textColor = UIColor.Gainy.mainGreen
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
    lazy var tickerTotalPriceLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 16)
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
    lazy var matchScoreButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.Gainy.white
        
        button.addTarget(self,
                         action: #selector(matchScoreTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var matchCircle: UIImageView = {
        let view = UIImageView()
        view.alpha = 0.63
        view.backgroundColor = .clear
        view.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor.init(hexString: "#09141F")
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
        
        return view
    }()
    
    lazy var matchLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(12.0)
        label.textColor = UIColor.init(hexString: "#09141F")
        label.backgroundColor = UIColor(named: "thirdGreen")
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "-"
        label.isSkeletonable = true
        label.isHiddenWhenSkeletonIsActive = true
        return label
    }()
    
    lazy var addRemoveWatchlistButton: ResponsiveButton = {
        let button = ResponsiveButton()
        
        button.isSkeletonable = true
        button.isHiddenWhenSkeletonIsActive = true
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage.init(named: "add_to_wl"), for: .normal)
        button.setImage(UIImage.init(named: "remove_from_wl"), for: .selected)
        button.addTarget(self,
                         action: #selector(addRemoveWatchlistTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSkeletonIfNeeded()
    }
    
    // MARK: Functions
    
    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        matchScore: String
    ) {
        companyNameLabel.minimumScaleFactor = 0.1
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.text = companyName
        companyNameLabel.sizeToFit()
        
        self.tickerSymbol = tickerSymbol
        tickerSymbolLabel.text = tickerSymbol
        tickerSymbolLabel.sizeToFit()
        
        tickerPercentChangeLabel.text = tickerPercentChange.replacingOccurrences(of: " +", with: "").replacingOccurrences(of: " -", with: "").replacingOccurrences(of: "-", with: "")
        tickerPercentChangeLabel.textColor = tickerPercentChange.hasPrefix(" +")
        ? UIColor.Gainy.green
        : UIColor.Gainy.red
        tickerPercentChangeLabel.sizeToFit()
        
        percentArrowImgView.image = tickerPercentChange.hasPrefix(" +") ? UIImage(named: "arrow-up-green") : UIImage(named: "arrow-down-red")
        
        if companyName.hasPrefix(Constants.CollectionDetails.demoNamePrefix) || tickerPrice.isEmpty {
            tickerTotalPriceLabel.text = ""
        } else {
            tickerTotalPriceLabel.text = "$\(tickerPrice)"
            tickerTotalPriceLabel.textColor = tickerPercentChange.hasPrefix(" +")
            ? UIColor.Gainy.mainGreen
            : UIColor.Gainy.mainRed
            tickerTotalPriceLabel.sizeToFit()
        }
        
        matchLabel.text = matchScore
        matchLabel.backgroundColor = MatchScoreManager.circleColorFor(Int(matchScore) ?? 0)
        
        let inWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == tickerSymbol
        }
        addRemoveWatchlistButton.isSelected = inWatchlist
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        companyNameLabel.text = ""
        tickerSymbolLabel.text = ""
        tickerPercentChangeLabel.text = ""
        tickerTotalPriceLabel.text = ""
        matchLabel.text = ""
        
        self.addRemoveWatchlistButton.isSelected = false
        self.isSkeletonable = false
    }
    
    // MARK: Private
    
    // MARK: Functions
    @objc
    private func matchScoreTapped(_: UIButton) {
        let marketData = MarketDataField.matchScore
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: marketData.explanationTitle)
        explanationVc.configureWith(description: marketData.explanationDescription,
                                    linkString: marketData.explanationLinkString,
                                    link: marketData.explanationLink)
        FloatingPanelManager.shared.configureWithHeight(height: CGFloat(marketData.explanationHeight))
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
    @objc
    private func addRemoveWatchlistTapped(_: UIButton) {
        
        guard let symbol = tickerSymbol else {
            return
        }
        
        let addedToWatchlist = UserProfileManager.shared.watchlist.contains { item in
            item == tickerSymbol
        }
        if addedToWatchlist {
            GainyAnalytics.logEvent("remove_from_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TTF Card"])
            UserProfileManager.shared.removeTickerFromWatchlist(symbol) { success in
                if success {
                    self.addRemoveWatchlistButton.isSelected = false
                }
            }
        } else {
            GainyAnalytics.logEvent("add_to_watch_pressed", params: ["tickerSymbol" : symbol, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TTF Card"])
            UserProfileManager.shared.addTickerToWatchlist(symbol) { success in
                if success {
                    self.addRemoveWatchlistButton.isSelected = true
                }
            }
        }
        self.addRemoveWatchlistButton.isSelected = !self.addRemoveWatchlistButton.isSelected
    }
    
    @objc
    private func firstMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 0)
    }
    
    @objc
    private func secondMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 1)
    }
    
    @objc
    private func thirdMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 2)
    }
    
    private func showExplanationForFieldAtIndex(index: Int) {
        
        let collectionID = self.tag
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionID)
        let marketDataToShow = settings.marketDataToShow.prefix(3)
        guard marketDataToShow.count == 3 else {
            return
        }
 
        let marketData = marketDataToShow[index]
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: marketData.explanationTitle)
        explanationVc.configureWith(description: marketData.explanationDescription,
                                    linkString: marketData.explanationLinkString,
                                    link: marketData.explanationLink)
        FloatingPanelManager.shared.configureWithHeight(height: CGFloat(marketData.explanationHeight))
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
}
