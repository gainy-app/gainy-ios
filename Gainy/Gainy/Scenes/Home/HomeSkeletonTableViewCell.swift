//
//  HomeSkeletonTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 22.02.2022.
//

import UIKit
import SkeletonView

final class HomeSkeletonTableViewCell: UITableViewCell {
    
    static let cellHeight: CGFloat = 677.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSkeletonable = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
}

