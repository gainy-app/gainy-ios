//
//  BaseViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.08.2021.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    //MARK: - Helpers
    
    static var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    fileprivate var viewTapGesture: UITapGestureRecognizer?
    var dismissKeyboardOnTap: Bool = false {
        didSet {
            if dismissKeyboardOnTap {
                if self.viewTapGesture == nil {
                    self.viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.viewEndEditing))
                    self.viewTapGesture?.cancelsTouchesInView = false
                    self.viewTapGesture?.delegate = self
                    self.view.addGestureRecognizer(self.viewTapGesture!)
                }
            } else {
                if self.viewTapGesture != nil {
                    self.view.removeGestureRecognizer(self.viewTapGesture!)
                    self.viewTapGesture = nil
                }
            }
        }
    }
    
    @objc func viewEndEditing() {
        self.view.endEditing(true)
    }
    
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

extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view {
            if touchView is UIButton {
                return false
            }
        }
        return true
    }
}
