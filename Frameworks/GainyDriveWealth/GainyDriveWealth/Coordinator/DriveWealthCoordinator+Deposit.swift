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
    
    
    func showDepositDone(amount: Double) {
        let vc = factory.createDepositInputDoneView(coordinator: self)
        vc.amount = amount
        navController.pushViewController(vc, animated: true)
    }
    
    func showWithdrawOverview(amount: Double) {
        let vc = factory.createDepositInputOverviewView(coordinator: self)
        vc.amount = amount
        vc.mode = .withdraw
        navController.pushViewController(vc, animated: true)
    }
    
    func showWithdrawDone(amount: Double) {
        let vc = factory.createDepositInputDoneView(coordinator: self)
        vc.amount = amount
        vc.mode = .withdraw
        navController.pushViewController(vc, animated: true)
    }
    
    func showOrderOverview(amount: Double, collectionId: Int, name: String) {
        let vc = factory.createInvestOrderView(coordinator: self, collectionId: collectionId, name: name)
        vc.amount = amount
        vc.collectionId = collectionId
        vc.name = name
        navController.pushViewController(vc, animated: true)
    }
    
    func showOrderSpaceDone(amount: Double, collectionId: Int, name: String) {
        let vc = factory.createInvestOrderSpaceView(coordinator: self, collectionId: collectionId, name: name)
        vc.amount = amount
        vc.collectionId = collectionId
        vc.name = name
        navController.pushViewController(vc, animated: true)
    }
    
    func showOrderDetails(amount: Double, collectionId: Int, name: String) {
        let vc = factory.createInvestOrderDetailsView(coordinator: self, collectionId: collectionId, name: name)
        vc.amount = amount
        vc.collectionId = collectionId
        vc.name = name
        navController.pushViewController(vc, animated: true)
    }
}