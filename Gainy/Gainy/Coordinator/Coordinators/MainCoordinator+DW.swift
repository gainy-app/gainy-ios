//
//  MainCoordinator+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import GainyCommon

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
                                handleKYCStatus(.approved, from: vc)
                            }
                        } else {
                            if kycStatus.status == .notReady {
                                dwShowKyc(from: vc)
                            } else {
                                handleKYCStatus(kycStatus.status, from: vc)
                            }
                        }
                    }
                } else {
                    await MainActor.run {
                        dwShowKyc(from: vc)
                    }
                }
            }
    }
    
    private func handleKYCStatus(_ status: KYCStatus, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
                switch status {
                case .notReady:
                    dwCoordinator.start(.kycStatus(mode: .kycPending))
                    break
                case .ready:
                    dwCoordinator.start(.kycStatus(mode: .kycApproved))
                    break
                case .processing:
                    dwCoordinator.start(.kycStatus(mode: .kycPending))
                    break
                case .approved:
                    dwCoordinator.start(.kycStatus(mode: .kycApproved))
                    break
                case .infoRequired:
                    dwCoordinator.start(.kycStatus(mode: .kycInfo))
                    break
                case .docRequired:
                    dwCoordinator.start(.kycStatus(mode: .kycDocs))
                    break
                case .manualReview:
                    dwCoordinator.start(.kycStatus(mode: .kycRejected))
                    break
                case .denied:
                    dwCoordinator.start(.kycStatus(mode: .kycRejected))
                    break
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
    
    func dwShowHistory(from vc: UIViewController? = nil, collectionId: Int, name: String, amount: Double) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.history(collectionId: collectionId, name: name, amount: amount))
        }
    }
    
    func dwShowAllHistory(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.historyAll)
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
    
    func showSelectAccountView(isNeedToDelete: Bool, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.selectAccount(isNeedToDelete: isNeedToDelete))
        }
    }
    
    func showAddFundingAccount(profileId: Int, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.addFundingAccount(profileId: profileId))
        }
    }
}
