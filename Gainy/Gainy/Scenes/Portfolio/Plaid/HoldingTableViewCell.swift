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
            shadowView.layer.shadowOffset = .zero
            shadowView.layer.shouldRasterize = true
            shadowView.layer.rasterizationScale = UIScreen.main.scale
//            var bounds = shadowView.bounds
//            bounds.size = CGSize.init(width: UIScreen.main.bounds.width - 16.0 * 2.0, height: bounds.height)
//            shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
    @IBOutlet weak var securitiesTableView: UITableView! {
        didSet {
            securitiesTableView.dataSource = self
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

extension HoldingTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HoldingSecurityTableViewCell = tableView.dequeueReusableCell(withIdentifier: HoldingSecurityTableViewCell.cellIdentifier, for: indexPath) as! HoldingSecurityTableViewCell
        return cell
    }
}
