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
    
    override func updateFromTickerData() {
        aboutLbl.text = tickerInfo?.aboutShort
        
        if tagsStack.subviews.count == 0 {
            
            var xPos: CGFloat = 0.0
            tickerInfo?.tags.forEach({
                let tagView = TagView()
                tagsStack.addSubview(tagView)
                
                tagView.tagName = $0
                let width = 22.0 + $0.widthOfString(usingFont: UIFont.compactRoundedSemibold(14)) + 12.0
                tagView.autoSetDimensions(to: CGSize.init(width: width, height: 24))
                tagView.autoPinEdge(.leading, to: .leading, of: tagsStack, withOffset: xPos)
                tagView.autoPinEdge(.top, to: .top, of: tagsStack)
                xPos += width + 12.0
            })
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
        GainyAnalytics.logEvent("ticker_about_more_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none"])
    }
    
    private func heightBasedOnString(_ str: String) -> CGFloat {
        //
        if let height = aboutLbl.text?.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 60.0 * 2.0, font: UIFont.compactRoundedSemibold(12)) {
            return 60.0 + height + 48.0 + 44.0
        }
        return 0.0
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
