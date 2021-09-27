//
//  OnboardingFinalizingViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/7/21.
//

import UIKit

final class OnboardingFinalizingViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    weak var authorizationManager: AuthorizationManager?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let builder = self.coordinator?.profileInfoBuilder else {
            self.coordinator?.dismissModule()
            self.coordinator?.popToRootModule()
            NotificationManager.shared.showError("Sorry... Failed to finalize the authorization. Please try again later.")
            return
        }
        
        self.coordinator?.profileInfoBuilder.userID = self.authorizationManager?.userID()
        self.authorizationManager?.finalizeSignUp(builder, completion: { authorizationStatus in
            
            self.coordinator?.dismissModule()
            if authorizationStatus == .authorizedFully {
                if let finishFlow = self.coordinator?.finishFlow {
                    finishFlow()
                }
            } else {
                self.coordinator?.popToRootModule()
                NotificationManager.shared.showError("Sorry... Failed to finalize the authorization. Please try again later.")
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}