//
//  HomeNotificationViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.01.2023.
//

import UIKit
import GainyCommon
import SwiftDate

final class HomeNotificationViewController: BaseViewController {
    
    var mainCoordinator: MainCoordinator?
    var notification: ServerNotification?
    
    @IBOutlet private weak var dateLbl: UILabel!
    
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var textLbl: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBasedOnData()
    }
    
    private func loadBasedOnData() {
        if let notification {
            dateLbl.text = notification.date.toRelative(style: RelativeFormatter.defaultStyle())
            titleLbl.text = notification.titlePlain
            textLbl.text = notification.textPlain
            
            Task {
                await ServerNotificationsManager.shared.viewNotifications(notifications: [notification])
            }
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
