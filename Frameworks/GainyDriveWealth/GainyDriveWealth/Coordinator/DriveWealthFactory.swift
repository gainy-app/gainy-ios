//
//  DriveWealthFactory.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import Foundation

final class DriveWealthFactory {
    
    func createDepositInputView(coordinator: DriveWealthCoordinator) -> DWDepositInputViewController {
        let vc = DWDepositInputViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDepositInputOverviewView(coordinator: DriveWealthCoordinator) -> DWDepositInputReviewViewController {
        let vc = DWDepositInputReviewViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDepositInputDoneView(coordinator: DriveWealthCoordinator) -> DWDepositInputDoneViewController {
        let vc = DWDepositInputDoneViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createWithdrawInputView(coordinator: DriveWealthCoordinator) -> DWDepositInputViewController {
        let vc = DWDepositInputViewController.instantiate(.deposit)
        vc.mode = .withdraw
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createInvestInputView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String) -> DWOrderInputViewController {
        let vc = DWOrderInputViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        return vc
    }
    
    func createInvestOrderView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String) -> DWOrderOverviewController {
        let vc = DWOrderOverviewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        return vc
    }
    
    func createInvestOrderSpaceView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String) -> DWOrderInvestSpaceViewController {
        let vc = DWOrderInvestSpaceViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        return vc
    }
    
    func createInvestOrderDetailsView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String) -> DWOrderDetailsViewController {
        let vc = DWOrderDetailsViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        return vc
    }
     
}
