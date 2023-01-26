//
//  PortfolioViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit
import SwiftUI
import SwiftDate

final class PortfolioViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    
    //MARK: - Child VCs
    lazy var noPlaidVC = DemoHoldingsViewController.instantiate(.portfolio)
    lazy var holdingsVC = HoldingsViewController.instantiate(.portfolio)
    lazy var noHoldingsVC = NoHoldingsViewController.instantiate(.portfolio)
    lazy var inProgressHoldingsVC = HoldingsInProgressViewController.instantiate(.portfolio)
    
    
    //MARK: - Outlets
    
    @IBOutlet private weak var containerView: UIView!
    
    //MARK: - State
    enum LinkState {
        case noLink, linkedNoHoldings, linkHasHoldings, inProgress
    }
    
    private var state: LinkState = .noLink {
        didSet {
            switch state {
            case .noLink:
                if !children.contains(noPlaidVC) {
                    removeAllChildVCs()
                    noPlaidVC.delegate = self
                    addViewController(noPlaidVC, view: containerView)
                    noPlaidVC.loadData()
                    noPlaidVC.coordinator = mainCoordinator
                }
            case .linkedNoHoldings:
                if !children.contains(noHoldingsVC) {
                    removeAllChildVCs()
                    noHoldingsVC.delegate = self
                    addViewController(noHoldingsVC, view: containerView)
                }
            case .linkHasHoldings:
                SharedValuesManager.shared.demoPortoGains = nil
                if !children.contains(holdingsVC) {
                    removeAllChildVCs()
                    holdingsVC.delegate = self
                    addViewController(holdingsVC, view: containerView)
                    measure(name: "Holding total load") {
                        holdingsVC.loadData()
                    }
                }
                holdingsVC.coordinator = mainCoordinator
                if !holdingsVC.viewModel.haveHoldings {
                    measure(name: "Holding total load") {
                        holdingsVC.loadData()
                    }
                }
            case .inProgress:
                if !children.contains(inProgressHoldingsVC) {
                    removeAllChildVCs()
                    inProgressHoldingsVC.delegate = self
                    addViewController(inProgressHoldingsVC, view: containerView)
                }
            }
        }
    }
    
    private func removeAllChildVCs() {
        for childVC in children {
            removeViewController(childVC)
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBasedOnState()
    }
    
    private func loadBasedOnState() {
        if (UserProfileManager.shared.kycStatus?.depositedFunds ?? false) {
            state = .linkHasHoldings
        } else {
            state = .noLink
        }
    }
    
    override func plaidLinked() {
        super.plaidLinked()
        
        state = .linkHasHoldings
        NotificationManager.shared.requestAppReviewForm()
    }
    
    override func userLoggedOut() {
        super.userLoggedOut()
        
        state = .noLink
    }
}

extension PortfolioViewController: NoPlaidViewControllerDelegate {
    func plaidLinked(controller: BaseViewController) {
        UserProfileManager.shared.isPlaidLinked = true        
        state = .linkHasHoldings
    }
}

extension PortfolioViewController: HoldingsViewControllerDelegate {
    func noHoldings(controller: HoldingsViewController) {
        if let connectDate = UserProfileManager.shared.linkPlaidDate {
            if connectDate + 5.minutes < Date() {
                state = .linkedNoHoldings
            } else {
                state = .inProgress
            }
        } else {
            UserProfileManager.shared.linkPlaidDate = Date()
            state = .inProgress
        }
    }
    
    func plaidUnlinked(controller: HoldingsViewController) {
        UserProfileManager.shared.linkPlaidDate = Date()
        self.loadBasedOnState()
    }
}

extension PortfolioViewController: NoHoldingsViewControllerDelegate {
    func plaidLinked(vc: NoHoldingsViewController) {
        UserProfileManager.shared.linkPlaidDate = Date()
        state = .linkHasHoldings
        self.loadBasedOnState()
    }
}

extension PortfolioViewController: HoldingsInProgressViewControllerDelegate {
    func discoveryPressed(vc: HoldingsInProgressViewController) {
        tabBarController?.selectedIndex = 0
    }
}
