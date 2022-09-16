//
//  DriveWealthFactory.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import Foundation

final class DriveWealthFactory {
    
    func createDpositInputView(coordinator: DriveWealthCoordinator) -> DWDepositInputViewController {
        let vc = DWDepositInputViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
}
