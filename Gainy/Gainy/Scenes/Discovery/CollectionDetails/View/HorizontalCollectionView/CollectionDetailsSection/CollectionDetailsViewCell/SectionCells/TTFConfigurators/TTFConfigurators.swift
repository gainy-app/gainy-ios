//
//  TTFConfigurators.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import Foundation
import GainyCommon

struct CurrentPositionCellModel {
    
}

final class CurrentPositionCellConfigurator: ListCellConfigurationWithCallBacks {
    
    var model: CurrentPositionCellModel?
    
    static var cellIdentifier: String = CurrentPositionCell.cellIdentifier
    
    var didTapCell: (() -> Void)?
    
    func setupCell(_ cell: UIView) {
        if let cell = cell as? CurrentPositionCell,
           let model = model {
            cell.configureCell(with: model)
        }
    }
    
    var prepareData: (() -> Void)? = nil 
    
    var cancelPreparingData: (() -> Void)?
    
    var getCellSize: ((CGSize?) -> CGSize)?
}
