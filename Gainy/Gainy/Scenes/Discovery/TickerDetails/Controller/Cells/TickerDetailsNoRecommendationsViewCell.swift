//
//  TickerDetailsNoRecommendationsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 07.12.2022.
//

import Foundation

final class TickerDetailsNoRecommendationsViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 248.0
    
    var checkInAction: (() -> Void)?
    
    @IBOutlet private weak var rotatableImageView: UIImageView!
    
    func setTransform(_ transform: CGAffineTransform) {
        rotatableImageView.transform = transform
    }
    
    @IBAction func onboardAction(_ sender: Any) {
        checkInAction?()
    }
}
