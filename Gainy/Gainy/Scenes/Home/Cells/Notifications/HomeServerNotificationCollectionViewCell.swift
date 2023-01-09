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
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var unreadIndicator: CornerView!
    
    var notification: ServerNotification? {
        didSet {
            if let notification {
                dateLbl.text = notification.date.toRelative(style: RelativeFormatter.defaultStyle())
                titleLbl.text = notification.titlePlain
            }
        }
    }
}
