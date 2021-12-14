//
//  HoldingsSkeletonTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.11.2021.
//

import UIKit
import SkeletonView

final class HoldingsSkeletonTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.subviews.forEach({
            $0.isSkeletonable = true
            $0.skeletonCornerRadius = 6
        })
    }
}
