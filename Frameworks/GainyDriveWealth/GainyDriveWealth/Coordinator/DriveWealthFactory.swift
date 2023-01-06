//
//  DriveWealthFactory.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 16.09.2022.
//

import Foundation
import GainyCommon

final class DriveWealthFactory {
    
    func createFaceIdEnterView(coordinator: DriveWealthCoordinator, isValidEnter: @escaping BoolHandler) -> KYCEnterPasscodeViewController {
        let vc = KYCEnterPasscodeViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.isValidEnter = isValidEnter
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createAddDocumentsView(coordinator: DriveWealthCoordinator) -> SelectDocumentsToUploadViewController {
        let vc = SelectDocumentsToUploadViewController.instantiate(.documents)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createUploadDocumentsView(coordinator: DriveWealthCoordinator, and type: DocumentTypes, dismissHandler: ((DocumentTypes?) -> Void)?) -> UploadDocumentsViewController {
        let vc = UploadDocumentsViewController.instantiate(.documents)
        vc.coordinator = coordinator
        vc.documentType = type
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.dismissHandlerWithDocumentType = dismissHandler
        return vc
    }
    
    func createDepositInputView(coordinator: DriveWealthCoordinator) -> DWDepositInputViewController {
        let vc = DWDepositInputViewController.instantiate(.deposit)
        vc.mode = .deposit
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDepositInputOverviewView(coordinator: DriveWealthCoordinator) -> DWDepositInputReviewViewController {
        let vc = DWDepositInputReviewViewController.instantiate(.deposit)
        vc.mode = .deposit
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDepositInputDoneView(coordinator: DriveWealthCoordinator) -> DWDepositInputDoneViewController {
        let vc = DWDepositInputDoneViewController.instantiate(.deposit)
        vc.mode = .deposit
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDepositSelectAccountView(coordinator: DriveWealthCoordinator, isNeedToDelete: Bool = false) -> DWSelectAccountViewController {
        let vc = DWSelectAccountViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.isNeedToDelete = isNeedToDelete
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDepositComissionView(coordinator: DriveWealthCoordinator) -> DWDepositComissionViewController {
        let vc = DWDepositComissionViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createWithdrawInputView(coordinator: DriveWealthCoordinator) -> DWDepositInputViewController {
        let vc = DWDepositInputViewController.instantiate(.deposit)
        vc.mode = .withdraw
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createInvestInputView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String, mode: DWOrderInputMode = .invest, available: Double = 0.0) -> DWOrderInputViewController {
        let vc = DWOrderInputViewController.instantiate(.deposit)
        vc.mode = mode
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        vc.availableAmount = available
        vc.type = .ttf
        return vc
    }
    
    func createInvestOrderView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String, mode: DWOrderInputMode = .invest) -> DWOrderOverviewController {
        let vc = DWOrderOverviewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        vc.type = .ttf
        return vc
    }
    
    func createInvestOrderSpaceView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String, mode: DWOrderInvestSpaceStatus = .order) -> DWOrderInvestSpaceViewController {
        let vc = DWOrderInvestSpaceViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.collectionId = collectionId
        vc.name = name
        vc.mode = mode
        vc.type = .ttf
        return vc
    }
    
    func createInvestOrderDetailsView(coordinator: DriveWealthCoordinator, name: String) -> DWOrderDetailsViewController {
        let vc = DWOrderDetailsViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.name = name
        return vc
    }
    
    func createHistoryOrderDetailsView(coordinator: DriveWealthCoordinator, name: String) -> DWHistoryOrderOverviewController {
        let vc = DWHistoryOrderOverviewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.name = name
        return vc
    }
     
    func createKYCMainMenuView(coordinator: DriveWealthCoordinator) -> KYCMainViewController {
        let vc = KYCMainViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCCountrySelectorView(coordinator: DriveWealthCoordinator) -> KYCCountrySelectorViewController {
        let vc = KYCCountrySelectorViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCCitizenshipView(coordinator: DriveWealthCoordinator) -> KYCCitizenshipViewController {
        let vc = KYCCitizenshipViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCGainyCustomerAgreementView(coordinator: DriveWealthCoordinator) -> KYCGainyCustomerAgreementViewController {
        let vc = KYCGainyCustomerAgreementViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCGainyPolicyView(coordinator: DriveWealthCoordinator) -> KYCGainyPolicyViewController {
        let vc = KYCGainyPolicyViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCKeyValueSearchView(coordinator: DriveWealthCoordinator, delegate: KYCKeyValueSearchViewControllerDelegate) -> KYCKeyValueSearchViewController {
        let vc = KYCKeyValueSearchViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.delegate = delegate
        return vc
    }
    
    func createKYCCountrySearchView(coordinator: DriveWealthCoordinator, delegate: KYCCountrySearchViewControllerDelegate, exceptUSA: Bool = false) -> KYCCountrySearchViewController {
        let vc = KYCCountrySearchViewController.instantiate(.kyc)
        vc.exceptUSA = exceptUSA
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.delegate = delegate
        return vc
    }
    
    func createKYCHowMuchDepositView(coordinator: DriveWealthCoordinator) -> KYCHowMuchDepositViewController {
        let vc = KYCHowMuchDepositViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCPaymentMethodView(coordinator: DriveWealthCoordinator) -> KYCConnectPaymentMethodViewController {
        let vc = KYCConnectPaymentMethodViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCEmailView(coordinator: DriveWealthCoordinator) -> KYCEmailViewController {
        let vc = KYCEmailViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCPhoneView(coordinator: DriveWealthCoordinator) -> KYCPhoneViewController {
        let vc = KYCPhoneViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCVerifyPhoneView(coordinator: DriveWealthCoordinator) -> KYCVerifyPhoneViewController {
        let vc = KYCVerifyPhoneViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCPasscodeView(coordinator: DriveWealthCoordinator) -> KYCPasscodeViewController {
        let vc = KYCPasscodeViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCFaceIDView(coordinator: DriveWealthCoordinator) -> KYCFaceIDViewController {
        let vc = KYCFaceIDViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCLegalNameView(coordinator: DriveWealthCoordinator) -> KYCLegalNameViewController {
        let vc = KYCLegalNameViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }

    func createKYCResidentalAddressView(coordinator: DriveWealthCoordinator) -> KYCResidentalAddressViewController {
        let vc = KYCResidentalAddressViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCSocialSecurityNumberView(coordinator: DriveWealthCoordinator) -> KYCSocialSecurityNumberViewController {
        let vc = KYCSocialSecurityNumberViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCStateSearchView(coordinator: DriveWealthCoordinator, delegate: KYCStateSearchViewControllerDelegate) -> KYCStateSearchViewController {
        let vc = KYCStateSearchViewController.instantiate(.kyc)
        vc.delegate = delegate
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCYourEmploymentView(coordinator: DriveWealthCoordinator) -> KYCYourEmploymentViewController {
        let vc = KYCYourEmploymentViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCYourCompanyView(coordinator: DriveWealthCoordinator) -> KYCYourCompanyViewController {
        let vc = KYCYourCompanyViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCCompanyTypeSearchView(coordinator: DriveWealthCoordinator, delegate: KYCCompanyTypeSearchViewControllerDelegate) -> KYCCompanyTypeSearchViewController {
        let vc = KYCCompanyTypeSearchViewController.instantiate(.kyc)
        vc.delegate = delegate
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCCompanyPositionSearchView(coordinator: DriveWealthCoordinator, delegate: KYCCompanyPositionSearchViewControllerDelegate) -> KYCCompanyPositionSearchViewController {
        let vc = KYCCompanyPositionSearchViewController.instantiate(.kyc)
        vc.delegate = delegate
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCSourceOfFoundsView(coordinator: DriveWealthCoordinator) -> KYCSourceOfFoundsViewController {
        let vc = KYCSourceOfFoundsViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCAdditionalQuestionsView(coordinator: DriveWealthCoordinator) -> KYCAdditionalQuestionsViewController {
        let vc = KYCAdditionalQuestionsViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createKYCInvestmentProfileView(coordinator: DriveWealthCoordinator) -> KYCInvestmentProfileViewController {
        let vc = KYCInvestmentProfileViewController.instantiate(.kyc)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
    
    func createDWOrderHistoryView(coordinator: DriveWealthCoordinator, collectionId: Int, name: String, amount: Double) -> DWOrderDetailsViewController {
        let vc = DWOrderDetailsViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        vc.amount = amount
        vc.name = name
        return vc
    }
    
    func createDWOrdersHistoryView(coordinator: DriveWealthCoordinator) -> DWOrdersViewController {
        let vc = DWOrdersViewController.instantiate(.deposit)
        vc.coordinator = coordinator
        vc.dwAPI = coordinator.dwAPI
        vc.GainyAnalytics = coordinator.GainyAnalytics
        return vc
    }
}
