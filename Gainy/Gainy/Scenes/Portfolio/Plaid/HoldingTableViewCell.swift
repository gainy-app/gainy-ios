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
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    
    @IBOutlet weak var lttView: CornerView!
    
    @IBOutlet weak var shadowView: CornerView! {
        didSet {
            shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            shadowView.layer.shadowOpacity = 1
            shadowView.layer.shadowRadius = 4
            shadowView.layer.shadowOffset = .init(width: 0, height: 2)
            shadowView.layer.shouldRasterize = true
            shadowView.layer.rasterizationScale = UIScreen.main.scale
            var bounds = shadowView.bounds
            bounds.size = CGSize.init(width: UIScreen.main.bounds.width - 16.0 * 2.0, height: bounds.height)
            shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
    
    var holding: GetPlaidHoldingsQuery.Data.GetPortfolioHolding? {
        didSet {
            if let holding = holding {
                print(holding)
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
