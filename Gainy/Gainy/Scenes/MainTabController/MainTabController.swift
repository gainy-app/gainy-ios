//
//  MainTabController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.08.2021.
//
import UIKit

class MainTabBarViewController: UITabBarController, Storyboarded {
    
    //Coordinators
    weak var coordinator: MainCoordinator?
    
    fileprivate var tabBarHeight: CGFloat = 49.0
    fileprivate var collectionDetailsViewController: CollectionDetailsViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        initialSetup()
    }
    
    fileprivate func setupTabs() {
        if let coordinator = coordinator {
            collectionDetailsViewController = coordinator.viewControllerFactory.instantiateCollectionDetails(coordinator: coordinator)
            setViewControllers([collectionDetailsViewController as! UIViewController,
                                coordinator.viewControllerFactory.instantiatePortfolioVC(coordinator: coordinator),
                                coordinator.viewControllerFactory.instantiateProfileVC(coordinator: coordinator)], animated: false)
        }
    }
    
    fileprivate func initialSetup() {
        self.title = NSLocalizedString("Main", comment: "")
        tabBar.barStyle = .default
        tabBar.isTranslucent = false
        //setupTabBarLayout()
        //setupTabBarItems()
        tabBarHeight = self.tabBar.bounds.height + keyWindow.safeAreaInsets.bottom
        
        if let tabBar = self.tabBar as? CustomTabBar {
            tabBar.customDelegate = self
        }
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
            let appearance = self.tabBar.standardAppearance
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            self.tabBar.standardAppearance = appearance
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
    
    let arrayOfImageNameForSelectedState = ["tab1_active", "tab2_active", "tab3_active"]
    let arrayOfImageNameForUnselectedState = ["tab1_passive", "tab2_passive", "tab3_passive"]
    
    private let tabNames: [String] = ["Discovery", "Portfolio", "Profile"]
    
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
            }
        }
        
        //        for vc in self.viewControllers ?? [] where vc is MainCoordinated {
        //            if var vc = vc as? MainCoordinated {
        //                vc.coordinator = self.coordinator
        //            }
        //        }
        
        tabBar.isTranslucent = false
    }
    
    fileprivate func updatedNotifIcon() -> String? {
        return nil
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        //NotificationCenter.default.removeObserver(self)
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
