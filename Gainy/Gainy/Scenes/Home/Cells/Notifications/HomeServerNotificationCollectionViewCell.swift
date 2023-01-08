//
//  HomeServerNotificationCollectionViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 08.01.2023.
//

import UIKit
import GainyCommon

final class HomeServerNotificationCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier: String {
        "HomeServerNotificationCollectionViewCell"
    }
    
    var notification: ServerNotification? {
        didSet {
            if let notification {
                
            }
        }
    }
}
