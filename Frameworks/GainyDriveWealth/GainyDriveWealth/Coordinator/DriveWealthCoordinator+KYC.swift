//
//  DriveWealth+Deposit.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import Foundation

extension DriveWealthCoordinator {
    
    func showKYCMainMenu() {
        let vc = factory.createKYCMainMenuView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
}
