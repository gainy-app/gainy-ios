//
//  MainCoordinator+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit

extension MainCoordinator {
    func dwShowDeposit() {
        if let dwCoordinator = dwCoordinator {
            mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            dwCoordinator.start(.deposit)
        }
    }
}
