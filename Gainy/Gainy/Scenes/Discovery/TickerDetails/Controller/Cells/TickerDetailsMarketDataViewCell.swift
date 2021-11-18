//
//  TickerDetailsMarketDataViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsMarketDataViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 284.0
    
    @IBOutlet weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.allowsMultipleSelection = true
            innerCollectionView.register(UINib.init(nibName: "TickerDetailsMarketInnerViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier)
        }
    }
    
    override func updateFromTickerData() {
        innerCollectionView.reloadData()
    }
}

extension TickerDetailsMarketDataViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.marketData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TickerDetailsMarketInnerViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier, for: indexPath) as! TickerDetailsMarketInnerViewCell
//        let cell: TickerDetailsMarketInnerViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.marketData = tickerInfo?.marketData[indexPath.row]
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        cell.isSelected = true
        return cell
    }
}

extension TickerDetailsMarketDataViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: (collectionView.frame.size.width - 8.0 * 2.0) / 3.0, height: 96.0)
    }
}

final class TickerDetailsMarketInnerViewCell: UICollectionViewCell {
    
    public var highlightSelection: Bool! = false
    
    @IBOutlet private weak var cornerView: CornerView!
    @IBOutlet private weak var actionButton: UIButton!
    @IBOutlet private weak var pinImageView: UIImageView!
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var periodLbl: UILabel!
    @IBOutlet private weak var valueLbl: UILabel!
    
    func setButtonHidden(isHidden: Bool) {
        
        self.actionButton.isHidden = isHidden
    }
    
    func setSelectionPinHidden(isHidden: Bool) {
        
        self.pinImageView.isHidden = isHidden
    }
    
    var marketData: TickerInfo.MarketData? {
        didSet {
            nameLbl.text = marketData?.name
            periodLbl.text = marketData?.period.uppercased()
            valueLbl.text = marketData?.value
        }
    }
    
    var isForceSelected: Bool = false
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        guard let pinImageView = self.pinImageView else { return }
        guard let cornerView = self.cornerView else { return }
        
        let selected = isForceSelected || isSelected
        
        pinImageView.isHidden = !selected
        
        cornerView.layer.borderWidth = 1.0
        cornerView.layer.borderColor = (selected && highlightSelection) ? UIColor(hexString: "#FC5058", alpha: 1.0)?.cgColor : UIColor.clear.cgColor
    }
    
    @IBAction func onActionButtonTouchUpInside(_ sender: Any) {
        
        guard let name = nameLbl.text, name.count > 0 else {
            return
        }
        
        var title = NSLocalizedString("Title", comment: "title")
        var description = NSLocalizedString("Description", comment: "description")
        var height: CGFloat = CGFloat(135.0)
        var linkString: String? = nil
        var link: String? = nil
        
        // TODO: Get the type of market data, instead of using name
        let nameLowercased = name.lowercased()
        if nameLowercased.contains("Revenue Growth".lowercased()) {
            title = NSLocalizedString("Quarterly Revenue Growth, Year over Year", comment: "revenu growth explanation title")
            description = NSLocalizedString("Quarterly revenue growth is an increase in a company's sales in one quarter compared to sales of a different quarter.\nUsually, then bigger Revenue Growth than a more attractive financial asset as it has a potential future upside. Read more on investopedia.", comment: "revenu growth explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/terms/q/quarterlyrevenuegrowth.asp"
            height = 185.0
            
        } else if nameLowercased.contains("EV/S".lowercased()) {
            title = NSLocalizedString("Enterprise Value-to-Sales", comment: "Enterprise Value-to-Sales explanation title")
            description = NSLocalizedString("In simple terms, it shows how much the company is valued compared to its sales (revenue) results.\nUsually, a lower EV/sales multiple will indicate that a company may be more attractive or undervalued in the market. Read more on investopedia.", comment: "Enterprise Value-to-Sales explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/terms/e/enterprisevaluesales.asp"
            height = 175.0
        } else if nameLowercased.contains("Market Capitalization".lowercased()) {
            title = NSLocalizedString("Market Capitalization", comment: "Market Capitalization explanation title")
            description = NSLocalizedString("Market capitalization, or \"market cap\" is the aggregate market value of a company represented in dollar amount. Read more on investopedia.", comment: "Market Capitalization explanation description")
            linkString = "Read more on investopedia"
            link = "https://www.investopedia.com/investing/market-capitalization-defined/"
            height = 135.0
        } else if nameLowercased.contains("30 days price change".lowercased()) {
            title = NSLocalizedString("30 days price change", comment: "30 days price change explanation title")
            description = NSLocalizedString("This simple metric shows how a price changed in percentage over the past 30 days to give a perspective on how an asset moved. ", comment: "30 days price change explanation description")
            height = 135.0
        } else if nameLowercased.contains("Net Profit Margin".lowercased()) {
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
