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
    @IBOutlet private weak var textLbl: UILabel!
    @IBOutlet private weak var unreadIndicator: CornerView!
    @IBOutlet private weak var unreadView: CornerView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var bottomMargin: NSLayoutConstraint!
    
    var hideText: Bool = false {
        didSet {
            textLbl.numberOfLines = 1
            unreadView.isHidden = hideText
            shadowView.backgroundColor = .white
            bottomMargin.isActive = false
        }
    }
    
    var notification: ServerNotification? {
        didSet {
            if let notification {
                dateLbl.text = notification.date.toRelative(style: RelativeFormatter.defaultStyle())
                textLbl.text = notification.textPlain
                unreadView.isHidden = ServerNotificationsManager.shared.isNotifViewed(notification)
            }
        }
    }
    
    //MARK: - Ovverides
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.width = ceil(UIScreen.main.bounds.width - 16.0 * 2.0)
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}
