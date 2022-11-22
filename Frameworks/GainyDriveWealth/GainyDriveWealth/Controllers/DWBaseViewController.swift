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
    
    let minInvestAmount: Double = 10.0
    
    //MARK:- Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.gainyNavigationBar)
        self.gainyNavigationBar.autoPinEdge(toSuperviewEdge: .top)
        self.gainyNavigationBar.autoPinEdge(toSuperviewEdge: .leading)
        self.gainyNavigationBar.autoPinEdge(toSuperviewEdge: .trailing)
        self.gainyNavigationBar.autoSetDimension(.height, toSize: 50.0)
        
        self.gainyNavigationBar.configureWithItems(items: [.close])
        
        self.gainyNavigationBar.closeActionHandler = { sender in
           
            let alertController = UIAlertController(title: nil, message: NSLocalizedString("Are you sure want to abandon the process?", comment: ""), preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
                
            }
            let proceedAction = UIAlertAction(title: NSLocalizedString("Proceed", comment: ""), style: .destructive) { (action) in
                self.dismiss(animated: true)
            }
            alertController.addAction(proceedAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
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
}

//To work with Storyboards
extension DWBaseViewController: DWStoryboarded {
    
}
