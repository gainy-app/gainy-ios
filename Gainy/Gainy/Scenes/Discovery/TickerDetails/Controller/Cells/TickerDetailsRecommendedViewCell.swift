//
//  TickerDetailsRecommendedViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import Kingfisher

final class TickerDetailsRecommendedViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 168.0
    
    @IBOutlet private weak var rotatableImageView: UIImageView!
    
    @IBOutlet private var recLbls: [UILabel]!
    @IBOutlet private weak var scoreLbl: UILabel!
    @IBOutlet private var recImgs: [UIImageView]!
    @IBOutlet private weak var tagsStack: UIView!
    @IBOutlet private weak var tagsStackHeight: NSLayoutConstraint!
    @IBOutlet var colorView: UIView!
    @IBOutlet private weak var tagsHeaderLbl: UILabel!
    
    private var lines: Int = 1
    
    override func updateFromTickerData() {
        let symbol = tickerInfo?.symbol ?? ""
        guard !(tickerInfo?.isETF ?? false) else {return}
        if let matchData  = TickerLiveStorage.shared.getMatchData(symbol) {
            scoreLbl.text = "\(matchData.matchScore)"
            recImgs[0].image = UIImage(named: "fits_risk\(matchData.fitsRisk)")
            recImgs[1].image = UIImage(named: "fits_risk\(matchData.fitsInterests)")
            recImgs[2].image = UIImage(named: "fits_risk\(matchData.fitsCategories)")
            
            recLbls[0].attributedText = "Fits your risk profile: ".attr(font: .proDisplayRegular(14), color: UIColor(named: "mainText")!) + "\(Int(matchData.riskSimilarity * 100.0))%".attr(font: .proDisplayBold(14), color: UIColor(named: "mainText")!)
            scoreLbl.textColor = UIColor.Gainy.mainText
            colorView.backgroundColor = MatchScoreManager.circleColorFor(matchData.matchScore)
            
            //Tags
            let tagHeight: CGFloat = 24.0
            let margin: CGFloat = 8.0
            
            if tagsStack.subviews.count == 0 {
                let totalWidth: CGFloat = UIScreen.main.bounds.width - 24 * 2.0
                var xPos: CGFloat = 0.0
                var yPos: CGFloat = 0.0
                for tag in tickerInfo?.matchTags ?? [] {
                    let tagView = TagView()
                    
                    tagView.backgroundColor = UIColor.white
                    tagView.tagLabel.textColor = UIColor(named: "mainText")
                    tagView.loadImage(url: tag.url)
                    
                    tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                     for: .touchUpInside)
                    tagsStack.addSubview(tagView)
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
            
            let calculatedHeight: CGFloat = 192.0 + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1) + 24.0
            if (tickerInfo?.matchTags ?? []).count > 0 {
                cellHeightChanged?(max((TickerDetailsRecommendedViewCell.cellHeight), calculatedHeight))
                tagsHeaderLbl.isHidden = false
            } else {
                cellHeightChanged?(TickerDetailsRecommendedViewCell.cellHeight)
                tagsHeaderLbl.isHidden = true
            }
        } else {
            scoreLbl.text = "0"
            colorView.backgroundColor = UIColor.Gainy.mainRed
            scoreLbl.textColor = UIColor(named: "mainText")
            cellHeightChanged?(TickerDetailsRecommendedViewCell.cellHeight)
            tagsHeaderLbl.isHidden = true
        }
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
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
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
