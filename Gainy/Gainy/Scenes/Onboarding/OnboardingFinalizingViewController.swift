//
//  OnboardingFinalizingViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/7/21.
//

import UIKit

final class OnboardingFinalizingViewController: BaseViewController {

    weak var coordinator: OnboardingCoordinator?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // TODO: Finalize the signup
        showNetworkLoader()
        let item = DispatchWorkItem { [weak self] in
            self?.hideLoader()
            if let flow = self?.coordinator?.finishFlow {
                flow()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: item)
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
