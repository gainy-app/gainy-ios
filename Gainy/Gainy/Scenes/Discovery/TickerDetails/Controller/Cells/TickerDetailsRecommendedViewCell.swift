//
//  TickerDetailsRecommendedViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsRecommendedViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 168.0
    
    @IBOutlet private weak var rotatableImageView: UIImageView!
    
    @IBOutlet private var recLbls: [UILabel]!
    @IBOutlet private weak var scoreLbl: UILabel!
    @IBOutlet private var recImgs: [UIImageView]!
    
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
        }
        cellHeightChanged?(168.0)
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
    }
}
