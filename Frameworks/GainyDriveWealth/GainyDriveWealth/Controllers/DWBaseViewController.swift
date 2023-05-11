//
//  DWBaseViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import GainyCommon
import PureLayout
import UIKit
import LinkKit

public class DWBaseViewController: GainyBaseViewController, DriveWealthCoordinated {
    
    // MARK: - Properties
    
    weak var coordinator: DriveWealthCoordinator?
    unowned var GainyAnalytics: GainyCommon.GainyAnalyticsProtocol!
    unowned var dwAPI: DWAPI!
    var gainyNavigationBar = GainyNavigationBar.newAutoLayout()
    
    var userProfile: GainyProfileProtocol {
        dwAPI.userProfile
    }
    
    var minInvestAmount: Double = 10.0
    
    var closeMessage = "Are you sure want to abandon the process?"
    
    //MARK:- Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.gainyNavigationBar)
        self.gainyNavigationBar.autoPinEdge(toSuperviewEdge: .top)
        self.gainyNavigationBar.autoPinEdge(toSuperviewEdge: .leading)
        self.gainyNavigationBar.autoPinEdge(toSuperviewEdge: .trailing)
        self.gainyNavigationBar.autoSetDimension(.height, toSize: 50.0)
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        
        self.gainyNavigationBar.closeActionHandler = {[weak self] sender in
            guard let self = self else {return}
            if let parentCoordinator = self.coordinator?.parentCoordinator {
                parentCoordinator.navController.dismiss(animated: true) {
                    parentCoordinator.removeChildCoordinators()
                }
            } else {
                let alertController = UIAlertController(title: nil, message: NSLocalizedString(self.closeMessage, comment: ""), preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
                    
                }
                let proceedAction = UIAlertAction(title: NSLocalizedString("Exit", comment: ""), style: .destructive) { (action) in
                    self.dismiss(animated: true)
                }
                alertController.addAction(proceedAction)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
            .sink { _ in
            } receiveValue: { [weak self] _ in
                self?.loadTime = Date()
            }.store(in: &cancellables)
    }
    
    //MARK: - Analytics
    
    private var loadTime: Date = Date()
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadTime = Date()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        postLeaveAnalytics()
    }
    
    func postLeaveAnalytics() {
        var initialParams = ["screen_id" : String(describing: self).components(separatedBy: ".").last!,
                             "start_ts" : loadTime.timeIntervalSinceReferenceDate,
                             "end_ts" : Date().timeIntervalSinceReferenceDate,
                             "elapsed_s" : Date().timeIntervalSinceReferenceDate - loadTime.timeIntervalSinceReferenceDate,
                             "sn": String(describing: self).components(separatedBy: ".").last!] as [String : AnyHashable]

        GainyAnalytics.logEvent("gios_screen_view", params: initialParams)
    }
    
    deinit {
        cancellables.removeAll()
    }
    
    func showAlert(title: String = "Error", message: String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func showAlert(title: String = "Error", message: String, okAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default,handler: { _ in
            okAction?()
        }))
        present(alert, animated: true)
    }
    
    func showReconnectAlert(noAction: (() -> Void)? = nil, yesAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: "Withdrawal failed", message: "Withdrawal failed.Right now, we are not able to complete this transaction. Please reconnect your bank account and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "No, thanks", style: .default,handler: { _ in
            noAction?()
        }))
        alert.addAction(UIAlertAction.init(title: "Yes, reconnect", style: .default,handler: { _ in
            yesAction?()
        }))
        present(alert, animated: true)
    }
}

//To work with Storyboards
extension DWBaseViewController: DWStoryboarded {
    
}
