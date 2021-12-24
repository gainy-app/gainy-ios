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
    
    private var lines: Int = 1
    
    override func updateFromTickerData() {
        let symbol = tickerInfo?.symbol ?? ""
        if let matchData  = TickerLiveStorage.shared.getMatchData(symbol) {
            scoreLbl.text = "\(matchData.matchScore)"
            recImgs[0].image = UIImage(named: "fits_risk\(matchData.fitsRisk)")
            recImgs[1].image = UIImage(named: "fits_risk\(matchData.fitsInterests)")
            recImgs[2].image = UIImage(named: "fits_risk\(matchData.fitsCategories)")
            
            recLbls[0].attributedText = "Fit your risk profile: ".attr(font: .proDisplayRegular(14), color: UIColor(named: "mainText")!) + "\(Int(matchData.riskSimilarity * 100.0))%".attr(font: .proDisplayBold(14), color: UIColor(named: "mainText")!)
            switch matchData.matchScore {
            case 0..<55:
                contentView.backgroundColor = UIColor(hexString: "FFCCCC", alpha: 1.0)
                break
            case 55..<75:
                contentView.backgroundColor = UIColor.Gainy.mainYellow
                break
            case 75...:
                contentView.backgroundColor = UIColor.Gainy.mainGreen
                break
            default:
                break
            }
            
            //Tags
            let tagHeight: CGFloat = 24.0
            let margin: CGFloat = 12.0
            
            if tagsStack.subviews.count == 0 {
                let totalWidth: CGFloat = UIScreen.main.bounds.width - 26.0 * 2.0
                var xPos: CGFloat = 0.0
                var yPos: CGFloat = 0.0
                for tag in tickerInfo?.tags ?? [] {
                    let tagView = TagView()
                    tagView.backgroundColor = UIColor(named: "mainText")
                    tagView.tagLabel.textColor = .white
                    tagView.loadImage(url: "")
                    
                    tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                     for: .touchUpInside)
                    tagsStack.addSubview(tagView)
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
            
            let calculatedHeight: CGFloat = 192.0 + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1) + 24.0
            cellHeightChanged?(max((TickerDetailsRecommendedViewCell.cellHeight), calculatedHeight))
        }
    }
    
    @objc func tagViewTouchUpInside(_ tagView: TagView) {
//        guard let name = tagView.tagName, name.count > 0 else {
//            return
//        }
//        let panelInfo = CategoriesTipsGenerator.getInfoForPanel(name)
//        if !panelInfo.title.isEmpty {
//            self.showExplanationWith(title: panelInfo.title, description: panelInfo.description, height: panelInfo.height)
//        }
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
    }
}
