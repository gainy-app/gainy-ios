//
//  CurrentPositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import UIKit

class CurrentPositionCell: UICollectionViewCell {
    
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var separator: UIImageView!
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        
    }
    
    func configure(with model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool), isSkeletonable: Bool) {
        amountLabel.text = "$ \(model.delta)"
        dateLabel.text = model.date
        if isSkeletonable {
            showAnimatedGradientSkeleton()
        } else {
            hideSkeleton()
        }
        switch position {
        case (true, true):
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (true, false):
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            separator.isHidden = false
        case (false, true):
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            break
        }
    }
}
