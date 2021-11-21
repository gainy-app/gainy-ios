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
            let categories = ["defensive", "speculation", "penny", "dividend", "momentum", "value", "growth"]
            
            for tag in tickerInfo?.tags ?? [] {
                let tagView = TagView()
                tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                 for: .touchUpInside)
                tagsStack.addSubview(tagView)
                if !categories.contains(where: { element in
                    element.isEqual(tag.lowercased())
                }) {
                    tagView.backgroundColor = UIColor.lightGray
                } else {
                    tagView.backgroundColor = UIColor(hex: 0x3A4448)
                }
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
        let panelInfo = CategoriesTipsGenerator.getInfoForPanel(name)
        if !panelInfo.title.isEmpty {
            self.showExplanationWith(title: panelInfo.title, description: panelInfo.description, height: panelInfo.height)
        }
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
