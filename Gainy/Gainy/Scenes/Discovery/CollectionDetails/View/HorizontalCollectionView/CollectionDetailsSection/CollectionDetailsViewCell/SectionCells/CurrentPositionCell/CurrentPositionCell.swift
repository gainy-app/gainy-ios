//
//  CurrentPositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import UIKit
import GainyCommon

class CurrentPositionCell: UICollectionViewCell {
    
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var separator: UIImageView!
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet weak var tagView: TagLabelView!
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        
    }
    
    func configure(with model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool), isSkeletonable: Bool) {
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

private extension CurrentPositionCell {
    func configureDateLabel(with stringDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: stringDate) else { return }
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateLabel.text = dateFormatter.string(from: date)
    }
}
