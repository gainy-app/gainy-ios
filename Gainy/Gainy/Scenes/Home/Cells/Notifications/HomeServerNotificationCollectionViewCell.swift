//
//  HomeServerNotificationCollectionViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.01.2023.
//

import UIKit
import GainyCommon
import SwiftDate

final class HomeServerNotificationCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        "HomeServerNotificationCollectionViewCell"
    }
    
    @IBOutlet private weak var dateLbl: UILabel!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var textLbl: UILabel!
    @IBOutlet private weak var unreadIndicator: CornerView!
    @IBOutlet private weak var unreadView: CornerView!
    @IBOutlet private weak var shadowView: HomeShadowView!
    
    var hideText: Bool = false {
        didSet {
            textLbl.isHidden = hideText
            unreadView.isHidden = hideText
            shadowView.isHidden = hideText
        }
    }
    
    var notification: ServerNotification? {
        didSet {
            if let notification {
                dateLbl.text = notification.date.toRelative(style: RelativeFormatter.defaultStyle())
                titleLbl.text = notification.titlePlain
                textLbl.text = notification.textPlain
                unreadView.isHidden = ServerNotificationsManager.shared.isNotifViewed(notification)
            }
        }
    }
}
