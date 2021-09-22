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
    
    @IBAction func signInTouchUpInside(_ sender: Any) {
        
        self.coordinator?.presentAuthorizationViewController()
    }
    
    @IBAction func getStartedTouchUpInside(_ sender: Any) {
        
        self.coordinator?.pushIntroductionViewController()
    }
    
}
