//
//  ServerNotificationsProtocol.swift
//  GainyCommon
//
//  Created by Anton Gubarenko on 06.01.2023.
//

import Foundation

/// Base Server Notification
public protocol ServerNotification {
    var createdAt: String? {get set}
    var isViewed: Bool? {get set}
    var notificationUuid: String? {get set}
    var text: [String: Any]? {get set}
    var title: [String: Any]? {get set}
    var date: Date {get}
    var titlePlain: String {get}
    var textPlain: String {get}
    func height(for width: CGFloat) -> CGFloat
}

/// Base notifications mark input
public protocol ViewServerNotificationInput {
    var notificationUuid: Int {get set}
    var profileId: Int {get set}
}

/// Server Notifications Base
public protocol ServerNotificationsProtocol: AnyObject {
    
    /// Get server notifications
    /// - Returns: array of ServerNotification
    func getNotifications() async -> [ServerNotification]
    
    /// Mark notifications as read
    /// - Parameter notifications: notifs to mark
    /// - Returns: Read count
    func viewNotifications(notifications: [ServerNotification]) async -> Int
    
    /// Get total unread notifications count
    /// - Returns: unread count
    func getUnreadCount() async -> Int
}
