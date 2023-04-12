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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.publisher(for: NotificationManager.dwBalanceUpdatedNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak self] _ in
                self?.loadBasedOnState()
            }.store(in: &cancellables)
    }
    
    //MARK: - State
    enum LinkState {
        case none, noLink, linkedNoHoldings, linkHasHoldings, inProgress
    }
    
    private var state: LinkState = .noLink {
        didSet {
            switch state {
            case .none:
                if !children.contains(holdingsVC) {
                    removeAllChildVCs()
                    holdingsVC.delegate = self
                    addViewController(holdingsVC, view: containerView)
                    holdingsVC.animateLoad()
                }
                holdingsVC.coordinator = mainCoordinator
                holdingsVC.animateLoad()
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
                hideLoader()
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
                
                measure(name: "Holding total load") {
                    holdingsVC.loadData()
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
        showNetworkLoader()
        state = .none
        Task {
            let kycStatus = await UserProfileManager.shared.getProfileStatus()
            await MainActor.run {
                hideLoader()
            }
            if let kycStatus = kycStatus {
                await MainActor.run {
                    if (kycStatus.depositedFunds ?? false) {
                        state = .linkHasHoldings
                    } else {
                        state = .noLink
                    }
                }
            } else {
                await MainActor.run {
                    state = .noLink
                }
            }
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
        if state != .noLink {
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
