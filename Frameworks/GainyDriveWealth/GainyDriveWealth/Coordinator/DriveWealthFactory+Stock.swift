//
//  DriveWealthFactory+Stock.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 18.12.2022.
//

import Foundation

extension DriveWealthFactory {
    
    func createStockInvestInputView(coordinator: DriveWealthCoordinator, symbol: String, name: String, tickerType: String, mode: DWOrderInputMode = .invest, available: Double = 0.0) -> DWOrderInputViewController {
        let vc = DWOrderInputViewController.instantiate(.deposit)
        vc.mode = mode
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.symbol = symbol
        vc.name = name
        vc.availableAmount = available
        vc.type = tickerType == "etf" ? .etf : .stock
        return vc
    }
    
    func createStockInvestOrderView(coordinator: DriveWealthCoordinator, symbol: String, name: String, productType: DWOrderProductMode,  mode: DWOrderInputMode = .invest, sellAll: Bool = false) -> DWOrderOverviewController {
        let vc = DWOrderOverviewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.symbol = symbol
        vc.name = name
        vc.type = productType
        vc.sellAll = sellAll
        return vc
    }
    
    func createStockInvestOrderSpaceView(coordinator: DriveWealthCoordinator, symbol: String, name: String, productType: DWOrderProductMode, mode: DWOrderInvestSpaceStatus = .order) -> DWOrderInvestSpaceViewController {
        let vc = DWOrderInvestSpaceViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.symbol = symbol
        vc.name = name
        vc.mode = mode
        vc.type = productType
        return vc
    }
    
    func createStockInvestOrderDetailsView(coordinator: DriveWealthCoordinator, name: String, productType: DWOrderProductMode) -> DWOrderDetailsViewController {
        let vc = DWOrderDetailsViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.name = name
        vc.type = productType
        return vc
    }

}
