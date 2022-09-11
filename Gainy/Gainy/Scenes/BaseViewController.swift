//
//  BaseViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.08.2021.
//

import UIKit
import MBProgressHUD
import Combine
import Network
import LinkKit
import Lottie
import PureLayout
import FirebaseAuth
import GainyCommon

protocol LinkOAuthHandling {
    var linkHandler: Handler? { get }
}

class BaseViewController: GainyBaseViewController, LinkOAuthHandling {
    
    //MARK: - Helpers
    var linkHandler: Handler?

    
    // MARK: - Properties
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.publisher(for: NotificationManager.remoteConfigLoadedNotification)
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: {[weak self] _ in
                self?.fillBackColor()
            }.store(in: &cancellables)
        fillBackColor()
    }
    
    //MARK: - Remote colors
    
    private let vcToFill: [String] = [String(describing: HomeViewController.self),
                                      String(describing: CollectionDetailsViewController.self),
                                      String(describing: SingleCollectionDetailsViewController.self),
                                    String(describing: DiscoverCollectionsViewController.self),
                                      String(describing: HoldingsViewController.self),
                                      String(describing: DemoHoldingsViewController.self)]
    
    private func fillBackColor() {
        let curName = String(describing: type(of: self))
        if vcToFill.contains(curName) {
            view.fillRemoteBack()
        }
    }
    
    
    
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        if let dismissHandler = dismissHandler {
            dismissHandler()
            self.dismissHandler = nil
        }
        super.dismiss(animated: flag, completion: completion)
    }
    

    
    //MARK: - Analytics
    
    private var loadTime: Date = Date()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadTime = Date()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postLeaveAnalytics()
    }
    
    func postLeaveAnalytics() {
        let userID: String = Auth.auth().currentUser?.uid ?? "anonymous"
        var initialParams = ["screen_id" : String(describing: self).components(separatedBy: ".").last!,
                             "user_id" : userID,
                             "start_ts" : loadTime.timeIntervalSinceReferenceDate,
                             "end_ts" : Date().timeIntervalSinceReferenceDate,
                             "elapsed_s" : Date().timeIntervalSinceReferenceDate - loadTime.timeIntervalSinceReferenceDate,
                             "sn": String(describing: self).components(separatedBy: ".").last!] as [String : AnyHashable]
        if let tickerVC = self as? TickerViewController {
            initialParams["ticker_symbol"] = tickerVC.viewModel?.ticker.symbol ?? "-"
        }
        if let collectionsVC = self as? CollectionDetailsViewController {
            initialParams["collection_id"] = collectionsVC.collectionID
        }
        GainyAnalytics.logEvent("gios_screen_view", params: initialParams)
    }
    
    deinit {
        cancellables.removeAll()
        removeKeyboardEventListeners()
    }
    
    fileprivate func removeKeyboardEventListeners() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Logout
    private func observeLogout() {
        NotificationCenter.default.publisher(for: NotificationManager.userLogoutNotification, object: nil)
            .sink { [weak self] status in
                self?.userLoggedOut()
            }
            .store(in: &cancellables)
    }
    
    func userLoggedOut() {
        
    }
}

//To work with Storyboards
extension BaseViewController: Storyboarded {
    
}
