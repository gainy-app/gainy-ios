//
//  MainCoordinator+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit

extension MainCoordinator {
    func dwShowDeposit(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.deposit)
        }
    }
    
    func dwShowKyc(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.onboarding)
        }
    }
    
    func dwShowWithdraw(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.withdraw)
        }
    }
    
    func dwShowInvest(collectionId: Int, name: String, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.invest(collectionId: collectionId, name: name))
        }
    }
}
