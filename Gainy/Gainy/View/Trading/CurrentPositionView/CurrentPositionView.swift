//
//  CurrentPositionView.swift
//  Gainy
//
//  Created by Евгений Таран on 19.12.22.
//

import UIKit
import GainyCommon
import GainyAPI

@IBDesignable
class CurrentPositionView: UIView {
    
    private var innerModel: CollectionDetailHistoryCellInfoModel?
    
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var separator: UIImageView!
    @IBOutlet weak var tagView: TagLabelView!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var cancelOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        if let innerModel, innerModel.isCancellable {
            cancelOrderHandler?(innerModel.historyData)
        }
    }
    
    func configure(with model: CollectionDetailHistoryCellInfoModel, isSkeletonable: Bool, position: (Bool, Bool)) {
        innerModel = model
        
        cancelBtn.isHidden = !model.isCancellable
        amountLabel.text = model.delta.price
        
        configureDateLabel(with: model.date)
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
        
        switch position {
        case (true, false):
            separator.isHidden = false
        default:
            break
        }
    }
}

private extension CurrentPositionView {
    func configureDateLabel(with stringDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: stringDate) else { return }
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
}
