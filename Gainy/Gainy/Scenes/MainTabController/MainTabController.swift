//
//  MainTabController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.08.2021.
//
import UIKit

enum MainTab: Int {
    case discover, portfolio, analytics, profile
}

class MainTabBarViewController: UITabBarController {
    //Coordinators
    
    weak var coordinator: MainCoordinator?
    var onboardingCoordinator: MainCoordinator?
    
    fileprivate var tabBarHeight: CGFloat = 49.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    fileprivate func initialSetup() {
        selectedIndex = 1
        self.title = NSLocalizedString("Main", comment: "")
        
        //setupTabBarLayout()
        setupTabBarItems()
        tabBarHeight = self.tabBar.bounds.height + keyWindow.safeAreaInsets.bottom
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
    
    let arrayOfImageNameForSelectedState = ["tab1_active", "tab2_active", "tab3_active"]
    let arrayOfImageNameForUnselectedState = ["tab1_passive", "tab2_passive", "tab3_passive"]
    
    private let tabNames: [String] = ["Discovery", "Portfolio", "Analytics", "Profile"]
    
    func setupTabBarItems(_ notif: Notification? = nil) {
        
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
                let imageNameForSelectedState   =  isLightTheme ? arrayOfImageNameForSelectedState[i] : arrayOfImageNameForSelectedState[i]
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
