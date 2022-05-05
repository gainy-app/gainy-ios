//
//  TickerDetailsAboutViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import PureLayout

protocol TickerDetailsAboutViewCellDelegate: AnyObject {
    func aboutExtended(isExtended: Bool)
}

final class TickerDetailsAboutViewCell: TickerDetailsViewCell {
    
    public weak var delegate: TickerDetailsAboutViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet private weak var aboutLbl: UILabel!
    @IBOutlet private weak var tagsStack: UIView!
    
    //MARK: - DI
    var minHeightUpdated: ((CGFloat) -> Void)?
    var isMoreSelected: Bool = false
    
    private var lines: Int = 1
    
    override func updateFromTickerData() {
        aboutLbl.text = tickerInfo?.about
        aboutLbl.numberOfLines = 3
        
        let calculatedHeight: CGFloat = (152.0 + 44.0 + 88)
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
        return 60.0 + height + 48.0 + 32.0 + 88.0
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
