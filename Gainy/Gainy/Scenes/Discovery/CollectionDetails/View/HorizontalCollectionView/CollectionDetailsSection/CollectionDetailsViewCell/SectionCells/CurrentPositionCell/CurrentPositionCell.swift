//
//  CurrentPositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import UIKit
import GainyCommon
import GainyAPI

class CurrentPositionCell: UICollectionViewCell {
    
    private var currentPositionView: CurrentPositionView = CurrentPositionView().loadViewt() as! CurrentPositionView
    
    var cancelOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    private var innerModel: CollectionDetailHistoryCellInfoModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(currentPositionView)
        NSLayoutConstraint.activate([
            currentPositionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentPositionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            currentPositionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            currentPositionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
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
