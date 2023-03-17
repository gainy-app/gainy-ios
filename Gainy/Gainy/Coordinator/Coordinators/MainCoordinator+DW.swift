//
//  MainCoordinator+DW.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import UIKit
import GainyCommon
import GainyDriveWealth

extension MainCoordinator {
    
    func showDWFlowTTF(collectionId: Int, name: String, from vc: UIViewController? = nil) {
        if UserProfileManager.shared.userRegion == .us {
            
            //FOR US ONLY
            guard UserProfileManager.shared.isTradingActive else {
                showOldNotify(collectionId: collectionId, from: vc)
                return
            }
            
            Task {
                async let kycStatusAw = await UserProfileManager.shared.getProfileStatus()
                if let kycStatus = await kycStatusAw {
                    await MainActor.run {
                        if kycStatus.kycDone ?? false {
                            if kycStatus.depositedFunds ?? false {
                                dwShowInvestTTF(collectionId: collectionId, name: name, from: vc)
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
        } else {
            showOldNotify(collectionId: collectionId, from: vc)
        }
    }
    
    private func showOldNotify(collectionId: Int, from vc: UIViewController? = nil) {
        let notifyViewController = NotifyViewController.instantiate(.popups)
        let navController = UINavigationController.init(rootViewController: notifyViewController)
        navController.modalPresentationStyle = .fullScreen
        notifyViewController.sourceId = "\(collectionId)"
        GainyAnalytics.logEvent("invest_pressed_ttf", params: ["collection_dd": collectionId])
        vc?.present(navController, animated: true)
    }
    
    private func showOldNotify(symbol: String, from vc: UIViewController? = nil) {
        let notifyViewController = NotifyViewController.instantiate(.popups)
        let navController = UINavigationController.init(rootViewController: notifyViewController)
        navController.modalPresentationStyle = .fullScreen
        notifyViewController.sourceId = "\(symbol)"
        notifyViewController.isFromTTF = false
        if !symbol.isEmpty {
            GainyAnalytics.logEvent("invest_pressed_stock", params: ["stock_dd": symbol])
        }
        vc?.present(navController, animated: true)
    }
    
    func handleKYCStatus(_ status: KYCStatus, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
                switch status {
                case .notReady:
                    dwCoordinator.start(.kycStatus(mode: .kycPending))
                    break
                case .ready:
                    dwCoordinator.start(.kycStatus(mode: .kycPending))
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
                    dwCoordinator.start(.kycStatus(mode: .kycPending))
                    break
                case .denied:
                    dwCoordinator.start(.kycStatus(mode: .kycRejected))
                    break
                }
            }
        }
    }
    
    func showDWFlowStock(symbol: String, name: String, from vc: UIViewController? = nil) {
        if UserProfileManager.shared.userRegion == .us {
            
            //FOR US ONLY
            guard UserProfileManager.shared.isTradingActive else {
                showOldNotify(symbol: symbol, from: vc)
                return
            }
            
            Task {
                async let kycStatusAw = await UserProfileManager.shared.getProfileStatus()
                if let kycStatus = await kycStatusAw {
                    await MainActor.run {
                        if kycStatus.kycDone ?? false {
                            if kycStatus.depositedFunds ?? false {
                                dwShowInvestStock(symbol: symbol, name: name, from: vc)
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
        } else {
            showOldNotify(symbol: symbol, from: vc)
        }
    }
    
    func showDWFlowPorto(from vc: UIViewController? = nil) {
        if UserProfileManager.shared.userRegion == .us {
            
            //FOR US ONLY
            guard UserProfileManager.shared.isTradingActive else {
                showOldNotify(symbol: "", from: vc)
                return
            }
            
            Task {
                async let kycStatusAw = await UserProfileManager.shared.getProfileStatus()
                if let kycStatus = await kycStatusAw {
                    await MainActor.run {
                        if kycStatus.kycDone ?? false {
                            if kycStatus.depositedFunds ?? false {
                                NotificationCenter.default.post(name: NotificationManager.requestOpenHomeNotification, object: nil)

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
        } else {
            showOldNotify(symbol: "", from: vc)
        }
    }
    
    func dwShowDeposit(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator, dwCoordinator.navController.presentingViewController == nil  {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.deposit)
        }
    }
    
    func dwShowHistory(from vc: UIViewController? = nil, collectionId: Int, name: String, amount: Double) {
        if let dwCoordinator = dwCoordinator, dwCoordinator.navController.presentingViewController == nil  {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.history(collectionId: collectionId, name: name, amount: amount))
        }
    }
    
    func dwShowExactHistory(from vc: UIViewController? = nil, mode: DWHistoryOrderMode, name: String, amount: Double) {
        if let dwCoordinator = dwCoordinator, dwCoordinator.navController.presentingViewController == nil  {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.detailedHistory(name: name, amount: amount, mode: mode))
        }
    }
    
    func dwShowAllHistory(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator, dwCoordinator.navController.presentingViewController == nil {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.historyAll)
        }
    }
    
    func dwShowKYCStatus(status: KYCStatus, from vc: UIViewController? = nil) {
        handleKYCStatus(status, from: vc)
    }
    
    /// Show all history for TTF/Stock
    /// - Parameters:
    ///   - history: history items
    ///   - vc: presenting controller
    func dwShowAllHistoryForItem(history: [GainyTradingHistory], from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator, dwCoordinator.navController.presentingViewController == nil  {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.historySpecific(history: history))
        }
    }
    
    func dwShowKyc(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.onboarding)
        }
    }
    
    func dwShowWithdraw(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.withdraw)
        }
    }
    
    func dwShowInvestTTF(collectionId: Int, name: String, from vc: UIViewController? = nil) {        
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                if let presentedViewController = mainTabBarViewController?.presentedViewController {
                    presentedViewController.present(dwCoordinator.navController, animated: true)
                } else {
                    mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
                }
            }
            dwCoordinator.start(.investTTF(collectionId: collectionId, name: name))
        }
    }
    
    func dwShowBuyToTTF(collectionId: Int, name: String, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.buyTTF(collectionId: collectionId, name: name))
        }
    }
    
    func dwShowSellToTTF(collectionId: Int, name: String, available amount: Double, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.sellTTF(collectionId: collectionId, name: name, available: amount))
        }
    }
    
    
    func dwShowInvestStock(symbol: String, name: String, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.investStock(symbol: symbol, name: name))
        }
    }
    
    func dwShowBuyToStock(symbol: String, name: String, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.buyStock(symbol: symbol, name: name))
        }
    }
    
    func dwShowSellToStock(symbol: String, name: String, available amount: Double, from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.sellStock(symbol: symbol, name: name, available: amount))
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
    
    func showDetailedOrderHistory(name: String,
                                  amount: Double,
                                  mode: DWHistoryOrderMode,
                                  from vc: UIViewController? = nil) {
        
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.detailedHistory(name: name,
                                                 amount: amount,
                                                 mode: mode))
        }
    }
    
    func showSetupPassword(from vc: UIViewController? = nil) {
        if let dwCoordinator = dwCoordinator {
            if let vc = vc {
                vc.present(dwCoordinator.navController, animated: true)
            } else {
                mainTabBarViewController?.present(dwCoordinator.navController, animated: true)
            }
            dwCoordinator.start(.passwordSetup(dismissHandler: {
                dwCoordinator.navController.dismiss(animated: true)
            }))
        }
    }
}
