//
//  HomeNotificationViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.01.2023.
//

import UIKit
import GainyCommon

final class HomeNotificationViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    
    var notification: ServerNotification?
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
