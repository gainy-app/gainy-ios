//
//  HomeIndexesTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import GainyAPI

protocol HomeIndexesTableViewCellDelegate: AnyObject {
    func tickerTapped(cell: HomeIndexesTableViewCell?, symbol: String)
    func balanceTapped(cell: HomeIndexesTableViewCell?)
}

final class HomeIndexesTableViewCell: UITableViewCell {
    static let cellHeight: CGFloat = 70 + 107.0 + 24.0 + 18.0
    static let smallCellHeight: CGFloat = 70 + 16.0 + 4.0 + 8.0
    
    enum HomeIndex: Int, CaseIterable {
        case dow = 0, spp, nasdaq, bitcoin
    }
    
    weak var delegate: HomeIndexesTableViewCellDelegate?
    
    @IBOutlet private var indexViews: [HomeIndexView]!
    @IBOutlet private weak var balanceLbl: UILabel!
    @IBOutlet private weak var growLbl: UILabel!
    @IBOutlet private weak var growArrow: UIImageView!
    @IBOutlet private weak var bottomDots: UIImageView!
    @IBOutlet private weak var growPriceLbl: UILabel!
    
    @IBOutlet weak var balanceView: HomeShadowView! {
        didSet {
            balanceView.tapCallback = { [weak self] in
                self?.delegate?.balanceTapped(cell: self)
            }
        }
    }
    func updateIndexes(models: [HomeIndexViewModel]) {
        for (ind, val) in models.enumerated() {
            indexViews[ind].indexModel = val
            indexViews[ind].delegate = self
        }
    }
    var gains: GetPlaidProfileGainsQuery.Data.PortfolioGain? {
        didSet {
            if let gains = gains {
                balanceLbl.text = SharedValuesManager.shared.portfolioBalance.price
                
                let isGrowing = (gains.relativeGain_1d ?? 0.0) > 0.0
                let isEmpty = (gains.relativeGain_1d ?? 0.0) == 0.0
                growLbl.text = gains.relativeGain_1d?.percentUnsigned ?? ""
                growPriceLbl.text = gains.absoluteGain_1d?.price ?? ""
                growArrow.image = UIImage(named: isGrowing ? "small_up" : "small_down")
                
                if !isEmpty {
                    growLbl.textColor = UIColor(named: isGrowing ? "mainGreen" : "mainRed")
                    growPriceLbl.textColor = UIColor(named: isGrowing ? "mainGreen" : "mainRed")
                } else {
                    growLbl.textColor = .lightGray
                    growPriceLbl.textColor = .lightGray
                }
                bottomDots.isHidden = true
            } else {
                bottomDots.isHidden = true
            }
        }
    }
}

extension HomeIndexesTableViewCell: HomeIndexViewDelegate {
    func tickerTapped(symbol: String) {
        delegate?.tickerTapped(cell: self, symbol: symbol)
    }
}
