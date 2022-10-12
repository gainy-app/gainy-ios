//
//  DriveWealth+Deposit.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import Foundation
import UIKit

extension DriveWealthCoordinator {
    
    func popToViewController(vcClass: AnyClass) {
        let controllers = navController.viewControllers
        var viewController: UIViewController? = nil
        for vc in controllers {
            if vc.classForCoder == vcClass {
                viewController = vc;
                break;
            }
        }
        guard let destination = viewController else {
            self.popToRoot()
            return
        }
        
        navController.popToViewController(destination, animated: true)
    }
    
    func pop() {
        navController.popViewController(animated: true)
    }
    
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
    
    func showKYCHowMuchDeposit() {
        let vc = factory.createKYCHowMuchDepositView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCPaymentMethodView() {
        let vc = factory.createKYCPaymentMethodView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCEmailView() {
        let vc = factory.createKYCEmailView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCPhoneView() {
        let vc = factory.createKYCPhoneView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCVerifyPhoneView(last4Digits: String) {
        let vc = factory.createKYCVerifyPhoneView(coordinator: self)
        vc.last4Digits = last4Digits
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCPasscodeView() {
        let vc = factory.createKYCPasscodeView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCVerifyPasscodeView(passcode: String) {
        let vc = factory.createKYCPasscodeView(coordinator: self)
        vc.state = .verify
        vc.passcode = passcode
        navController.pushViewController(vc, animated: true)
    }
    
    func showKYCFaceIDView() {
        let vc = factory.createKYCFaceIDView(coordinator: self)
        navController.pushViewController(vc, animated: true)
    }
    
}
