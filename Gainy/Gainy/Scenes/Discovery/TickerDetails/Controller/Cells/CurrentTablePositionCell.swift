//
//  CurrentTablePositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 23.12.22.
//

import UIKit
import GainyCommon
import GainyAPI

final class CurrentTablePositionCell: UITableViewCell {
    
    private var currentPositionView: CurrentPositionView = CurrentPositionView().loadViewt() as! CurrentPositionView
    
    static let initialHeight: CGFloat = CGFloat(56 + 24)
    
    var cancelOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    private var innerModel: CollectionDetailHistoryCellInfoModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(currentPositionView)
        NSLayoutConstraint.activate([
            currentPositionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentPositionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            currentPositionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            currentPositionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool), isSkeletonable: Bool) {
        currentPositionView.configure(with: model, isSkeletonable: isSkeletonable, position: position)
        currentPositionView.cancelOrderHandler = cancelOrderHandler
        currentPositionView.layer.cornerRadius = 16
        switch position {
        case (true, true):
            currentPositionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (true, false):
            currentPositionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (false, true):
            currentPositionView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            currentPositionView.layer.cornerRadius = 0
            break
        }
    }
}

