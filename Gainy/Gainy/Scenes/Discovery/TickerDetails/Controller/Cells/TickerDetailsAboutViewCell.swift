//
//  TickerDetailsAboutViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import PureLayout

final class TickerDetailsAboutViewCell: TickerDetailsViewCell {
    
    @IBOutlet private weak var aboutLbl: UILabel!
    @IBOutlet private weak var tagsStack: UIView!
    @IBOutlet private weak var tagsStackHeight: NSLayoutConstraint!
    
    var minHeightUpdated: ((CGFloat) -> Void)?
    private var lines: Int = 1
    override func updateFromTickerData() {
        aboutLbl.text = tickerInfo?.aboutShort
        
        
        let tagHeight: CGFloat = 24.0
        let margin: CGFloat = 12.0
        
        if tagsStack.subviews.count == 0 {
            
            let totalWidth: CGFloat = UIScreen.main.bounds.width - 28.0 * 2.0
            var xPos: CGFloat = 0.0
            var yPos: CGFloat = 0.0
            //            for tag in ["Defensive", "Speculation", "Penny", "Dividend", "Momentum", "Value", "Growth",] {
            for tag in tickerInfo?.tags ?? [] {
                let tagView = TagView()
                tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                 for: .touchUpInside)
                tagsStack.addSubview(tagView)
                
                tagView.tagName = tag
                let width = 22.0 + tag.widthOfString(usingFont: UIFont.compactRoundedSemibold(14)) + margin
                tagView.autoSetDimensions(to: CGSize.init(width: width, height: tagHeight))
                if xPos + width + margin > totalWidth && tagsStack.subviews.count > 0 {
                    xPos = 0.0
                    yPos = yPos + tagHeight + margin
                    lines += 1
                }
                tagView.autoPinEdge(.leading, to: .leading, of: tagsStack, withOffset: xPos)
                tagView.autoPinEdge(.top, to: .top, of: tagsStack, withOffset: yPos)
                xPos += width + margin
            }
        }
            
        self.tagsStackHeight.constant = tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
        self.tagsStack.layoutIfNeeded()
        
        let calculatedHeight: CGFloat = (164.0 + 44.0 - tagHeight) + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
        minHeightUpdated?(max( (164.0 + 44.0), calculatedHeight))
    }
    
    @objc func tagViewTouchUpInside(_ tagView: TagView) {
        guard let name = tagView.tagName, name.count > 0 else {
            return
        }
        
        var title = NSLocalizedString("Title", comment: "title")
        var description = NSLocalizedString("Description", comment: "description")
        var height: CGFloat = CGFloat(135.0)
        
        // TODO: Move the logic outside of this class; don't attach to the name
        let nameLowercased = name.lowercased()
        if nameLowercased.contains("Defensive".lowercased()) {
            title = NSLocalizedString("Defensive", comment: "Defensive")
            description = NSLocalizedString("Defensive - a historically calculated metric of stocks that provide consistent dividends and stable earnings regardless of the state of the overall stock market.", comment: "Defensive desc")
            height = 145.0
            
        } else if nameLowercased.contains("Speculation".lowercased()) || nameLowercased.contains("Speculative".lowercased()) {
            title = NSLocalizedString("Speculation", comment: "Speculation")
            description = NSLocalizedString("A speculative stock is a stock that a trader uses to speculate. The fundamentals of the stock do not show an apparent strength or sustainable business model, leading it to be viewed as very risky and trade at a comparatively low price, although the trader is hopeful that this will one day change.", comment: "Speculation desc")
            height = 185.0
        } else if nameLowercased.contains("Penny".lowercased()) {
            title = NSLocalizedString("Penny", comment: "Penny")
            description = NSLocalizedString("A penny stock typically refers to a small company's stock that trades for less than $5 per share.", comment: "Penny desc")
            height = 135.0
        } else if nameLowercased.contains("Dividend".lowercased()) {
            title = NSLocalizedString("Dividend", comment: "Dividend")
            description = NSLocalizedString("It is usually a more stable but with a slower growth company. Dividend stocks are companies that pay out regular dividends.", comment: "Dividend desc")
            height = 145.0
        } else if nameLowercased.contains("Momentum".lowercased()) {
            title = NSLocalizedString("Momentum", comment: "Momentum")
            description = NSLocalizedString("Momentum stocks is simply the stocks that are yielding higher returns over the past three, six, or 12 months than the S&P 500. They currently perform better than their peers but might have potential downside trend when the momentum is over. ", comment: "Momentum desc")
            height = 175.0
        } else if nameLowercased.contains("Value".lowercased()) {
            title = NSLocalizedString("Value", comment: "Value")
            description = NSLocalizedString("A value stock is one that is cheap in relation to such basic measures of corporate performance as earnings, sales, book value and cash flow.", comment: "Value desc")
            height = 145.0
        } else if nameLowercased.contains("Growth".lowercased()) {
            title = NSLocalizedString("Growth", comment: "Growth")
            description = NSLocalizedString("A growth stock is any share in a company that is anticipated to grow at a rate significantly above the average growth for the market.", comment: "Growth desc")
            height = 145.0
        } else {
            // Not a category
            return
        }
        
        self.showExplanationWith(title: title, description: description, height: height)
    }
    
    //MARK: - Actions
    @IBAction func showMoreAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            aboutLbl.text = tickerInfo?.about
            sender.setTitle("show less", for: .normal)
        } else {
            aboutLbl.text = tickerInfo?.aboutShort
            sender.setTitle("show more", for: .normal)
        }
        cellHeightChanged?(heightBasedOnString(aboutLbl.text ?? ""))
        GainyAnalytics.logEvent("ticker_about_more_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
    }
    
    private func heightBasedOnString(_ str: String) -> CGFloat {
        //
        if let height = aboutLbl.text?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 60.0 * 2.0, font: UIFont.compactRoundedSemibold(12)) {
            return 60.0 + height + 48.0 + 32.0 + self.tagsStackHeight.constant
        }
        return 0.0
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


import UIKit


class TagView: UIButton {
    
    var tagName: String? {
        didSet {
            tagLabel.text = tagName?.uppercased()
        }
    }
    
    private lazy var tagImageView: UIImageView = {
        let tagImageView = UIImageView()
        tagImageView.contentMode = .scaleAspectFill
        tagImageView.image = UIImage(named: "demoRocket")
        return tagImageView
    }()
    
    private lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = .white
        tagLabel.font = .compactRoundedSemibold(12)
        return tagLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 4.0
        clipsToBounds = true
        backgroundColor = UIColor(hexString: "3A4448")!
        
        addSubview(tagImageView)
        tagImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 12))
        tagImageView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 4)
        tagImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        addSubview(tagLabel)
        tagLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 25)
        tagLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 8)
        tagLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
    }
}
