//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionChartCardCell: RoundedDashedCollectionViewCell {
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        self.isSkeletonable = true
        
        contentView.addSubview(symbolBackView)
        symbolBackView.addSubview(tickerSymbolLabel)
        symbolBackView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
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
        matchScoreButton.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16)
        matchCircle.autoPinEdge(.top, to: .top, of: contentView, withOffset: 17)
        matchCircle.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 17)
        matchLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        matchLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16)
        
        contentView.addSubview(companyNameLabel)
        companyNameLabel.autoAlignAxis(.horizontal, toSameAxisOf: matchScoreButton)
        companyNameLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 48)
        companyNameLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -16.0)
        companyNameLabel.autoSetDimension(.height, toSize: 20.0)
        
        contentView.addSubview(tickerTotalPriceLabel)
        let constraint = tickerTotalPriceLabel.autoPinEdge(toSuperviewEdge: .left, withInset:60.0)
        constraint.priority = UILayoutPriority.defaultLow
        tickerTotalPriceLabel.autoPinEdge(.left, to: .right, of: symbolBackView, withOffset: 3, relation: NSLayoutConstraint.Relation.greaterThanOrEqual)
        tickerTotalPriceLabel.autoAlignAxis(.horizontal, toSameAxisOf: symbolBackView)
        tickerTotalPriceLabel.autoSetDimension(.height, toSize: 16)
        
        contentView.addSubview(fourthMarkerLabel)
        fourthMarkerLabel.autoAlignAxis(.horizontal, toSameAxisOf: tickerTotalPriceLabel)
        fourthMarkerLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        fourthMarkerLabel.autoSetDimension(.width, toSize: 48.0)
        
        contentView.addSubview(thirdMarkerLabel)
        thirdMarkerLabel.autoAlignAxis(.horizontal, toSameAxisOf: tickerTotalPriceLabel)
        thirdMarkerLabel.autoPinEdge(.right, to: .left, of: fourthMarkerLabel)
        thirdMarkerLabel.autoSetDimension(.width, toSize: 48.0)
        
        contentView.addSubview(secondMarkerLabel)
        secondMarkerLabel.autoAlignAxis(.horizontal, toSameAxisOf: tickerTotalPriceLabel)
        secondMarkerLabel.autoPinEdge(.right, to: .left, of: thirdMarkerLabel)
        secondMarkerLabel.autoSetDimension(.width, toSize: 48.0)
        
        contentView.addSubview(firstMarkerLabel)
        firstMarkerLabel.autoAlignAxis(.horizontal, toSameAxisOf: tickerTotalPriceLabel)
        firstMarkerLabel.autoPinEdge(.right, to: .left, of: secondMarkerLabel)
        firstMarkerLabel.autoSetDimension(.width, toSize: 48.0)
        
        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithChartData(data: GetTtfPieChartQuery.Data.CollectionPiechart) {
        
        
    }
    
    func configureWith(
        companyName: String,
        tickerSymbol: String,
        tickerPercentChange: String,
        tickerPrice: String,
        markerHeaders: [String],
        markerMetrics: [String],
        matchScore: String
    ) {
        companyNameLabel.minimumScaleFactor = 0.1
        companyNameLabel.adjustsFontSizeToFitWidth = true
        companyNameLabel.text = companyName
        companyNameLabel.sizeToFit()
        
        tickerSymbolLabel.text = tickerSymbol
        tickerSymbolLabel.sizeToFit()

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
        let matchVal = Int(matchScore) ?? 0
        switch matchVal {
        case 0..<35:
            matchLabel.backgroundColor = UIColor.Gainy.secondaryLightGray
            break
        case 35..<65:
            matchLabel.backgroundColor = UIColor.Gainy.secondaryYellow
            break
        case 65...:
            matchLabel.backgroundColor = UIColor.Gainy.thirdGreen
            break
        default:
            break
        }

        let lbls = [firstMarkerLabel, secondMarkerLabel, thirdMarkerLabel, fourthMarkerLabel]
        for (ind, val) in markerMetrics.enumerated() {
            lbls[ind].text = val
        }
        
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        companyNameLabel.text = ""
        tickerSymbolLabel.text = ""
        tickerTotalPriceLabel.text = ""
        matchLabel.text = ""
        self.isSkeletonable = false
        [firstMarkerLabel, secondMarkerLabel, thirdMarkerLabel, fourthMarkerLabel, fifthMarkerLabel, companyNameLabel, tickerSymbolLabel, matchLabel].forEach({
            $0.linesCornerRadius = 6
            $0.numberOfLines = 1
        })
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
    }
    
    // MARK: Internal
    
    // MARK: Properties
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        
        // smth like: UIFont.Gainy.SFProDisplay
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
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
    
    lazy var firstMarkerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var secondMarkerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var thirdMarkerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var fourthMarkerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var fifthMarkerLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
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
}
