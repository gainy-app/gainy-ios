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
    @IBOutlet private weak var separator: UIView!
    @IBOutlet weak var tagView: TagLabelView!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewTrailingConstraint: NSLayoutConstraint!
    
    var cancelOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separator.layer.cornerRadius = 1
    }
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        if let innerModel, innerModel.isCancellable {
            cancelOrderHandler?(innerModel.historyData)
        }
    }
    
    func configure(with model: CollectionDetailHistoryCellInfoModel, isSkeletonable: Bool, position: (Bool, Bool)) {
        innerModel = model
        
        cancelBtn.isHidden = !model.isCancellable
        amountLabel.text = abs(model.delta).price
        
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
        
        if !model.isCancellable {
            stackViewTrailingConstraint.isActive = false
            stackViewTrailingConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
            stackViewTrailingConstraint.isActive = true
        }
        
        switch position {
        case (true, false):
            separator.isHidden = false
        default:
            break
        }
    }
}
