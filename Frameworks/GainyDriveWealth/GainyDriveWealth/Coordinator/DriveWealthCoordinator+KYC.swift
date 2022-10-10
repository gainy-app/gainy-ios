//
//  DriveWealth+Deposit.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import Foundation

extension DriveWealthCoordinator {
    
    func popToRoot() {
        navController.popToRootViewController(animated: true)
    }
    
    func showKYCMainMenu() {
        let vc = factory.createKYCMainMenuView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCCountrySelector() {
        let vc = factory.createKYCCountrySelectorView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCCountrySearch(delegate: KYCCountrySearchViewControllerDelegate) {
        let vc = factory.createKYCCountrySearchView(coordinator: self, delegate: delegate)
        vc.modalPresentationStyle = .overCurrentContext
        navController.present(vc, animated: true)
    }
}
