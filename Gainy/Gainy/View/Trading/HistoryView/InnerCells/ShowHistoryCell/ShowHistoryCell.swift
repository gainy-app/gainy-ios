//
//  ShowHistoryCell.swift
//  Gainy
//
//  Created by r10 on 19.01.2023.
//

import UIKit

class ShowHistoryCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: "ShowHistoryCell", bundle: Bundle.main)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 8
    }
}
