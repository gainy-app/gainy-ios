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
        self.isSkeletonable = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}
