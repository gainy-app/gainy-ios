//
//  TickerDetailsRecommendedViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsRecommendedViewCell: TickerDetailsViewCell {
       
    @IBOutlet private weak var rotatableImageView: UIImageView!
    
    @IBOutlet private var recLbls: [UILabel]!
    @IBOutlet private weak var scoreLbl: UILabel!
    @IBOutlet private var recImgs: [UIImageView]!
    
    override func updateFromTickerData() {
        let symbol = tickerInfo?.symbol ?? ""
        scoreLbl.text = "\(TickerLiveStorage.shared.getMatchData(symbol)?.matchScore ?? 0)"
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
    }
}
