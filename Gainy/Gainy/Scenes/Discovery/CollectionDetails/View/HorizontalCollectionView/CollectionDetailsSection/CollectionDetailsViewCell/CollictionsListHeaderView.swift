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
