//
//  HistoryConfigurators.swift
//  Gainy
//
//  Created by r10 on 19.01.2023.
//

import UIKit
import GainyCommon

enum HistorySectionTypes {
    case history
    case showMore
}

protocol HistoryInnerCellConfigurators: ListCellConfigurationWithCallBacks {
    var sectionType: HistorySectionTypes { get }
}

final class SingleHistoryShowMoreCellConfigurator: HistoryInnerCellConfigurators {
    
    var sectionType: HistorySectionTypes {
        .showMore
    }
    
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var cellIdentifier: String { ShowHistoryCell.reuseIdentifier }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? ShowHistoryCell {
            cell.isSkeletonable = isSkeletonable
        }
    }
}

final class SingleHistoryCellConfigurator: HistoryInnerCellConfigurators {
    
    var sectionType: HistorySectionTypes {
        .history
    }
    
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: CollectionDetailHistoryCellInfoModel
    var cellIdentifier: String { SingleHistoryCell.reuseIdentifier }
    
    init(model: CollectionDetailHistoryCellInfoModel) {
        self.model = model
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? SingleHistoryCell {
            cell.configure(with: model)
        }
    }
}
