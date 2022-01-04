//
//  CollictionsListHeaderView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 27.08.2021.
//

import UIKit
import PureLayout
import Deviice

class CollictionsListHeaderView: UIView {
    
    lazy var tickerLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Stock Ticker\n"
        return label
    }()
    
    lazy var netLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Net Profit".uppercased()
        return label
    }()
    
    lazy var monthPriceLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Month to day".uppercased()
        return label
    }()
    
    lazy var capLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Market\ncap".uppercased()
        return label
    }()
    
    lazy var peLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "EV/S\n".uppercased()
        return label
    }()
    
    lazy var growLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Growth rate CAGR".uppercased()
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    lazy var firstMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(firstMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var secondMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(secondMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var thirdMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(thirdMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var fourthMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(fourthMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var fifthMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(fifthMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    private var marketDataToShow: [MarketDataField]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    fileprivate func setupView() {
        backgroundColor = .white
        addSubview(tickerLbl)
        tickerLbl.autoSetDimensions(to: CGSize.init(width: 40, height: 24))
        tickerLbl.autoPinEdge(.left, to: .left, of: self, withOffset: 0)
        tickerLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(firstMarketMarkerButton)
        firstMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        firstMarketMarkerButton.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 0)
        firstMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        addSubview(netLbl)
        netLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        netLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 0)
        netLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(secondMarketMarkerButton)
        secondMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        secondMarketMarkerButton.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -63.0 + 17)
        secondMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        addSubview(monthPriceLbl)
        monthPriceLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        monthPriceLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -63.0 + 17)
        monthPriceLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        
        addSubview(thirdMarketMarkerButton)
        thirdMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        thirdMarketMarkerButton.autoPinEdge(.right, to: .right, of: self, withOffset: -111.0 + 17)
        thirdMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        addSubview(capLbl)
        capLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        capLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -111.0 + 17)
        capLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(fourthMarketMarkerButton)
        fourthMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        fourthMarketMarkerButton.autoPinEdge(.right, to: .right, of: self, withOffset: -159.0 + 17)
        fourthMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        addSubview(peLbl)
        peLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        peLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -159.0 + 17)
        peLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        addSubview(fifthMarketMarkerButton)
        fifthMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        fifthMarketMarkerButton.autoPinEdge(.right, to: .right, of: self, withOffset: -207.0 + 17)
        fifthMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        addSubview(growLbl)
        growLbl.autoSetDimensions(to: CGSize.init(width: 44, height: 24))
        growLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -207.0 + 17)
        growLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
    }
    
    func updateMetrics(_ metrics: [MarketDataField]) {
        
        self.marketDataToShow = metrics
        let titles = metrics.prefix(5).map(\.shortTitle)
        let lbls = [growLbl, peLbl, capLbl, monthPriceLbl, netLbl]
        
        if titles.first == Constants.CollectionDetails.matchScore {
            for (ind, val) in titles.reversed().enumerated() {
                lbls[ind].text = val
            }
        } else {
            for (ind, val) in titles.enumerated() {
                lbls[ind].text = val
            }
        }
    }
    
    // MARK: Private

    // MARK: Functions

    @objc
    private func firstMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 4)
    }

    @objc
    private func secondMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 3)
    }

    @objc
    private func thirdMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 2)
    }
    
    @objc
    private func fourthMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 1)
    }
    
    @objc
    private func fifthMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 0)
    }
    
    private func showExplanationForFieldAtIndex(index: Int) {
        
        guard let marketDataToShow = self.marketDataToShow else {
            return
        }
        guard marketDataToShow.count >= 5 else {
            return
        }
        
        let marketData = marketDataToShow[index]
        
        var title = NSLocalizedString("Title", comment: "title")
        var description = NSLocalizedString("Description", comment: "description")
        var height: CGFloat = CGFloat(135.0)
        var linkString: String? = nil
        var link: String? = nil
        
        if marketData == .revenueGrowthYoy {
            title = NSLocalizedString("Quarterly Revenue Growth, Year over Year", comment: "revenu growth explanation title")
            description = NSLocalizedString("Quarterly revenue growth is an increase in a company's sales in one quarter compared to sales of a different quarter.\nUsually, then bigger Revenue Growth than a more attractive financial asset as it has a potential future upside. Read more on investopedia.", comment: "revenu growth explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/terms/q/quarterlyrevenuegrowth.asp"
            height = 185.0
            
        } else if marketData == .enterpriseValueToSales {
            title = NSLocalizedString("Enterprise Value-to-Sales", comment: "Enterprise Value-to-Sales explanation title")
            description = NSLocalizedString("In simple terms, it shows how much the company is valued compared to its sales (revenue) results.\nUsually, a lower EV/sales multiple will indicate that a company may be more attractive or undervalued in the market. Read more on investopedia.", comment: "Enterprise Value-to-Sales explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/terms/e/enterprisevaluesales.asp"
            height = 175.0
        } else if marketData == .marketCapitalization {
            title = NSLocalizedString("Market Capitalization", comment: "Market Capitalization explanation title")
            description = NSLocalizedString("Market capitalization, or \"market cap\" is the aggregate market value of a company represented in dollar amount. Read more on investopedia.", comment: "Market Capitalization explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/investing/market-capitalization-defined/"
            height = 135.0
        } else if marketData == .priceChange1m {
            title = NSLocalizedString("30 days price change", comment: "30 days price change explanation title")
            description = NSLocalizedString("This simple metric shows how a price changed in percentage over the past 30 days to give a perspective on how an asset moved. ", comment: "30 days price change explanation description")
            height = 135.0
        } else if marketData == .matchScore {
            title = NSLocalizedString("Profile matching score", comment: "match score explanation title")
            description = NSLocalizedString("This metric is built based on your profile. We use data like your investments goals, risk profile, investment interests and existing portfolio.", comment: "match score explanation description")
            height = 135.0
        } else if marketData == .profitMargin {
            title = NSLocalizedString("Net Profit Margin", comment:"Net Profit Margin title")
            description = NSLocalizedString("The net profit margin, or simply net margin, measures how much net income or profit is generated as a percentage of revenue. Read more on investopedia.", comment: "Net Profit Margin explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/terms/n/net_margin.asp"
            height = 135.0
        } else {
            return
        }
        
        self.showExplanationWith(title: title, description: description, height: height, linkText: linkString, link: link)
    }
    
    private func showExplanationWith(title: String, description: String, height: CGFloat, linkText: String? = nil, link: String? = nil) {
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: title)
        explanationVc.configureWith(description: description, linkString: linkText, link: link)
        FloatingPanelManager.shared.configureWithHeight(height: height)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
}
