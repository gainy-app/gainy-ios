//
//  TTFConfigurators.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import Foundation
import GainyCommon
import GainyAPI

final class CurrentPositionCellConfigurator: ListCellConfigurationWithCallBacks {
    
    var model: CollectionDetailHistoryCellInfoModel
    var position: (Bool, Bool)
    
    var cellIdentifier: String { CurrentPositionCell.reuseIdentifier }
    
    var didTapCell: (() -> Void)?
    
    var didTapCancel: ((TradingHistoryFrag) -> Void)?
    
    init(model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool) = (false, false)) {
        self.model = model
        self.position = position
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? CurrentPositionCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable)
            cell.cancelOrderHandler = {[weak self] history in
                self?.didTapCancel?(history)
            }
        }
    }
    
    var prepareData: (() -> Void)? = nil 
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
}

final class CurrentPositionTableCellConfigurator: ListCellConfigurationWithCallBacks {
    
    var model: CollectionDetailHistoryCellInfoModel
    var position: (Bool, Bool)
    
    var cellIdentifier: String { CurrentTablePositionCell.cellIdentifier }
    
    var didTapCell: (() -> Void)?
    
    var didTapCancel: ((TradingHistoryFrag) -> Void)?
    
    init(model: CollectionDetailHistoryCellInfoModel, position: (Bool, Bool) = (false, false)) {
        self.model = model
        self.position = position
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? CurrentTablePositionCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable)
            cell.cancelOrderHandler = {[weak self] history in
                self?.didTapCancel?(history)
            }
        }
    }
    
    var prepareData: (() -> Void)? = nil
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
}

final class HistoryTableCellConfigurator: ListCellConfigurationWithCallBacks {
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: [CollectionDetailHistoryCellInfoModel]
    var position: (Bool, Bool)
    var cellIdentifier: String { HistoryTableCell.cellIdentifier }
    var isToggled = false
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    init(model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool) = (false, false)) {
        self.model = model
        self.position = position
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? HistoryTableCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable, isToggled: isToggled)
            cell.cellHeightChanged = cellHeightChanged
        }
    }
}

final class HistoryCellConfigurator: ListCellConfigurationWithCallBacks {
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: [CollectionDetailHistoryCellInfoModel]
    var position: (Bool, Bool)
    var cellIdentifier: String { HistoryCell.reuseIdentifier }
    var isToggled = false
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    init(model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool) = (false, false)) {
        self.model = model
        self.position = position
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? HistoryCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable, isToggled: isToggled)
            cell.cellHeightChanged = cellHeightChanged
        }
    }
}

final class SingleHistoryCellConfigurator: ListCellConfigurationWithCallBacks {
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

final class TTFPositionTableConfigurator: ListCellConfigurationWithCallBacks {
    
    var didTapCell: (() -> Void)?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: CollectionDetailPurchaseInfoModel
    var cellIdentifier: String { PositionTableCell.cellIdentifier }
    
    init(model: CollectionDetailPurchaseInfoModel) {
        self.model = model
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? PositionTableCell {
            cell.configure(with: model)
        }
    }
}

