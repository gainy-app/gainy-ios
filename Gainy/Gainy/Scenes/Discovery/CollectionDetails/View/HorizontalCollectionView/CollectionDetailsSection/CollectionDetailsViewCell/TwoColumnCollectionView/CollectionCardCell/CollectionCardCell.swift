import UIKit
import PureLayout
import SkeletonView

final class CollectionCardCell: RoundedWithShadowCollectionViewCell {
    // MARK: Lifecycle
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        self.isSkeletonable = true
        contentView.addSubview(companyNameLabel)
        
        companyNameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 48)
        companyNameLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
        companyNameLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -16.0)
        companyNameLabel.autoSetDimension(.height, toSize: 40, relation: NSLayoutConstraint.Relation.lessThanOrEqual)
        
        contentView.addSubview(symbolBackView)
        symbolBackView.addSubview(tickerSymbolLabel)
        contentView.addSubview(todayLabel)
        contentView.addSubview(percentArrowImgView)
        contentView.addSubview(tickerPercentChangeLabel)
        contentView.addSubview(tickerTotalPriceLabel)
        
        contentView.addSubview(marketMarkerOneButton)
        contentView.addSubview(marketMarkerOneTextLabel)
        contentView.addSubview(marketMarkerOneValueLabel)
        
        contentView.addSubview(marketMarkerSecondButton)
        contentView.addSubview(marketMarkerSecondTextLabel)
        contentView.addSubview(marketMarkerSecondValueLabel)
        
        contentView.addSubview(marketMarkerThirdButton)
        contentView.addSubview(marketMarkerThirdTextLabel)
        contentView.addSubview(marketMarkerThirdValueLabel)
        
        contentView.addSubview(leftVerticalSeparator)
        contentView.addSubview(rightVerticalSeparator)
        
        contentView.addSubview(highlightsContainerView)
        contentView.addSubview(highlightLabel)
        
        contentView.addSubview(matchScoreButton)
        contentView.addSubview(matchLabel)
        contentView.addSubview(matchCircle)
        
        symbolBackView.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        symbolBackView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
        
        tickerSymbolLabel.autoPinEdge(.top, to: .top, of: symbolBackView, withOffset: 4)
        tickerSymbolLabel.autoPinEdge(.left, to: .left, of: symbolBackView, withOffset: 8)
        tickerSymbolLabel.autoPinEdge(.right, to: .right, of: symbolBackView, withOffset: -8)
        tickerSymbolLabel.autoPinEdge(.bottom, to: .bottom, of: symbolBackView, withOffset: -4)
        
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
        
        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white
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
        label.textColor = UIColor.Gainy.textDark
        
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
        
        label.font = UIFont(name: "SFCompactRounded-Medium", size: 10)
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
        
        label.font = .compactRoundedSemibold(13)
        label.textColor = UIColor.Gainy.textDark
        
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
    
    lazy var leftVerticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Gainy.lightGray
        
        return view
    }()
    
    lazy var rightVerticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Gainy.lightGray
        
        return view
    }()
    
    
    
    lazy var matchScoreButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.Gainy.white
        
        button.addTarget(self,
                         action: #selector(firstMarketMarkerTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var marketMarkerOneButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.Gainy.white
        
        button.addTarget(self,
                         action: #selector(firstMarketMarkerTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var marketMarkerOneTextLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedMedium(10)
        label.textColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
        
        label.backgroundColor = UIColor.Gainy.white
        
        label.text = "Growth rate CAGR".uppercased()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var marketMarkerOneValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 14)
        label.textColor = UIColor.Gainy.textDark
        
        label.backgroundColor = UIColor.Gainy.white
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var marketMarkerSecondButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.Gainy.white
        
        button.addTarget(self,
                         action: #selector(secondMarketMarkerTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var marketMarkerSecondTextLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedMedium(10)
        label.textColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
        
        label.backgroundColor = UIColor.Gainy.white
        
        label.text = "EV/S"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var marketMarkerSecondValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 14)
        label.textColor = UIColor.Gainy.textDark
        
        label.backgroundColor = UIColor.Gainy.white
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()
    
    
    lazy var marketMarkerThirdButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.Gainy.white
        
        button.addTarget(self,
                         action: #selector(thirdMarketMarkerTapped(_:)),
                         for: .touchUpInside)
        
        return button
    }()
    
    lazy var marketMarkerThirdTextLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedMedium(10)
        label.textColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
        
        label.backgroundColor = UIColor.Gainy.white
        
        label.text = "MARKET CAP"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var marketMarkerThirdValueLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 14)
        label.textColor = UIColor.Gainy.textDark
        
        label.backgroundColor = UIColor.Gainy.white
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
    lazy var highlightsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#E7EAEE", alpha: 1.0)
        
        return view
    }()
    
    lazy var matchCircle: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
        view.tintColor = .white
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
        
        return view
    }()
    
    lazy var matchLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(12.0)
        label.textColor = .white
        label.backgroundColor = UIColor(named: "mainGreen")
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "-"
        label.isSkeletonable = true
        label.isHiddenWhenSkeletonIsActive = true
        return label
    }()
    
    lazy var highlightLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor.Gainy.textDark
        
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutSkeletonIfNeeded()
        let hMargin: CGFloat = 16
        let topMargin: CGFloat = 18
        
