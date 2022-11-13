//
//  MainCoordinator+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit

extension MainCoordinator {
    
    func showDWFlow(collectionId: Int, name: String, from vc: UIViewController? = nil) {
        Task {
            async let kycStatusAw = await UserProfileManager.shared.getProfileStatus()            
                if let kycStatus = await kycStatusAw {
                    await MainActor.run {
                        if kycStatus.kycDone ?? false {
                            if kycStatus.depositedFunds ?? false {
                                dwShowInvest(collectionId: collectionId, name: name, from: vc)
                            } else {
                                dwShowDeposit(from: vc)
                            }
                        } else {
                            dwShowKyc(from: vc)
                        }
                    }
                } else {
                    await MainActor.run {
                        dwShowKyc(from: vc)
                    }
                }
            }
    }
    
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
            dwCoordinator.start(.withdraw)
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
    
    func dwShowBuyToTTF(collectionId: Int, name: String, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.buy(collectionId: collectionId, name: name))
        }
    }
    
    func dwShowSellToTTF(collectionId: Int, name: String, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.sell(collectionId: collectionId, name: name))
        }
    }
}
