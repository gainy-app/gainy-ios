//
//  DriveWealthCoordinator.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import UIKit

final class DriveWealthCoordinator {
    
    
    enum Flow {
        case onboarding, buy, sell, withdraw, transfer
    }
    
    // MARK: - Inner
    private var navController: UINavigationController!
    
    //MARK: - DI
    func start(_ flow: Flow = .onboarding) {
        
    }
}
