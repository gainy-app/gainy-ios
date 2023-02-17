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
    func notifsTapped(cell: HomeIndexesTableViewCell?)
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
    @IBOutlet weak var homeDynamicView: HomeDynamicView! {
        didSet {
            homeDynamicView.balanceView.tapCallback = { [weak self] in
                self?.delegate?.balanceTapped(cell: self)
            }
        }
    }
    @IBOutlet private weak var growPriceLbl: UILabel!
    
    
    func updateIndexes(models: [HomeIndexViewModel]) {
        guard !models.isEmpty else {return}
        for (ind, val) in models.enumerated() {
            indexViews[ind].indexModel = val
            indexViews[ind].delegate = self
        }
    }
    var gains: PortoGains? {
        didSet {
            if let gains = gains {
                let dailyGrow = (SharedValuesManager.shared.rangeGrowFor(.d1) ?? (gains.relativeGain_1d ?? 0.0))
                let dailyGrowBalance = (SharedValuesManager.shared.rangeGrowBalanceFor(.d1) ?? (gains.absoluteGain_1d ?? 0.0))
                balanceLbl.text = (SharedValuesManager.shared.portfolioBalance() ?? (gains.actualValue ?? 0.0)).price
                
                let isGrowing = dailyGrow > 0.0
                let isEmpty = dailyGrow == 0.0
                growLbl.text = dailyGrow.percentUnsigned
                growPriceLbl.text = dailyGrowBalance.price
                growArrow.image = UIImage(named: isGrowing ? "small_up" : "small_down")
                
                if !isEmpty {
                    growLbl.textColor = UIColor(named: isGrowing ? "mainGreen" : "mainRed")
                    growPriceLbl.textColor = UIColor(named: isGrowing ? "mainGreen" : "mainRed")
                } else {
                    growLbl.textColor = .lightGray
                    growPriceLbl.textColor = .lightGray
                }
            }
        }
    }
}

extension HomeIndexesTableViewCell: HomeIndexViewDelegate {
    func tickerTapped(symbol: String) {
        delegate?.tickerTapped(cell: self, symbol: symbol)
    }
}
