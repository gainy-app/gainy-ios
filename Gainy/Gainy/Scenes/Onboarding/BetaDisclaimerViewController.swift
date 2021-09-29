//
//  BetaDisclaimerViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/23/21.
//

import UIKit

final class BetaDisclaimerViewController: BaseViewController {
    
    @UserDefault<Bool>("betaDisclaimerWasShownKey")
    static private(set) var betaDisclaimerWasShown: Bool?
    
    //Coordinators
    weak var coordinator: OnboardingCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func onAcceptButtonTap(_ sender: Any) {
        
        GainyAnalytics.logEvent("accept_beta_disclaimer_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "BetaDisclaimer"])
        BetaDisclaimerViewController.betaDisclaimerWasShown = true
        self.dismiss(animated: true, completion: nil)
    }

}
