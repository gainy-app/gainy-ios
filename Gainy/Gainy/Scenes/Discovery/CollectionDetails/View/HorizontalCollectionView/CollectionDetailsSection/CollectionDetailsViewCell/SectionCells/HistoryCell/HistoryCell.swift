//
//  HistoryCell.swift
//  Gainy
//
//  Created by Евгений Таран on 13.11.22.
//

import UIKit
import GainyCommon
import GainyAPI

class HistoryCell: UICollectionViewCell {
    
    var cellHeightChanged: ((CGFloat) -> Void)? {
        didSet {
            historyView.cellHeightChanged = cellHeightChanged
        }
    }
    
    private var historyView = HistoryView().loadViewt() as! HistoryView
    
    var tapOrderHandler: ((TradingHistoryFrag) -> Void)? {
        didSet {
            historyView.tapOrderHandler = tapOrderHandler
        }
    }
    
    var didTapShowMore: (([TradingHistoryFrag]) -> Void)? {
        didSet {
            historyView.didTapShowMore = didTapShowMore
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(historyView)
        
        NSLayoutConstraint.activate([
            historyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            historyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            historyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            historyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool), isSkeletonable: Bool, isToggled: Bool = false) {
        historyView.configure(with: model, isSkeletonable: isSkeletonable, isToggled: isToggled)
        historyView.cellHeightChanged = cellHeightChanged
        historyView.tapOrderHandler = tapOrderHandler
        historyView.didTapShowMore = didTapShowMore
        historyView.layer.cornerRadius = 16
        switch position {
        case (true, true):
            historyView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (true, false):
            historyView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (false, true):
            historyView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            historyView.layer.cornerRadius = 0
        }
    }
}
