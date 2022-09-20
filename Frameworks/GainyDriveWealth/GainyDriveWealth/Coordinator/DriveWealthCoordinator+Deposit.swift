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
}
