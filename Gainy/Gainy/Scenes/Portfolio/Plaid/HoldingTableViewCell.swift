//
//  HoldingTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import UIKit

final class HoldingTableViewCell: UITableViewCell {
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    //MARK: - Outlet
    @IBOutlet weak var shadowView: CornerView! {
        didSet {
            shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowOffset = .init(width: 0, height: 4)
            shadowView.layer.shadowRadius = 24
            shadowView.layer.shouldRasterize = true
            shadowView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowView.layer.shadowPath = UIBezierPath(rect: shadowView.bounds).cgPath
    }
}
