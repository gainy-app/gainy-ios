//
//  LaunchScreenViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/27/21.
//

import UIKit

class LaunchScreenViewController: BaseViewController {
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var authorizationManager: AuthorizationManager?
    weak var coordinator: OnboardingCoordinator?
    var betaDisclaimerViewController: BetaDisclaimerViewController?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let betaDisclaimerViewController = self.betaDisclaimerViewController {
            betaDisclaimerViewController.modalPresentationStyle = .fullScreen
            self.present(betaDisclaimerViewController, animated: false, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func signInTouchUpInside(_ sender: Any) {
        
        GainyAnalytics.logEvent("sign_in_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "LaunchScreen"])
        self.coordinator?.presentAuthorizationViewController()
    }
    
    @IBAction func getStartedTouchUpInside(_ sender: Any) {
        
        self.authorizationManager?.resetStatus()
        GainyAnalytics.logEvent("get_started_pressed", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "LaunchScreen"])
        self.coordinator?.pushIntroductionViewController()
    }
    
}
