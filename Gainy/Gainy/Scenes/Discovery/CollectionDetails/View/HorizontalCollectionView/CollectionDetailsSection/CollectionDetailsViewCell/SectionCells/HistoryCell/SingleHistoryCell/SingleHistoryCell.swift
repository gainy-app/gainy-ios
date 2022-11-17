//
//  SingleHistoryCell.swift
//  Gainy
//
//  Created by Евгений Таран on 14.11.22.
//

import UIKit
import GainyCommon

final class SingleHistoryCell: UICollectionViewCell {
    
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
        
        deltaLabel.text = "\(model.delta)"
        dateLabel.text = model.date
        
        model.tags.forEach { [weak self] tag in
            #warning("Refactor when data available")
            let view = TagLabelView()
            view.tagText = tag
        }
    }
}
