//
//  TTFConfigurators.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import Foundation
import GainyCommon

final class CurrentPositionCellConfigurator: ListCellConfigurationWithCallBacks {
    
    var model: CollectionDetailHistoryCellInfoModel?
    var position: (isFirst: Bool, isLast: Bool) = (false, false)
    
    var cellIdentifier: String { CurrentPositionCell.cellIdentifier }
    
    var didTapCell: (() -> Void)?
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? CurrentPositionCell,
           let model = model {
            cell.configureCell(with: model, position: position, isSkeletonable: isSkeletonable)
        }
    }
    
    var prepareData: (() -> Void)? = nil 
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
}

final class HistoryCellConfigurator: ListCellConfigurationWithCallBacks {
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: [CollectionDetailHistoryCellInfoModel]
    var cellIdentifier: String { HistoryCell.cellIdentifier }
    
    init(model: [CollectionDetailHistoryCellInfoModel]) {
        self.model = model
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? HistoryCell {
            cell.configure(with: model)
        }
    }
}

final class SingleHistoryCellConfigurator: ListCellConfigurationWithCallBacks {
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: CollectionDetailHistoryCellInfoModel
    var cellIdentifier: String { SingleHistoryCell.cellIdentifier }
    
    init(model: CollectionDetailHistoryCellInfoModel) {
        self.model = model
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? SingleHistoryCell {
            cell.configure(with: model)
        }
    }
}
