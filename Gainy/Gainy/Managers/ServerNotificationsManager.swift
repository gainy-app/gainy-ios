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
}

extension GetNotificationsQuery.Data.Notification {
    static func demoNotif() -> Self {
        .init(createdAt: "2023-01-07T22:13:59+0000", data: ["title": "Demo"], isViewed: false, notificationUuid: UUID().uuidString, profileId: UserProfileManager.shared.profileID, text: ["title": "Demo"], title: ["title": "Demo long text"])
    }
    
    var date: Date {
        AppDateFormatter.shared.date(from: createdAt ?? "", dateFormat: .yyyyMMddHHmmssSSSSSSZ) ?? Date()
    }
}

final class ServerNotificationsManager: ServerNotificationsProtocol {
    
    static let shared = ServerNotificationsManager()
    
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
                        continuation.resume(returning: (0...10).compactMap({_ in innerType.demoNotif()}))
                        return
                    }
                    continuation.resume(returning: list)
                case .failure( _):
                    continuation.resume(returning: [innerType]())
                }
            }
        }
    }
    
    /// Mark notification as viewed
    /// - Parameter notifications: notifs to read (will take only those who are not viewed)
    /// - Returns: read notifs count
    func viewNotifications(notifications: [ServerNotification]) async -> Int {
        typealias NotifsInput = app_profile_notification_viewed_insert_input
        guard let profileID =  UserProfileManager.shared.profileID else {
            return 0
        }
        
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
                    self.unreadCountSubject.send(max(0, self.unreadCountSubject.value - count))
                    continuation.resume(returning: count)
                case .failure( _):
                    continuation.resume(returning: 0)
                }
            }
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
