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
            cell.cancelOrderHandler = { [weak self] history in
                self?.didTapCancel?(history)
            }
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable)
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
            cell.cancelOrderHandler = { [weak self] history in
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
    var didTapShowMore: VoidHandler?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: [CollectionDetailHistoryCellInfoModel]
    var position: (Bool, Bool)
    var cellIdentifier: String { HistoryTableCell.cellIdentifier }
    var isToggled = false
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    init(model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool) = (false, false), isToggled: Bool = false) {
        self.model = model
        self.position = position
        self.isToggled = isToggled
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
    var didTapShowMore: VoidHandler?
    
    var prepareData: (() -> Void)?
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
    
    var model: [CollectionDetailHistoryCellInfoModel]
    var position: (Bool, Bool) = (false, false)
    var cellIdentifier: String { HistoryCell.reuseIdentifier }
    var isToggled = false
    
    var tapOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    init(model: [CollectionDetailHistoryCellInfoModel], isToggled: Bool = false) {
        self.model = model
        self.isToggled = isToggled
    }
    
    func setupCell(_ cell: UIView, isSkeletonable: Bool) {
        if let cell = cell as? HistoryCell {
            cell.configure(with: model, position: position, isSkeletonable: isSkeletonable, isToggled: isToggled)
            cell.cellHeightChanged = cellHeightChanged
            cell.tapOrderHandler = {[weak self] history in
                self?.tapOrderHandler?(history)
            }
            cell.showMoreHandler = {[weak self] in
                self?.didTapShowMore?()
            }
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
