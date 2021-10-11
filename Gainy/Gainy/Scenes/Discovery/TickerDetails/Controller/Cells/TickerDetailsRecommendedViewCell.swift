//
//  TickerDetailsRecommendedViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsRecommendedViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 156.0
    
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
        }
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
    }
}