//        companyNameLabel.frame = CGRect(
//            x: hMargin,
//            y: topMargin,
//            width: bounds.width - hMargin * 2.0 - 30.0,
//            height: 20
//        )
        
        todayLabel.frame = CGRect(
            x: hMargin,
            y: 90,
            width: 26,
            height: 12
        )
        
        percentArrowImgView.frame = CGRect(
            x: 46,
            y: 92,
            width: 8,
            height: 8
        )
        
        tickerPercentChangeLabel.frame = CGRect(
            x: hMargin + todayLabel.bounds.width + 16,
            y: 90,
            width: 55,
            height: 12
        )
        
        tickerTotalPriceLabel.frame = CGRect(
            x: hMargin,
            y: 80 + 28,
            width: 127,
            height: 20
        )
        
        let markerMarkerWidth = (bounds.width - (12 + 2 + 1 + 2 + 2 + 1 + 2 + 12)) / 3
        let markerTextWidth: CGFloat = 44
        
        marketMarkerOneButton.frame = CGRect(
            x: hMargin - 4,
            y: 110 + 24,
            width: markerMarkerWidth,
            height: 40
        )
        
        marketMarkerOneTextLabel.frame = CGRect(
            x: (hMargin - 4) + ((markerMarkerWidth - 44) / 2),
            y: 110 + 24,
            width: markerTextWidth, // markerMarkerWidth,
            height: 24
        )
        
        marketMarkerOneValueLabel.frame = CGRect(
            x: (hMargin - 4) + ((markerMarkerWidth - 44) / 2),
            y: 134 + 24,
            width: markerTextWidth, // markerMarkerWidth,
            height: 16
        )
        
        marketMarkerSecondButton.frame = CGRect(
            x: (hMargin - 4) + markerMarkerWidth + 2 + 1 + 2,
            y: 110 + 24,
            width: markerMarkerWidth,
            height: 40
        )
        
        marketMarkerSecondTextLabel.frame = CGRect(
            x: (hMargin - 4) + marketMarkerSecondButton.bounds.width + 2 + 1 + 2 + ((markerMarkerWidth - 44) / 2),
            y: 110 + 24,
            width: markerTextWidth,
            height: 24
        )
        
        marketMarkerSecondValueLabel.frame = CGRect(
            x: (hMargin - 4) + marketMarkerSecondButton.bounds.width + 2 + 1 + 2 + ((markerMarkerWidth - 44) / 2),
            y: 134 + 24,
            width: markerTextWidth,
            height: 16
        )
        
        marketMarkerThirdButton.frame = CGRect(
            x: bounds.width - (markerMarkerWidth + (hMargin - 4)),
            y: 110 + 24,
            width: markerMarkerWidth,
            height: 40
        )
        
        marketMarkerThirdTextLabel.frame = CGRect(
            x: bounds.width - (marketMarkerThirdButton.bounds.width + (hMargin - 4)) + ((markerMarkerWidth - 44) / 2),
            y: 110 + 24,
            width: markerTextWidth,
            height: 24
        )
        
        marketMarkerThirdValueLabel.frame = CGRect(
            x: bounds.width - (marketMarkerThirdButton.bounds.width + (hMargin - 4)) + ((markerMarkerWidth - 44) / 2),
            y: 134 + 24,
            width: markerTextWidth,
            height: 16
        )
        
        leftVerticalSeparator.frame = CGRect(
            x: (hMargin - 4) + marketMarkerOneButton.bounds.width + 2,
            y: 112 + 24,
            width: 1,
            height: 38
        )
        
        rightVerticalSeparator.frame = CGRect(
            x: bounds.width - (2 + 1 + markerMarkerWidth + (hMargin - 4)),
            y: 112 + 24,
            width: 1,
            height: 38
        )
        
        highlightsContainerView.frame = CGRect(
            x: 0,
            y: 160 + 24,
            width: bounds.width,
            height: 64
        )
        
        //        highlightsContainerView.layer.cornerRadius = 8
        let mask = CAShapeLayer()
        mask.path = UIBezierPath(
            roundedRect: highlightsContainerView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: 8, height: 8)
        ).cgPath
        highlightsContainerView.layer.mask = mask
        
        highlightLabel.frame = CGRect(
            x: hMargin,
            y: 160 + 28,
            width: bounds.width - (hMargin + hMargin) - 16.0,
            height: highlightsContainerView.bounds.height - (4 + 4)
        )
    }
    
    // MARK: Functions
    
    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        markerMetricHeaders: [String],
        markerMetric: [String],
        highlight: String,
        matchScore: String
    ) {
        companyNameLabel.minimumScaleFactor = 0.1
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.text = companyName
        
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
            ? UIColor.Gainy.green
            : UIColor.Gainy.red
            tickerTotalPriceLabel.sizeToFit()
        }
        
        
        let headers = [marketMarkerOneTextLabel, marketMarkerSecondTextLabel, marketMarkerThirdTextLabel]
        let values = [marketMarkerOneValueLabel, marketMarkerSecondValueLabel, marketMarkerThirdValueLabel]
        for (ind ,val) in markerMetricHeaders.enumerated() {
            headers[ind].text = val
            values[ind].text = markerMetric[ind]
            headers[ind].sizeToFit()
            values[ind].sizeToFit()
        }
        
        highlightLabel.text = highlight
        highlightLabel.sizeToFit()
        
        matchLabel.text = matchScore
        let matchVal = Int(matchScore) ?? 0
        switch matchVal {
        case 0..<35:
            matchLabel.backgroundColor = UIColor.Gainy.mainRed
            break
        case 35..<65:
            matchLabel.backgroundColor = UIColor.Gainy.mainYellow
            break
        case 65...:
            matchLabel.backgroundColor = UIColor.Gainy.mainGreen
            break
        default:
            break
        }
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        companyNameLabel.text = ""
        tickerSymbolLabel.text = ""
        tickerPercentChangeLabel.text = ""
        tickerTotalPriceLabel.text = ""
        
        let headers = [marketMarkerOneTextLabel, marketMarkerSecondTextLabel, marketMarkerThirdTextLabel]
        let values = [marketMarkerOneValueLabel, marketMarkerSecondValueLabel, marketMarkerThirdValueLabel]
        for (ind, _) in headers.enumerated() {
            headers[ind].text = ""
            values[ind].text = ""
        }
        highlightLabel.text = ""
        matchLabel.text = ""
        
        self.isSkeletonable = false
    }
    
    // MARK: Private
    
    // MARK: Functions
    
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
