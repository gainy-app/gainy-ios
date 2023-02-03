//
//  DriveWealth+Deposit.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import Foundation

extension DriveWealthCoordinator {
    func showDepositOverview(amount: Double) {
        let vc = factory.createDepositInputOverviewView(coordinator: self)
        vc.amount = amount
        navController.pushViewController(vc, animated: true)
    }
    
    
    func showDepositDone(amount: Double, tradingFlowId: Int) {
        let vc = factory.createDepositInputDoneView(coordinator: self)
        vc.amount = amount
        vc.mode = .deposit
        vc.tradingFlowId = tradingFlowId
        navController.pushViewController(vc, animated: true)
    }
    
    func showWithdrawOverview(amount: Double) {
        let vc = factory.createDepositInputOverviewView(coordinator: self)
        vc.amount = amount
        vc.mode = .withdraw
        navController.pushViewController(vc, animated: true)
    }
    
    func showWithdrawDone(amount: Double, tradingFlowId: Int) {
        let vc = factory.createDepositInputDoneView(coordinator: self)
        vc.amount = amount
        vc.mode = .withdraw
        vc.tradingFlowId = tradingFlowId
        navController.pushViewController(vc, animated: true)
    }
    
    func showOrderOverview(amount: Double, collectionId: Int, name: String, mode: DWOrderInputMode, type: DWOrderProductMode, sellAll: Bool = false) {
        let vc = factory.createInvestOrderView(coordinator: self, collectionId: collectionId, name: name, sellAll: sellAll)
        vc.amount = amount
        vc.collectionId = collectionId
        vc.name = name
        vc.mode = mode
        vc.type = type
        navController.pushViewController(vc, animated: true)
    }
    
    func showStockOrderOverview(amount: Double, symbol: String, name: String, mode: DWOrderInputMode, type: DWOrderProductMode, sellAll: Bool = false) {
        let vc = factory.createStockInvestOrderView(coordinator: self, symbol: symbol, name: name, productType: .stock, sellAll: sellAll)
        vc.amount = amount
        vc.name = name
        vc.mode = mode
        vc.type = type
        navController.pushViewController(vc, animated: true)
    }
    
    func showOrderSpaceDone(amount: Double, collectionId: Int, name: String, mode: DWOrderInvestSpaceStatus = .order, type: DWOrderProductMode) {
        let vc = factory.createInvestOrderSpaceView(coordinator: self, collectionId: collectionId, name: name)
        vc.amount = amount
        vc.collectionId = collectionId
        vc.name = name
        vc.mode = mode
        vc.type = type
        navController.pushViewController(vc, animated: true)
    }
    
    func showStockOrderSpaceDone(amount: Double, symbol: String, name: String, mode: DWOrderInvestSpaceStatus = .order, type: DWOrderProductMode) {
        let vc = factory.createStockInvestOrderSpaceView(coordinator: self, symbol: symbol, name: name, productType: .stock)
        vc.amount = amount
        vc.name = name
        vc.mode = mode
        vc.type = type
        navController.pushViewController(vc, animated: true)
    }
    
    func showOrderDetails(amount: Double, name: String, mode: DWOrderDetailsViewController.Mode = .original) {
        let vc = factory.createInvestOrderDetailsView(coordinator: self, name: name)
        vc.amount = amount
        vc.name = name
        vc.mode = mode
        navController.pushViewController(vc, animated: true)
    }
    
    /// Show Order History Details
    /// - Parameters:
    ///   - amount: amount
    ///   - collectionId: TTF ID
    ///   - name: name
    ///   - mode: data for mode
    func showHistoryOrderDetails(amount: Double, name: String, mode: DWHistoryOrderMode) {
        let vc = factory.createHistoryOrderDetailsView(coordinator: self, name: name)
        vc.amount = amount
        vc.name = name
        vc.mode = mode
        navController.pushViewController(vc, animated: true)
    }
    
}
