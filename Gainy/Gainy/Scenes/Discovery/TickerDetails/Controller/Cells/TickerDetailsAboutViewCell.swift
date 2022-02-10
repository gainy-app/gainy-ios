//
//  TickerDetailsAboutViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import PureLayout

protocol TickerDetailsAboutViewCellDelegate: AnyObject {
    func requestOpenCollection(withID id: Int)
    func aboutExtended(isExtended: Bool)
    func wrongIndPressed()
}

final class TickerDetailsAboutViewCell: TickerDetailsViewCell {
    
    public weak var delegate: TickerDetailsAboutViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet private weak var aboutLbl: UILabel!
    @IBOutlet private weak var tagsStack: UIView!
    @IBOutlet private weak var tagsStackHeight: NSLayoutConstraint!
    @IBOutlet private weak var wrongIndBtn: UIButton!
    
    //MARK: - DI
    var minHeightUpdated: ((CGFloat) -> Void)?
    var isMoreSelected: Bool = false
    
    private var lines: Int = 1
    
    override func updateFromTickerData() {
        aboutLbl.text = tickerInfo?.about
        aboutLbl.numberOfLines = 3
        
        let tagHeight: CGFloat = 24.0
        let margin: CGFloat = 8.0
        
        if tagsStack.subviews.count == 0 {
            
            let totalWidth: CGFloat = UIScreen.main.bounds.width - 24.0 - 64.0
            var xPos: CGFloat = 0.0
            var yPos: CGFloat = 0.0
            
            for tag in tickerInfo?.tags ?? [] {
                let tagView = TagView()
                tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                  for: .touchUpInside)
                tagsStack.addSubview(tagView)
                if tag.collectionID < 0 {
                    tagView.backgroundColor = UIColor.white
                    tagView.tagLabel.textColor = UIColor(named: "mainText")
                    tagView.layer.borderWidth = 1.0
                } else {
                    tagView.backgroundColor = UIColor(hexString: "0062FF", alpha: 1.0)
                    tagView.tagLabel.textColor = .white
                    tagView.layer.borderWidth = 0.0
                }
                
                tagView.collectionID = (tag.collectionID > 0) ? tag.collectionID : nil
                tagView.tagName = tag.name
                tagView.loadImage(url: tag.url)
                let width = (tag.url.isEmpty ? 8.0 : 26.0) + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(12)) + margin
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
        
        let calculatedHeight: CGFloat = (152.0 + 44.0 - tagHeight) + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
        if isMoreSelected {
            aboutLbl.numberOfLines = 0
            minHeightUpdated?(max( (152.0 + 44.0), heightBasedOnString((tickerInfo?.about ?? ""))))
        } else {
            aboutLbl.numberOfLines = 3
            minHeightUpdated?(max( (152.0 + 44.0), calculatedHeight))
        }
    }
    
    @objc func tagViewTouchUpInside(_ tagView: TagView) {
        guard let collectionID = tagView.collectionID, collectionID > 0 else {
            return
        }
        
        self.delegate?.requestOpenCollection(withID: collectionID)
    }
    
    //MARK: - Actions
    @IBAction func showMoreAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        isMoreSelected.toggle()
        delegate?.aboutExtended(isExtended: isMoreSelected)
        if sender.isSelected {
            aboutLbl.numberOfLines = 0
            sender.setTitle("show less", for: .normal)
        } else {
            aboutLbl.numberOfLines = 3
            sender.setTitle("show more", for: .normal)
        }
        cellHeightChanged?(heightBasedOnString(sender.isSelected ? (tickerInfo?.about ?? "") : (tickerInfo?.aboutShort ?? "")))
        if sender.isSelected {
            GainyAnalytics.logEvent("ticker_about_more_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        } else {
            GainyAnalytics.logEvent("ticker_about_less_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        }
    }
    
    private func heightBasedOnString(_ str: String) -> CGFloat {
        //
        let height = str.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 60.0 * 2.0, font: UIFont.compactRoundedSemibold(12))
        return 60.0 + height + 48.0 + 32.0 + self.tagsStackHeight.constant
    }
    
    private func showExplanationWith(title: String, description: String, height: CGFloat, linkText: String? = nil, link: String? = nil) {
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: title)
        explanationVc.configureWith(description: description, linkString: linkText, link: link)
        FloatingPanelManager.shared.configureWithHeight(height: height)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
    //MARK: - Wrong Industry Logic
    
    @IBAction func wrongIndAction(_ sender: UIButton) {
        delegate?.wrongIndPressed()
        highlightIndustries()
    }
    
    func highlightIndustries() {
        wrongIndBtn.isSelected = true
        wrongIndBtn.isEnabled = false
        for (ind, tagInfo) in (tickerInfo?.tags ?? []).enumerated() {
            if let tagView = tagsStack.subviews[ind] as? TagView {
                
                tagView.backgroundColor = UIColor(hexString: "B1BDC8", alpha: 1.0)
                tagView.tagLabel.textColor = .white
                tagView.layer.borderWidth = 0.0
            }
        }
    }
    
    func unhighlightIndustries() {
        wrongIndBtn.isSelected = false
        wrongIndBtn.isEnabled = true
        for (ind, tagInfo) in (tickerInfo?.tags ?? []).enumerated() {
            if let tagView = tagsStack.subviews[ind] as? TagView {
                if tagInfo.collectionID < 0 {
                    tagView.backgroundColor = UIColor.white
                    tagView.tagLabel.textColor = UIColor(named: "mainText")
                    tagView.layer.borderWidth = 1.0
                } else {
                    tagView.backgroundColor = UIColor(hexString: "0062FF", alpha: 1.0)
                    tagView.tagLabel.textColor = .white
                    tagView.layer.borderWidth = 0.0
                }
            }
        }
    }
}


import UIKit
import Kingfisher

class TagView: UIButton {
    
    var collectionID: Int?
    
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
    
    private(set) lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = .white
        tagLabel.font = .compactRoundedSemibold(12)
        return tagLabel
    }()
    
    func changeLayoutForRec() {
        tagLabel.textColor = UIColor(named: "mainText")
        backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private var textLeadingConst: NSLayoutConstraint?
    
    private func setupView() {
        layer.cornerRadius = 4.0
        clipsToBounds = true
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(hexString: "#E7EAEE", alpha: 1.0)?.cgColor
        layer.cornerRadius = 12.0
        
        addSubview(tagImageView)
        tagImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 12))
        tagImageView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 4)
        tagImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        addSubview(tagLabel)
        textLeadingConst = tagLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 25)
        tagLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 8)
        tagLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
    }
    
    func loadImage(url: String) {
        guard !url.isEmpty else {
            tagImageView.image = nil
            textLeadingConst?.constant = 8.0
            layoutIfNeeded()
            return
        }
        let processor = DownsamplingImageProcessor(size: CGSize(width: 19, height: 14))
        tagImageView.kf.setImage(with: URL(string: url), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: nil, completionHandler: nil)
    }
}
