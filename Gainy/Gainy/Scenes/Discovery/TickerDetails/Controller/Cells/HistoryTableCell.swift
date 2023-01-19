//
//  HistoryTableCell.swift
//  Gainy
//
//  Created by Евгений Таран on 23.12.22.
//

import UIKit
import GainyCommon
import GainyAPI

class HistoryTableCell: UITableViewCell {
    
    var cellHeightChanged: ((CGFloat) -> Void)? {
        didSet {
            historyView.cellHeightChanged = cellHeightChanged
        }
    }
    
    var didTapShowMore: VoidHandler? {
        didSet {
            historyView.didTapShowMore = didTapShowMore
        }
    }
    
    var tapOrderHandler: ((TradingHistoryFrag) -> Void)? {
        didSet {
            historyView.tapOrderHandler = tapOrderHandler
        }
    }
    
    private var historyView = HistoryView().loadViewt() as! HistoryView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(historyView)
        NSLayoutConstraint.activate([
            historyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            historyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            historyView.topAnchor.constraint(equalTo: contentView.topAnchor),
            historyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool), isSkeletonable: Bool, isToggled: Bool = false) {
        historyView.configure(with: model, isSkeletonable: isSkeletonable, isToggled: isToggled)
        historyView.cellHeightChanged = cellHeightChanged
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

