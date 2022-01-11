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
}

final class TickerDetailsAboutViewCell: TickerDetailsViewCell {
    
    public weak var delegate: TickerDetailsAboutViewCellDelegate?
    
    @IBOutlet private weak var aboutLbl: UILabel!
    @IBOutlet private weak var tagsStack: UIView!
    @IBOutlet private weak var tagsStackHeight: NSLayoutConstraint!
    
    var minHeightUpdated: ((CGFloat) -> Void)?
    private var lines: Int = 1
    
    override func updateFromTickerData() {
        aboutLbl.text = tickerInfo?.about
        aboutLbl.numberOfLines = 3
        
        let tagHeight: CGFloat = 24.0
        let margin: CGFloat = 12.0
        
        if tagsStack.subviews.count == 0 {
            
            let totalWidth: CGFloat = UIScreen.main.bounds.width - 24.0 * 2.0
            var xPos: CGFloat = 0.0
            var yPos: CGFloat = 0.0
            
            for tag in tickerInfo?.tags ?? [] {
                let tagView = TagView()
                tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                 for: .touchUpInside)
                tagsStack.addSubview(tagView)
                if tag.collectionID < 0 {
                    tagView.backgroundColor = UIColor.white
                } else {
                    tagView.backgroundColor = UIColor(hexString: "0062FF", alpha: 1.0)
                }
                
                tagView.collectionID = (tag.collectionID > 0) ? tag.collectionID : nil
                tagView.tagName = tag.name
                tagView.loadImage(url: tag.url)
                let width = 22.0 + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(14)) + margin
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
        minHeightUpdated?(max( (152.0 + 44.0), calculatedHeight))
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
        
        if sender.isSelected {
            aboutLbl.numberOfLines = 0
            sender.setTitle("show less", for: .normal)
        } else {
            aboutLbl.numberOfLines = 3
            sender.setTitle("show more", for: .normal)
        }
        cellHeightChanged?(heightBasedOnString(sender.isSelected ? (tickerInfo?.about ?? "") : (tickerInfo?.aboutShort ?? "")))
        GainyAnalytics.logEvent("ticker_about_more_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
    }
    
    private func heightBasedOnString(_ str: String) -> CGFloat {
        //
        let height = str.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 60.0 * 2.0, font: UIFont.compactRoundedSemibold(12))
        return 60.0 + height + 48.0 + 32.0 + self.tagsStackHeight.constant
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
    
    private lazy var tagLabel: UILabel = {
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
        tagLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 25)
        tagLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 8)
        tagLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
    }
    
    func loadImage(url: String) {
        guard !url.isEmpty else {
            tagImageView.image = nil
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
