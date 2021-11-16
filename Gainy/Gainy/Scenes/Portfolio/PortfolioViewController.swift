//
//  PortfolioViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 17.08.2021.
//

import UIKit
import SwiftUI

final class PortfolioViewController: BaseViewController {
    
    //MARK: - Child VCs
    lazy var noPlaidVC = NoPlaidViewController.instantiate(.portfolio)
    lazy var holdingsVC = HoldingsViewController.instantiate(.portfolio)
    
    //MARK: - Outlets
    
    @IBOutlet private weak var containerView: UIView!
    
    //MARK: - State
    enum LinkState {
        case noLink, linkedNoHoldings, linkHasHoldings
    }
    
    private var state: LinkState = .noLink {
        didSet {
            switch state {
            case .noLink:
                if !children.contains(noPlaidVC) {
                    removeAllChildVCs()
                    noPlaidVC.delegate = self
                    addViewController(noPlaidVC, view: containerView)
                }
            case .linkedNoHoldings:
                if !children.contains(holdingsVC) {
                    removeAllChildVCs()
                    addViewController(holdingsVC, view: containerView)
                }
            case .linkHasHoldings:
                if !children.contains(holdingsVC) {
                    removeAllChildVCs()
                    addViewController(holdingsVC, view: containerView)
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
        if UserProfileManager.shared.isPlaidLinked {
            state = .linkHasHoldings
        } else {
            state = .noLink
        }
    }
    
    override func plaidLinked() {
        super.plaidLinked()
        
        state = .linkHasHoldings
    }
}

extension PortfolioViewController: NoPlaidViewControllerDelegate {
    func plaidLinked(controller: NoPlaidViewController) {
        UserProfileManager.shared.isPlaidLinked = true        
        state = .linkHasHoldings
    }
}
