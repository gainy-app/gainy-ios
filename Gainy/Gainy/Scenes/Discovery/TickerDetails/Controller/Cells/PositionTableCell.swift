//
//  PositionTableCell.swift
//  Gainy
//
//  Created by Евгений Таран on 23.12.22.
//

import UIKit
import GainyCommon

final class PositionTableCell: UITableViewCell {
    
    private var positionView: PositionView = PositionView().loadViewt() as! PositionView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(positionView)
        NSLayoutConstraint.activate([
            positionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            positionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            positionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            positionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: CollectionDetailPurchaseInfoModel) {
        positionView.configure(with: model)
    }
}
