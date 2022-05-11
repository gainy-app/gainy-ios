//
//  HomeIndexesTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit

final class HomeIndexesTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 70 + 107.0
    static let smallCellHeight: CGFloat = 70 + 16.0
    
    enum HomeIndex: Int, CaseIterable {
        case dow = 0, spp, nasdaq, bitcoin
    }
    
    @IBOutlet private var indexViews: [HomeIndexView]!
    @IBOutlet private weak var balanceLbl: UILabel!
    @IBOutlet private weak var growLbl: UILabel!
    @IBOutlet private weak var growArrow: UIImageView!
    @IBOutlet weak var bottomDots: UIImageView!
    @IBOutlet private weak var growPriceLbl: UILabel!
    
    func updateIndexes(models: [HomeIndexViewModel]) {        
        for (ind, val) in models.enumerated() {
            indexViews[ind].indexModel = val
        }
    }
    var gains: GetPlaidHoldingsQuery.Data.PortfolioGain? {
        didSet {
            if let gains = gains {
                balanceLbl.text = gains.actualValue?.price ?? ""
                
                let isGrowing = (gains.relativeGain_1d ?? 0.0) > 0.0
                growLbl.text = gains.relativeGain_1d?.percentUnsigned ?? ""
                growPriceLbl.text = gains.absoluteGain_1d?.price ?? ""
                growArrow.image = UIImage(named: isGrowing ? "small_up" : "small_down")
                
                growLbl.textColor = UIColor(named: isGrowing ? "mainGreen" : "mainRed")
                growPriceLbl.textColor = UIColor(named: isGrowing ? "mainGreen" : "mainRed")
            }
        }
    }
}
