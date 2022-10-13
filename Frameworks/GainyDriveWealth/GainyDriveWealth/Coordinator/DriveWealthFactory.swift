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
     
    func createKYCMainMenuView(coordinator: DriveWealthCoordinator) -> KYCMainViewController {
        let vc = KYCMainViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCCountrySelectorView(coordinator: DriveWealthCoordinator) -> KYCCountrySelectorViewController {
        let vc = KYCCountrySelectorViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCCountrySearchView(coordinator: DriveWealthCoordinator, delegate: KYCCountrySearchViewControllerDelegate) -> KYCCountrySearchViewController {
        let vc = KYCCountrySearchViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.delegate = delegate
        return vc
    }
    
    func createKYCHowMuchDepositView(coordinator: DriveWealthCoordinator) -> KYCHowMuchDepositViewController {
        let vc = KYCHowMuchDepositViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCPaymentMethodView(coordinator: DriveWealthCoordinator) -> KYCConnectPaymentMethodViewController {
        let vc = KYCConnectPaymentMethodViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCEmailView(coordinator: DriveWealthCoordinator) -> KYCEmailViewController {
        let vc = KYCEmailViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCPhoneView(coordinator: DriveWealthCoordinator) -> KYCPhoneViewController {
        let vc = KYCPhoneViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCVerifyPhoneView(coordinator: DriveWealthCoordinator) -> KYCVerifyPhoneViewController {
        let vc = KYCVerifyPhoneViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCPasscodeView(coordinator: DriveWealthCoordinator) -> KYCPasscodeViewController {
        let vc = KYCPasscodeViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCFaceIDView(coordinator: DriveWealthCoordinator) -> KYCFaceIDViewController {
        let vc = KYCFaceIDViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCLegalNameView(coordinator: DriveWealthCoordinator) -> KYCLegalNameViewController {
        let vc = KYCLegalNameViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }

    func createKYCResidentalAddressView(coordinator: DriveWealthCoordinator) -> KYCResidentalAddressViewController {
        let vc = KYCResidentalAddressViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCSocialSecurityNumberView(coordinator: DriveWealthCoordinator) -> KYCSocialSecurityNumberViewController {
        let vc = KYCSocialSecurityNumberViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCStateSearthView(coordinator: DriveWealthCoordinator, delegate: KYCStateSearchViewControllerDelegate) -> KYCStateSearchViewController {
        let vc = KYCStateSearchViewController.instantiate(.kyc)
        vc.delegate = delegate
        vc.coordinator = coordinator
        vc.Network = coordinator.Network
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
}
