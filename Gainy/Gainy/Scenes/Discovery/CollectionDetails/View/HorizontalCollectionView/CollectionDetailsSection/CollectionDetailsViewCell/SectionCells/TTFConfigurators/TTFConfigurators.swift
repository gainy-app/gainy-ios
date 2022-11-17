//
//  TTFConfigurators.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import Foundation
import GainyCommon

final class CurrentPositionCellConfigurator: ListCellConfigurationWithCallBacks {
    
    var model: CollectionDetailHistoryCellInfoModel
    var position: (Bool, Bool)
    
    var cellIdentifier: String { CurrentPositionCell.cellIdentifier }
    
    var didTapCell: (() -> Void)?
    
    init(model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool) = (false, false)) {
        self.model = model
        self.position = position
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? CurrentPositionCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable)
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
    var position: (Bool, Bool)
    var cellIdentifier: String { HistoryCell.cellIdentifier }
    
    init(model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool) = (false, false)) {
        self.model = model
        self.position = position
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? HistoryCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable)
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

final class TTFPositionConfigurator: ListCellConfigurationWithCallBacks {
    
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: CollectionDetailPurchaseInfoModel
    var cellIdentifier: String { PositionCell.cellIdentifier }
    
    init(model: CollectionDetailPurchaseInfoModel) {
        self.model = model
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? PositionCell {
            cell.configure(with: model)
        }
    }
}
