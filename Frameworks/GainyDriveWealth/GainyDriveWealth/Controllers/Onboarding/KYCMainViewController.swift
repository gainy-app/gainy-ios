//
//  KYCMainViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 09.09.2022.
//

import UIKit
import GainyCommon

enum KYCMainViewControllerState: Int {
    case createAccount, verifyIdentity, investorProfile, submit
    
    func increment() -> KYCMainViewControllerState {
        return KYCMainViewControllerState.init(rawValue: self.rawValue + 1) ?? .submit
    }
    
    func decrement() -> KYCMainViewControllerState {
        return KYCMainViewControllerState.init(rawValue: self.rawValue - 1) ?? .createAccount
    }
}

final class KYCMainViewController: DWBaseViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        self.updateState(state: .createAccount)
    }
    
    
    public func updateState(state: KYCMainViewControllerState) {
        
        self.state = state
        
        self.createAccountEditButton.isHidden = true
        self.verifyIdentityEditButton.isHidden = true
        self.investorProfileEditButton.isHidden = true
        
        self.createAccountView.layer.borderWidth = 0.0
        self.createAccountView.layer.borderColor = UIColor.clear.cgColor
        self.verifyIdentityView.layer.borderWidth = 0.0
        self.verifyIdentityView.layer.borderColor = UIColor.clear.cgColor
        self.investorProfileView.layer.borderWidth = 0.0
        self.investorProfileView.layer.borderColor = UIColor.clear.cgColor
        
        let bgColor = UIColor(displayP3Red: 231.0 / 255.0, green: 234.0 / 255.0, blue: 238.0 / 255.0, alpha: 1.0)
        let activeColor = UIColor(displayP3Red: 0.0 / 255.0, green: 98.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        
        self.createAccountNumberView.backgroundColor = bgColor
        self.verifyIdentityNumberView.backgroundColor = bgColor
        self.investorProfileNumberView.backgroundColor = bgColor
        
        self.nextBtn.configureWithTitle(title: "Contimue", color: UIColor.white, state: .normal)
        
        
        switch state {
        case .createAccount:
            self.nextBtn.configureWithTitle(title: "Start", color: UIColor.white, state: .normal)
            self.createAccountView.layer.borderWidth = 2.0
            self.createAccountView.layer.borderColor = activeColor.cgColor
            self.createAccountNumberView.backgroundColor = activeColor
            
        case .verifyIdentity:
            self.verifyIdentityView.layer.borderWidth = 2.0
            self.verifyIdentityView.layer.borderColor = activeColor.cgColor
            self.createAccountNumberView.backgroundColor = activeColor
            self.verifyIdentityNumberView.backgroundColor = activeColor
            self.createAccountEditButton.isHidden = false
            
        case .investorProfile:
            self.investorProfileView.layer.borderWidth = 2.0
            self.investorProfileView.layer.borderColor = activeColor.cgColor
            self.createAccountNumberView.backgroundColor = activeColor
            self.verifyIdentityNumberView.backgroundColor = activeColor
            self.investorProfileNumberView.backgroundColor = activeColor
            self.createAccountEditButton.isHidden = false
            self.verifyIdentityEditButton.isHidden = false
            
        case .submit:
            self.createAccountNumberView.backgroundColor = activeColor
            self.verifyIdentityNumberView.backgroundColor = activeColor
            self.investorProfileNumberView.backgroundColor = activeColor
            self.createAccountEditButton.isHidden = false
            self.verifyIdentityEditButton.isHidden = false
            self.investorProfileEditButton.isHidden = false
            self.nextBtn.configureWithTitle(title: "Done! Submit this form", color: UIColor.white, state: .normal)
        }
    }
    
    private var state: KYCMainViewControllerState = .createAccount
    
    @IBOutlet private weak var createAccountView: UIView!
    @IBOutlet private weak var verifyIdentityView: UIView!
    @IBOutlet private weak var investorProfileView: UIView!
    
    @IBOutlet private weak var createAccountNumberView: UIView!
    @IBOutlet private weak var verifyIdentityNumberView: UIView!
    @IBOutlet private weak var investorProfileNumberView: UIView!
    
    @IBOutlet private weak var createAccountEditButton: GainyButton! {
        didSet {
            createAccountEditButton.configureWithCornerRadius(radius: 0.0)
            createAccountEditButton.configureWithBackgroundColor(color: UIColor.clear)
            createAccountEditButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    @IBOutlet private weak var verifyIdentityEditButton: GainyButton! {
        didSet {
            verifyIdentityEditButton.configureWithCornerRadius(radius: 0.0)
            verifyIdentityEditButton.configureWithBackgroundColor(color: UIColor.clear)
            verifyIdentityEditButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    @IBOutlet private weak var investorProfileEditButton: GainyButton! {
        didSet {
            investorProfileEditButton.configureWithCornerRadius(radius: 0.0)
            investorProfileEditButton.configureWithBackgroundColor(color: UIColor.clear)
            investorProfileEditButton.configureWithHighligtedBackgroundColor(color: UIColor.clear)
        }
    }
    
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Done! Submit this form", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Contimue", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Start", color: UIColor.white, state: .normal)
        }
    }
    
    @IBAction func nextBtnAction(_ sender: Any) {
        self.updateState(state: self.state.increment())
    }
    
    @IBAction func createAccountEditButtonAction(_ sender: Any) {
        self.updateState(state: self.state.decrement())
    }
    
    @IBAction func verifyIdentityEditButtonAction(_ sender: Any) {
        self.updateState(state: self.state.decrement())
    }
    
    @IBAction func investorProfileEditButtonAction(_ sender: Any) {
        self.updateState(state: self.state.decrement())
    }
}

