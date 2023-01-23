//
//  ServerNotificationsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.01.2023.
//

import GainyCommon
import GainyAPI
import Combine

extension GetNotificationsQuery.Data.Notification: ServerNotification {
    public var date: Date {
        AppDateFormatter.shared.date(from: createdAt ?? "", dateFormat: .yyyyMMddHHmmssSSSSSSZ) ?? Date()
    }
    
    public var titlePlain: String {
        (title?["en"] as? String) ?? "No title available"
    }
    
    public var textPlain: String {
        (text?["en"] as? String) ?? ""
    }
    
    public func height(for width: CGFloat) -> CGFloat {
        var height: CGFloat = 48.0
        
        if !titlePlain.isEmpty {
            height += titlePlain.heightWithConstrainedWidth(width: width, font: .proDisplayBold(16))
        }
        if !textPlain.isEmpty {
            height += 8.0 + textPlain.heightWithConstrainedWidth(width: width, font: .proDisplayMedium(16)) + 16.0
        }
        return height + 8.0
    }
}

extension GetNotificationsQuery.Data.Notification {
    static func demoNotif() -> Self {
        .init(createdAt: "2023-01-07T22:13:59+0000", data: ["title": "Demo"], isViewed: false, notificationUuid: UUID().uuidString, profileId: UserProfileManager.shared.profileID, text: ["title": "Demo"], title: ["title": "Demo long text"])
    }
}

final class ServerNotificationsManager: ServerNotificationsProtocol {
    
    static let shared = ServerNotificationsManager()
    
    var serverNotifications: [ServerNotification] = []
    
    //MARK: - Unread count handling
    
    /// Total unread notifs count
    var unreadCount: Int {
        unreadCountSubject.value
    }
    
    let unreadCountSubject: CurrentValueSubject<Int, Never> = CurrentValueSubject<Int, Never>.init(0)
    
    /// Unread count publisher for unread count events
    var unreadCountPublisher: AnyPublisher<Int, Never> {
        unreadCountSubject.share().eraseToAnyPublisher()
    }
    
    let notifsReadSubject: PassthroughSubject<[String], Never> = PassthroughSubject.init()
    
    var notifsReadPublisher: AnyPublisher<[String], Never> {
        notifsReadSubject.share().eraseToAnyPublisher()
    }
    
    //MARK: - Remote calls
    func getNotifications() async -> [ServerNotification] {
        typealias innerType = GetNotificationsQuery.Data.Notification
        guard let profileID =  UserProfileManager.shared.profileID else {
            return [innerType]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetNotificationsQuery(profileId: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let list = graphQLResult.data?.notifications else {
                        continuation.resume(returning: [innerType]())
                        return
                    }
                    self.serverNotifications = list
                    continuation.resume(returning: list)
                case .failure( _):
                    continuation.resume(returning: [innerType]())
                }
            }
        }
    }
    
    /// Locally viewed notifications
    private(set) var viewedNotifs: [String] = []
    
    /// Check is not viewed
    /// - Parameter notif: notification to check
    /// - Returns: true or false based on state and local view list
    func isNotifViewed(_ notif: ServerNotification) -> Bool {
        if let isViewed = notif.isViewed {
            if isViewed {
                return true
            } else {
                return viewedNotifs.contains(notif.notificationUuid ?? "")
            }
        }
        return false
    }
    
    /// Mark notification as viewed
    /// - Parameter notifications: notifs to read (will take only those who are not viewed)
    /// - Returns: read notifs count
    func viewNotifications(notifications: [ServerNotification]) async -> Int {
        typealias NotifsInput = app_profile_notification_viewed_insert_input
        guard let profileID =  UserProfileManager.shared.profileID else {
            return 0
        }
        
        if Configuration().environment == .production {
            
            let inputs = notifications.filter({$0.isViewed ?? false}).compactMap({NotifsInput.init(notificationUuid: $0.notificationUuid, profileId: profileID)})
            
            return await
            withCheckedContinuation { continuation in
                Network.shared.perform(mutation: ViewNotificationsMutation.init(notifications: inputs)) {result in
                    switch result {
                    case .success(let graphQLResult):
                        guard let count = graphQLResult.data?.insertAppProfileNotificationViewed?.affectedRows else {
                            continuation.resume(returning: 0)
                            return
                        }
                        let viewedList = notifications.compactMap({$0.notificationUuid})
                        self.viewedNotifs.append(contentsOf: viewedList)
                        self.notifsReadSubject.send(viewedList)
                        self.unreadCountSubject.send(max(0, self.unreadCountSubject.value - count))
                        continuation.resume(returning: count)
                    case .failure( _):
                        continuation.resume(returning: 0)
                    }
                }
            }
        } else {
            let viewedList = notifications.compactMap({$0.notificationUuid})
            self.viewedNotifs.append(contentsOf: viewedList)
            self.notifsReadSubject.send(viewedList)
            self.unreadCountSubject.send(max(0, self.unreadCountSubject.value - notifications.count))
            return notifications.count
        }
    }
    
    /// Get total unread count
    /// - Returns: count
    @discardableResult func getUnreadCount() async -> Int {
        guard let profileID =  UserProfileManager.shared.profileID else {
            return 0
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetUnreadNotificationsCountQuery(profileId: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let count = graphQLResult.data?.profileFlags.first?.notViewedNotificationsCount else {
                        continuation.resume(returning: 0)
                        return
                    }
                    self.unreadCountSubject.send(count)
                    continuation.resume(returning: count)
                case .failure( _):
                    continuation.resume(returning: 0)
                }
            }
        }
    }
    
    
}
