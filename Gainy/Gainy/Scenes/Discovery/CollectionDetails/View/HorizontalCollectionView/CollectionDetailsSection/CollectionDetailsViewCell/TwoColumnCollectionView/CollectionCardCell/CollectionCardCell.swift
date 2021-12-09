import UIKit
import PureLayout
import SkeletonView

final class CollectionCardCell: RoundedWithShadowCollectionViewCell {
    // MARK: Lifecycle
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        self.isSkeletonable = true
        contentView.addSubview(companyNameLabel)
        
        companyNameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 18)
        companyNameLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
        companyNameLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -16.0 * 2 - 30)
        companyNameLabel.autoSetDimension(.height, toSize: 40, relation: NSLayoutConstraint.Relation.lessThanOrEqual)
        
        contentView.addSubview(tickerSymbolLabel)
        contentView.addSubview(todayLabel)
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
        contentView.addSubview(matchCircle)
        contentView.addSubview(matchLabel)
        
        matchCircle.autoSetDimensions(to: CGSize.init(width: 24.0, height: 24.0))
        matchLabel.autoSetDimensions(to: CGSize.init(width: 24.0, height: 24.0))
        matchScoreButton.autoSetDimensions(to: CGSize.init(width: 24.0, height: 24.0))
        
        matchScoreButton.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        matchScoreButton.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        matchCircle.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        matchCircle.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
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
    
    lazy var tickerSymbolLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor.Gainy.darkGray
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 9)
        label.textColor = UIColor.Gainy.textDark
        
        label.text = "TODAY"
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        
        return label
    }()
    
    lazy var tickerPercentChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Medium", size: 12)
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
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 20)
        
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
        
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 9)
        label.textColor = UIColor.Gainy.darkGray
        
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
        
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 9)
        label.textColor = UIColor.Gainy.darkGray
        
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
        
        label.font = UIFont(name: "SFCompactRounded-Regular", size: 9)
        label.textColor = UIColor.Gainy.darkGray
        
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
        view.backgroundColor = UIColor.Gainy.back
        
        return view
    }()
    
    lazy var matchCircle: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
        view.tintColor = UIColor(named: "mainGreen")
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
        
        return view
    }()
    
    lazy var matchLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(12.0)
        label.textColor = UIColor(named: "mainGreen")
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
        
        tickerSymbolLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + 40.0,
            width: 60,
            height: 20
        )
        
        todayLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + 40 + tickerSymbolLabel.bounds.height + 4,
            width: 26,
            height: 12
        )
        
        tickerPercentChangeLabel.frame = CGRect(
            x: hMargin + todayLabel.bounds.width,
            y: topMargin + 40.0 + tickerSymbolLabel.bounds.height + 4,
            width: 55,
            height: 12
        )
        
        tickerTotalPriceLabel.frame = CGRect(
            x: hMargin,
            y: 80 + 20,
            width: 127,
            height: 20
        )
        
        let markerMarkerWidth = (bounds.width - (12 + 2 + 1 + 2 + 2 + 1 + 2 + 12)) / 3
        let markerTextWidth: CGFloat = 44
        
        marketMarkerOneButton.frame = CGRect(
            x: hMargin - 4,
            y: 110 + 20,
            width: markerMarkerWidth,
            height: 40
        )
        
        marketMarkerOneTextLabel.frame = CGRect(
            x: (hMargin - 4) + ((markerMarkerWidth - 44) / 2),
            y: 110 + 20,
            width: markerTextWidth, // markerMarkerWidth,
            height: 24
        )
        
        marketMarkerOneValueLabel.frame = CGRect(
            x: (hMargin - 4) + ((markerMarkerWidth - 44) / 2),
            y: 134 + 20,
            width: markerTextWidth, // markerMarkerWidth,
            height: 16
        )
        
        marketMarkerSecondButton.frame = CGRect(
            x: (hMargin - 4) + markerMarkerWidth + 2 + 1 + 2,
            y: 110 + 20,
            width: markerMarkerWidth,
            height: 40
        )
        
        marketMarkerSecondTextLabel.frame = CGRect(
            x: (hMargin - 4) + marketMarkerSecondButton.bounds.width + 2 + 1 + 2 + ((markerMarkerWidth - 44) / 2),
            y: 110 + 20,
            width: markerTextWidth,
            height: 24
        )
        
        marketMarkerSecondValueLabel.frame = CGRect(
            x: (hMargin - 4) + marketMarkerSecondButton.bounds.width + 2 + 1 + 2 + ((markerMarkerWidth - 44) / 2),
            y: 134 + 20,
            width: markerTextWidth,
            height: 16
        )
        
        marketMarkerThirdButton.frame = CGRect(
            x: bounds.width - (markerMarkerWidth + (hMargin - 4)),
            y: 110 + 20,
            width: markerMarkerWidth,
            height: 40
        )
        
        marketMarkerThirdTextLabel.frame = CGRect(
            x: bounds.width - (marketMarkerThirdButton.bounds.width + (hMargin - 4)) + ((markerMarkerWidth - 44) / 2),
            y: 110 + 20,
            width: markerTextWidth,
            height: 24
        )
        
        marketMarkerThirdValueLabel.frame = CGRect(
            x: bounds.width - (marketMarkerThirdButton.bounds.width + (hMargin - 4)) + ((markerMarkerWidth - 44) / 2),
            y: 134 + 20,
            width: markerTextWidth,
            height: 16
        )
        
        leftVerticalSeparator.frame = CGRect(
            x: (hMargin - 4) + marketMarkerOneButton.bounds.width + 2,
            y: 112 + 20,
            width: 1,
            height: 38
        )
        
        rightVerticalSeparator.frame = CGRect(
            x: bounds.width - (2 + 1 + markerMarkerWidth + (hMargin - 4)),
            y: 112 + 20,
            width: 1,
            height: 38
        )
        
        highlightsContainerView.frame = CGRect(
            x: 0,
            y: 160 + 20,
            width: bounds.width,
            height: 56
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
            y: 160 + 4 + 20,
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
        matchScore: String,
        isMatch: Bool
    ) {
        companyNameLabel.minimumScaleFactor = 0.1
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.text = companyName
        
        tickerSymbolLabel.text = tickerSymbol
        tickerSymbolLabel.sizeToFit()
        
        tickerPercentChangeLabel.text = tickerPercentChange
        tickerPercentChangeLabel.sizeToFit()
        
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
        if (Int(matchScore) ?? 0) > 50 {
            matchLabel.textColor = UIColor(named: "mainGreen")
            matchCircle.tintColor = UIColor(named: "mainGreen")
        } else {
            matchLabel.textColor = UIColor(named: "mainRed")
            matchCircle.tintColor = UIColor(named: "mainRed")
        }
        
        layoutIfNeeded()
    }
    
    // MARK: Private
    
    // MARK: Functions
    
    @objc
    private func firstMarketMarkerTapped(_: UIButton) {
        let matchScoreExmplanationVc = FeatureDescriptionViewController.init()
        let title = NSLocalizedString("Profile matching score", comment: "match score explanation title")
        let description = NSLocalizedString("This metric is built based on your profile. We use data like your investments goals, risk profile, investment interests and existing portfolio.", comment: "match score explanation description")
        matchScoreExmplanationVc.configureWith(title: title)
        matchScoreExmplanationVc.configureWith(description: description)
        FloatingPanelManager.shared.configureWithHeight(height: 135.0)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: matchScoreExmplanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
    @objc
    private func secondMarketMarkerTapped(_: UIButton) {
        let revenuGrowthVc = FeatureDescriptionViewController.init()
        let title = NSLocalizedString("Quarterly Revenue Growth, Year over Year", comment: "revenu growth explanation title")
        let description = NSLocalizedString("Quarterly revenue growth is an increase in a company's sales in one quarter compared to sales of a different quarter.\nUsually, then bigger Revenue Growth than a more attractive financial asset as it has a potential future upside. Read more on investopedia.", comment: "revenu growth explanation description")
        revenuGrowthVc.configureWith(title: title)
        revenuGrowthVc.configureWith(description: description, linkString: "Read more on investopedia", link: "https://www.investopedia.com/terms/q/quarterlyrevenuegrowth.asp")
        FloatingPanelManager.shared.configureWithHeight(height: 185.0)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: revenuGrowthVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
    @objc
    private func thirdMarketMarkerTapped(_: UIButton) {
        let evsVc = FeatureDescriptionViewController.init()
        let title = NSLocalizedString("Enterprise Value-to-Sales", comment: "Enterprise Value-to-Sales explanation title")
        let description = NSLocalizedString("In simple terms, it shows how much the company is valued compared to its sales (revenue) results.\nUsually, a lower EV/sales multiple will indicate that a company may be more attractive or undervalued in the market. Read more on investopedia.", comment: "Enterprise Value-to-Sales explanation description")
        evsVc.configureWith(title: title)
        evsVc.configureWith(description: description, linkString: "Read more on investopedia", link: "https://www.investopedia.com/terms/e/enterprisevaluesales.asp")
        FloatingPanelManager.shared.configureWithHeight(height: 175.0)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: evsVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
}
