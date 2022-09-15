//
//  DWBaseViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 12.09.2022.
//

import GainyCommon

class DWBaseViewController: GainyBaseViewController, DriveWealthCoordinated {  
    
    // MARK: - Properties
    
    var coordinator: DriveWealthCoordinator?
    var GainyAnalytics: GainyCommon.GainyAnalyticsProtocol!
    var Network: GainyCommon.GainyNetworkProtocol!
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
//        let userID: String = Auth.auth().currentUser?.uid ?? "anonymous"
//        var initialParams = ["screen_id" : String(describing: self).components(separatedBy: ".").last!,
//                             "user_id" : userID,
//                             "start_ts" : loadTime.timeIntervalSinceReferenceDate,
//                             "end_ts" : Date().timeIntervalSinceReferenceDate,
//                             "elapsed_s" : Date().timeIntervalSinceReferenceDate - loadTime.timeIntervalSinceReferenceDate,
//                             "sn": String(describing: self).components(separatedBy: ".").last!] as [String : AnyHashable]
//
//        GainyAnalytics.logEvent("gios_screen_view", params: initialParams)
    }
    
    deinit {
        cancellables.removeAll()
    }
}

//To work with Storyboards
extension DWBaseViewController: DWStoryboarded {
    
}
