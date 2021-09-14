//
//  TickerDetailsRecommendedViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsRecommendedViewCell: TickerDetailsViewCell {
       
    @IBOutlet private weak var rotatableImageView: UIImageView!
    
    override func updateFromTickerData() {
        
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
    }
}
