//
//  GainyBaseViewController.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 09.09.2022.
//

import UIKit
import MBProgressHUD
import Combine
import Network
import Lottie
import PureLayout


open class GainyBaseViewController: UIViewController {
    
    //MARK: - Helpers
    
    open var dismissHandler: (() -> ())? = nil
    
    public static var topViewController: UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    fileprivate var viewTapGesture: UITapGestureRecognizer?
    open var dismissKeyboardOnTap: Bool = false {
        didSet {
            if dismissKeyboardOnTap {
                if self.viewTapGesture == nil {
                    self.viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(GainyBaseViewController.viewEndEditing))
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
    
    @objc open func viewEndEditing() {
        self.view.endEditing(true)
    }
    
    //MARK: - Haptic
    
    open private(set) var feedbackGenerator: UIImpactFeedbackGenerator?
    
    // MARK: - Properties
    open var cancellables = Set<AnyCancellable>()
    private let monitorQueue = DispatchQueue(label: "monitor")
    
    @Atomic
    private var networkStatus: NWPath.Status?
    
    /// Actual network status
    open var haveNetwork: Bool {
        networkStatus == .satisfied
    }
    
    //MARK:- Life Cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        observeNetworkStatus()
        setupAnimation()
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
    
    private func setupAnimation() {
        let animation = Animation.named("loader3")
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        
        animationContainerView.alpha = 0.0
        
        
        view.addSubview(animationContainerView)
        animationContainerView.autoSetDimensions(to: .init(width: 64, height: 64))
        animationContainerView.autoCenterInSuperview()
        
        animationContainerView.addSubview(animationView)
        animationView.autoSetDimensions(to: .init(width: 32, height: 32))
        animationView.autoCenterInSuperview()
        
    }
    
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        
        if let dismissHandler = dismissHandler {
            dismissHandler()
            self.dismissHandler = nil
        }
        super.dismiss(animated: flag, completion: completion)
    }
    
    open func plainDismiss() {
        super.dismiss(animated: true)
    }
    
    private func initHaptics() {
        feedbackGenerator = UIImpactFeedbackGenerator()
        feedbackGenerator?.prepare()
    }
    
    open func impactOccured() {
        feedbackGenerator?.impactOccurred()
    }
    
    //MARK: - Loaders
    
    private let animationContainerView = UIView()
    private let animationView = AnimationView()
    
    open lazy var keyWindow: UIView =  {
        UIApplication.shared.keyWindow ?? UIView()
    }()
    
    @Atomic
    private(set) var isNetworkLoading: Bool = false
    
    open func isLoading() -> Bool {
        return self.isNetworkLoading
    }
    
    /// Show Network HUD
    open func showNetworkLoader() {
        animationContainerView.backgroundColor = .white
        animationContainerView.alpha = 1.0
        animationContainerView.layer.cornerRadius = 32.0
        animationContainerView.clipsToBounds = true
        view.bringSubviewToFront(animationContainerView)
        animationView.play(fromProgress: 0, toProgress: 1, loopMode: LottieLoopMode.repeat(.infinity), completion: nil)
        isNetworkLoading = true
    }
    
    /// Hide HUD
    open func hideLoader() {
        
        if Thread.isMainThread {
            self.animationView.stop()
            self.animationContainerView.alpha = 0.0
            self.isNetworkLoading = false
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.animationView.stop()
            self?.animationContainerView.alpha = 0.0
            self?.isNetworkLoading = false
        }
    }
    
    //MARK: - Keyboard
    
    open var keyboardSize: CGRect?
    
    fileprivate func addKeyboardEventsListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc open func keyboardWillShow(_ notification: Notification) {
        if let userInfo = (notification as NSNotification).userInfo {
            if let keyboardSize =  (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.keyboardSize = keyboardSize
            }
        }
    }
    
    @objc open func keyboardWillHide(_ notification: Notification) {
    }
    
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addKeyboardEventsListeners()
    }
    
    deinit {
        cancellables.removeAll()
        removeKeyboardEventListeners()
    }
    
    fileprivate func removeKeyboardEventListeners() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - Child VCs
    
    open func addViewController(_ controller: UIViewController, view: UIView) {
        if (!view.subviews.contains(controller.view)) {
            self.addChild(controller)
            view.addSubview(controller.view)
            controller.view.frame = view.bounds
            controller.didMove(toParent: self)
        }
    }
    
    open func removeViewController(_ controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
}

extension GainyBaseViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchView = touch.view {
            if touchView is UIButton {
                return false
            }
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


