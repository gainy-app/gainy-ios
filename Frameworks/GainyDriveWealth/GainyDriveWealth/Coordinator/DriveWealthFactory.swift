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
    
}
