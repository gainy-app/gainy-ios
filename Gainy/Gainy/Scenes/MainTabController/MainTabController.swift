//
//  MainTabController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.08.2021.
//
import UIKit
import FirebaseAuth
import Combine
import GainyCommon

extension UIImage {
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!

        context.setFillColor(color.cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

class MainTabBarViewController: UITabBarController, Storyboarded, UITabBarControllerDelegate {
    
    //Coordinators
    weak var coordinator: MainCoordinator?
    
    @UserDefaultBool("needShowFaceIdLogin")
    var needSkipFaceIdLogin: Bool
    
    fileprivate var tabBarHeight: CGFloat = 49.0
    fileprivate var collectionDetailsViewController: CollectionDetailsViewController? = nil
    fileprivate var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            let kycStatus = await UserProfileManager.shared.getProfileStatus()
            if let kycDone = kycStatus?.kycDone {
                if kycDone && UserProfileManager.shared.passcodeSHA256 == nil && !self.needSkipFaceIdLogin {
                    self.showFaceIDAlert()
                }
            }
        }
        
        delay(1.0) {
            self.showIDFAIfNeeded()
        }
    }
    
    fileprivate func setupTabs() {
        if let coordinator = coordinator {            
            let detailsNav = UINavigationController.init(rootViewController: coordinator.viewControllerFactory.instantiateDiscovery(coordinator: coordinator))
            coordinator.collectionRouter = Router(rootController: detailsNav)
            detailsNav.setNavigationBarHidden(true, animated: false)
            setViewControllers([coordinator.viewControllerFactory.instantiateHomeVC(coordinator: coordinator),
                                detailsNav,
                                coordinator.viewControllerFactory.instantiatePortfolioVC(coordinator: coordinator),
                                coordinator.viewControllerFactory.instantiateProfileVC(coordinator: coordinator)], animated: false)
        }
        
        NotificationCenter.default.publisher(for: NotificationManager.userSignUpNotification, object: nil)
            .receive(on: DispatchQueue.main)
            .sink { _ in
        } receiveValue: {[weak self] notification in
            self?.setMainTab()
        }.store(in: &cancellables)
        
        
        Timer.publish(every: 60 * 5, on: .main, in: .common)
            .autoconnect()
            .sink { (seconds) in
                Task {
                    await ServerNotificationsManager.shared.getUnreadCount()
                }
            }
            .store(in: &cancellables)
        ServerNotificationsManager.shared.unreadCountPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] unreadCount in
                self?.tabBar.items?.first?.badgeValue = unreadCount == 0 ? nil : "\(unreadCount)"
            }
            .store(in: &cancellables)
    }
    
    fileprivate func initialSetup() {
        self.title = NSLocalizedString("Main", comment: "")
        
        setMainTab()
        delegate = self
        tabBar.barStyle = .default
        tabBar.isTranslucent = true
        setupTabBarLayout()
        //setupTabBarItems()
        tabBarHeight = self.tabBar.bounds.height + keyWindow.safeAreaInsets.bottom
        
        if let tabBar = self.tabBar as? CustomTabBar {
            tabBar.customDelegate = self
        }
    }
    
    private func showFaceIDAlert() {
        let alert = UIAlertController(title: "Do you want to use Passcode or FaceID in the application?", message: nil, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default) { [weak coordinator] _ in
            coordinator?.showSetupPassword()
        }
        let actionCancel = UIAlertAction(title: "No", style: .cancel) { [weak self] _ in
            self?.needSkipFaceIdLogin = true
        }
        alert.addAction(actionYes)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    
    private func setMainTab() {
        //Discovery is Default
        if Auth.auth().currentUser?.uid != nil {
            if UserProfileManager.shared.favoriteCollections.isEmpty {
                selectedIndex = 1
                tabBar.isHidden = true
                
                //Load Fundings
                Task {
                    async let fundings = await UserProfileManager.shared.getFundingAccounts()
                    async let kycStatus = await UserProfileManager.shared.getProfileStatus()
                    if let kycStatus = await kycStatus {
                        if !(kycStatus.kycDone ?? false) {
                            if DeeplinkManager.shared.isTradingAvailable {
                                DeeplinkManager.shared.activateDelayedTrading()
                                await MainActor.run {
                                    NotificationCenter.default.post(name: NotificationManager.requestOpenKYCNotification, object: nil)
                                }
                            }
                        }
                    }
                }
            } else {
                selectedIndex = 0
            }
        } else {
            selectedIndex = 1
        }
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            return viewController != selectedViewController
        }
    
    lazy var keyWindow: UIView =  { UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first ?? UIView()
    }()
    
    lazy var statusBarHeight: CGFloat = {
        view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }()
    
    private var toastOffset: CGFloat {
        statusBarHeight + (self.navigationController?.navigationBar.frame.height ?? 0.0) - 40.0
    }
    
    
    fileprivate func setupTabBarLayout() {
        if #available(iOS 13.0, *) {
            self.tabBar.backgroundImage = UIImage.imageWithColor(UIColor.clear)
            self.tabBar.backgroundColor = .clear
            self.tabBar.tintColor = UIColor.Gainy.grayLight
        }
    }
    
    
    
    // MARK: - TabBars
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let tabBar = self.tabBar as? CustomTabBar {
            tabBar.selectedIndex = CustomTabBar.Tab(rawValue: item.tag)!
            tabBar.updateTabs()
        }
        let tab = CustomTabBar.Tab(rawValue: selectedIndex)
        switch tab {
        case .home:
            GainyAnalytics.logEvent("tab_changed", params: ["tab" : "Home", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TabBar"])
        case .discovery:
            GainyAnalytics.logEvent("tab_changed", params: ["tab" : "Discovery", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TabBar"])
            if let vc = self.collectionDetailsViewController {
                vc.cancelSearchAsNeeded()
            }
        case .portfolio:
            GainyAnalytics.logEvent("tab_changed", params: ["tab" : "Portfolio", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TabBar"])
        case .profile:
            GainyAnalytics.logEvent("tab_changed", params: ["tab" : "Profile", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "TabBar"])
        case .none:
            break
        }
    }
    
    let arrayOfImageNameForSelectedState = ["tab0_active", "tab1_active", "tab2_active", "tab3_active"]
    let arrayOfImageNameForUnselectedState = ["tab0_passive", "tab1_passive", "tab2_passive", "tab3_passive"]
    
    private let tabNames: [String] = ["Home", "Discovery", "Portfolio", "Profile"]
    
    func setupTabBarItems(_ notif: Notification? = nil) {
        
        if let tabBar = self.tabBar as? CustomTabBar {
            tabBar.customDelegate = self
        }
        //        for vc in viewControllers ?? [] {
        //            if #available(iOS 13.0, *) {
        //                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //            } else {
        //                vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        //            }
        //        }
        
        let isLightTheme = true
        
        let selectedColor   = isLightTheme ? UIColor(named: "tabbar_tint_color")! : UIColor(named: "tabbar_tint_color")!
        let unselectedColor = isLightTheme ? UIColor(named: "tabbar_disabled_color")!: UIColor(named: "tabbar_disabled_color")!
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = isLightTheme ? arrayOfImageNameForSelectedState[i] : arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = isLightTheme ? arrayOfImageNameForUnselectedState[i] : arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].title = NSLocalizedString(tabNames[i], comment: "")
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
                
                self.tabBar.items?[i].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
                self.tabBar.items?[i].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
                self.tabBar.items?[i].tag = i
            }
        }
        
        //        for vc in self.viewControllers ?? [] where vc is MainCoordinated {
        //            if var vc = vc as? MainCoordinated {
        //                vc.coordinator = self.coordinator
        //            }
        //        }
    }
    
    fileprivate func updatedNotifIcon() -> String? {
        return nil
    }
    
    @UserDefaultBool("isIDFAShown")
    private var isIDFAShown: Bool
    
    private func showIDFAIfNeeded() {
        guard !isIDFAShown else {return}
        let idfaVC = IDFARequestViewController.instantiate(.popups)
        idfaVC.modalPresentationStyle = .fullScreen
        present(idfaVC, animated: true, completion: nil)
        isIDFAShown = true
    }
    
    // MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MainTabBarViewController: CustomTabBarDelegate {
    func profileTabPressed(tabBar: CustomTabBar) {
        selectedIndex = CustomTabBar.Tab.profile.rawValue
    }
    
    func profileTabPressedLong(tabBar: CustomTabBar) {
        selectedIndex = CustomTabBar.Tab.profile.rawValue
    }
    
    func otherTabPressedLong(tabBar: CustomTabBar) {
        
    }
}
