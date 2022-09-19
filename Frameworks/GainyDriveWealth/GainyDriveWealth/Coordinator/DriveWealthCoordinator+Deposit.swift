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
}
