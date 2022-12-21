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
    
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var separator: UIImageView!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet weak var tagView: TagLabelView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var cancelOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        if let innerModel, innerModel.isCancellable {
            cancelOrderHandler?(innerModel.historyData)
        }
    }
    
    private var innerModel: CollectionDetailHistoryCellInfoModel?
    func configure(with model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool), isSkeletonable: Bool) {
        innerModel = model
        
        cancelBtn.isHidden = !model.isCancellable
        
        if model.tags.contains(TradeTags.TypeKey.deposit.rawValue.uppercased()) || model.tags.contains(TradeTags.TypeKey.sell.rawValue.uppercased()) {
            amountLabel.text = "+" + abs(model.delta).price
        } else if model.tags.contains(TradeTags.TypeKey.buy.rawValue.uppercased()) {
            amountLabel.text = "-" + abs(model.delta).price
        } else {
            amountLabel.text = abs(model.delta).price
        }
        
        dateLabel.text = AppDateFormatter.shared.convert(model.date, from: .yyyyMMddHHmmssSSSZ, to: .MMMdyyyy)
        if isSkeletonable {
            showAnimatedGradientSkeleton()
        } else {
            hideSkeleton()
        }
        if let tag = model.tags.first(where: { $0 == "pending".uppercased() }) {
            tagView.tagText = tag
            if let color = model.colorForTag(for: tag) {
                tagView.textColor = UIColor(hexString: color)
            }
        }
        cellView.layer.cornerRadius = 16
        switch position {
        case (true, true):
            cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (true, false):
            cellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            separator.isHidden = false
        case (false, true):
            cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            cellView.layer.cornerRadius = 0
            break
        }
    }
}
