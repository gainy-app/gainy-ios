import UIKit

final class CollectionCardCell: RoundedWithShadowCollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        // TODO: 1: make order in the init consistent
        contentView.addSubview(companyNameLabel)
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

        // TODO: use extensions for custom fonts to avoid typos (around the app)
        // smth like: UIFont.Gainy.SFProDisplay
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.Gainy.textDark

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var tickerSymbolLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor.Gainy.darkGray

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

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

        return label
    }()

    lazy var tickerPercentChangeLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Medium", size: 12)
        label.textColor = UIColor.Gainy.textDark

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    lazy var tickerTotalPriceLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 20)

        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    // TODO: 1: use custom View
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

    // TODO: 1: use custom Button
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

        label.text = "DIVIDEND GROWTH"
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center

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

        return label
    }()

    // TODO: 1: use custom Button
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
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center

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

        return label
    }()

    // TODO: 1: use custom Button
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

        return label
    }()

    lazy var highlightsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.Gainy.back

        return view
    }()

    lazy var highlightLabel: UILabel = {
        let label = UILabel()

        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor.Gainy.textDark

        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left

        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()

        let hMargin: CGFloat = 16
        let topMargin: CGFloat = 18

        companyNameLabel.frame = CGRect(
            x: hMargin,
            y: topMargin,
            width: 85,
            height: 20
        )

        tickerSymbolLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + companyNameLabel.bounds.height,
            width: 45,
            height: 20
        )

        todayLabel.frame = CGRect(
            x: hMargin,
            y: topMargin + companyNameLabel.bounds.height + tickerSymbolLabel.bounds.height + 4,
            width: 26,
            height: 12
        )

        tickerPercentChangeLabel.frame = CGRect(
            x: hMargin + todayLabel.bounds.width,
            y: topMargin + companyNameLabel.bounds.height + tickerSymbolLabel.bounds.height + 4,
            width: 55,
            height: 12
        )

        tickerTotalPriceLabel.frame = CGRect(
            x: hMargin,
            y: 80,
            width: 127,
            height: 20
        )

        let markerMarkerWidth = (bounds.width - (12 + 2 + 1 + 2 + 2 + 1 + 2 + 12)) / 3
        let markerTextWidth: CGFloat = 44

        marketMarkerOneButton.frame = CGRect(
            x: hMargin - 4,
            y: 110,
            width: markerMarkerWidth,
            height: 40
        )

        marketMarkerOneTextLabel.frame = CGRect(
            x: (hMargin - 4) + ((markerMarkerWidth - 44) / 2),
            y: 110,
            width: markerTextWidth, // markerMarkerWidth,
            height: 24
        )

        marketMarkerOneValueLabel.frame = CGRect(
            x: (hMargin - 4) + ((markerMarkerWidth - 44) / 2),
            y: 134,
            width: markerTextWidth, // markerMarkerWidth,
            height: 16
        )

        marketMarkerSecondButton.frame = CGRect(
            x: (hMargin - 4) + markerMarkerWidth + 2 + 1 + 2,
            y: 110,
            width: markerMarkerWidth,
            height: 40
        )

        marketMarkerSecondTextLabel.frame = CGRect(
            x: (hMargin - 4) + marketMarkerSecondButton.bounds.width + 2 + 1 + 2 + ((markerMarkerWidth - 44) / 2),
            y: 110,
            width: markerTextWidth,
            height: 24
        )

        marketMarkerSecondValueLabel.frame = CGRect(
            x: (hMargin - 4) + marketMarkerSecondButton.bounds.width + 2 + 1 + 2 + ((markerMarkerWidth - 44) / 2),
            y: 134,
            width: markerTextWidth,
            height: 16
        )

        marketMarkerThirdButton.frame = CGRect(
            x: bounds.width - (markerMarkerWidth + (hMargin - 4)),
            y: 110,
            width: markerMarkerWidth,
            height: 40
        )

        marketMarkerThirdTextLabel.frame = CGRect(
            x: bounds.width - (marketMarkerThirdButton.bounds.width + (hMargin - 4)) + ((markerMarkerWidth - 44) / 2),
            y: 110,
            width: markerTextWidth,
            height: 24
        )

        marketMarkerThirdValueLabel.frame = CGRect(
            x: bounds.width - (marketMarkerThirdButton.bounds.width + (hMargin - 4)) + ((markerMarkerWidth - 44) / 2),
            y: 134,
            width: markerTextWidth,
            height: 16
        )

        leftVerticalSeparator.frame = CGRect(
            x: (hMargin - 4) + marketMarkerOneButton.bounds.width + 2,
            y: 112,
            width: 1,
            height: 38
        )

        rightVerticalSeparator.frame = CGRect(
            x: bounds.width - (2 + 1 + markerMarkerWidth + (hMargin - 4)),
            y: 112,
            width: 1,
            height: 38
        )

        highlightsContainerView.frame = CGRect(
            x: 0,
            y: 160,
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
            y: 160 + 4,
            width: bounds.width - (hMargin + hMargin),
            height: highlightsContainerView.bounds.height - (4 + 4)
        )
    }

    // MARK: Functions

    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        markerMetricFirst: String,
        marketMetricSecond: String,
        marketMetricThird: String,
        highlight: String
    ) {
        companyNameLabel.text = companyName
        companyNameLabel.sizeToFit()

        tickerSymbolLabel.text = tickerSymbol
        tickerSymbolLabel.sizeToFit()

        tickerPercentChangeLabel.text = tickerPercentChange
        tickerPercentChangeLabel.sizeToFit()

        tickerTotalPriceLabel.text = "$\(tickerPrice)"
        tickerTotalPriceLabel.textColor = tickerPercentChange.hasPrefix(" +")
            ? UIColor.Gainy.green
            : UIColor.Gainy.red
        tickerTotalPriceLabel.sizeToFit()

        marketMarkerOneValueLabel.text = "\(markerMetricFirst)%"
        marketMarkerOneValueLabel.sizeToFit()

        marketMarkerSecondValueLabel.text = marketMetricSecond
        marketMarkerSecondValueLabel.sizeToFit()

        marketMarkerThirdValueLabel.text = marketMetricThird
        marketMarkerThirdValueLabel.sizeToFit()

        highlightLabel.text = highlight
        highlightLabel.sizeToFit()

        layoutIfNeeded()
    }

    // MARK: Private

    // MARK: Functions

    @objc
    private func firstMarketMarkerTapped(_: UIButton) {}

    @objc
    private func secondMarketMarkerTapped(_: UIButton) {}

    @objc
    private func thirdMarketMarkerTapped(_: UIButton) {}
}
