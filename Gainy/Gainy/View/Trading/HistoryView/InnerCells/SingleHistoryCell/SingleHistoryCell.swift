//
//  SingleHistoryCell.swift
//  Gainy
//
//  Created by Евгений Таран on 14.11.22.
//

import UIKit
import GainyCommon

final class SingleHistoryCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: "SingleHistoryCell", bundle: Bundle.main)
    
    private var model: CollectionDetailHistoryCellInfoModel? {
        didSet {
            configure()
        }
    }
    
    @IBOutlet weak var deltaLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with model: CollectionDetailHistoryCellInfoModel) {
        self.model = model
    }
}

private extension SingleHistoryCell {
    func configure() {
        guard let model else { return }
        
        deltaLabel.text = abs(model.delta).price
        dateLabel.text = AppDateFormatter.shared.convert(model.date, from: .yyyyMMddHHmmssSSSZ, to: .MMMdyyyy)
        stackView.subviews.forEach {
            if $0 is TagLabelView {
                $0.removeFromSuperview()
            }
        }
        for item in 0...2 {
            guard let item = model.tags[safe: item] else { return }
            let view = TagLabelView()
            view.tagText = item
            view.textColor = UIColor(hexString: model.colorForTag(for: item) ?? "")
            stackView.addArrangedSubview(view)
        }
    }
}
