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
    
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    
    @Atomic
    private var networkStatus: NWPath.Status?
    
    /// Actual network status
    var haveNetwork: Bool {
        networkStatus == .satisfied
    }
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeNetworkStatus()
    }
    
    // MARK: - Network Status Observation
    private func observeNetworkStatus() {
        NWPathMonitor()
            .publisher(queue: monitorQueue)
            .sink { [weak self] status in
                self?.networkStatus = status
            }
            .store(in: &cancellables)
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
    
    @Atomic
    private(set) var isNetworkLoading: Bool = false
    
    /// Show Network HUD
    func showNetworkLoader() {
        if hudProgress == nil {
            hudProgress = MBProgressHUD.showAdded(to: keyWindow, animated: true)
        }
        hudProgress?.mode = .indeterminate;
        hudProgress?.label.text = NSLocalizedString("Loading", comment: "");
        isNetworkLoading = true
    }
    
    /// Hide HUD
    func hideLoader() {
        hudProgress?.hide(animated: true)
        isNetworkLoading = false
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
        var initialParams = ["screen_id" : String(describing: self).components(separatedBy: ".").last!,
                             "user_id" : "anonymous",
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
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

//To work with Storyboards
extension BaseViewController: Storyboarded {
    
}
