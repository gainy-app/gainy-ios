//
//  BaseViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.08.2021.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    //MARK: - Haptic
    
    private(set) var feedbackGenerator: UIImpactFeedbackGenerator?
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func initHaptics() {
        feedbackGenerator = UIImpactFeedbackGenerator()
        feedbackGenerator?.prepare()
    }
    
    func impactOccured() {
        feedbackGenerator?.impactOccurred()
    }
    
    //MARK: - Loaders
    
    /// HUD to show
    private var hudProgress: MBProgressHUD?
    
    lazy var keyWindow: UIView =  {
        UIApplication.shared.keyWindow ?? UIView()
    }()
    
    /// Show Network HUD
    func showNetworkLoader() {
        if hudProgress == nil {
            hudProgress = MBProgressHUD.showAdded(to: keyWindow, animated: true)
        }
        hudProgress?.mode = .indeterminate;
        hudProgress?.label.text = NSLocalizedString("Loading", comment: "");
    }
    
    /// Hide HUD
    func hideLoader() {
        hudProgress?.hide(animated: true)
    }
    
    
    
}
