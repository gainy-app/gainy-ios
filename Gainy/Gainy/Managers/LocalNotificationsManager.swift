//
//  LocalNotificationsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.10.2021.
//

import UIKit
import UserNotifications

extension RemoteTicker.TickerEvent {
    var notifID: String {
        "\(self.symbol ?? "")\(self.type ?? "")\((self.description ?? "").djb2hash)"
    }
}

final class LocalNotificationsManager {
    
    static let shared = LocalNotificationsManager()
    
    //MARK:- Stored IDS
    
    @UserDefaultArray(key: Constants.UserDefaults.scheduledSymbolEvents)
    private(set) var scheduledSymbolEvents: [String]
    
    private let threadID = "GainyThreadGroup"
    
    func scheduleSymbolEvent(_ event: RemoteTicker.TickerEvent) {
        //Rescheduling
        if scheduledSymbolEvents.contains(event.notifID) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.notifID])
            scheduledSymbolEvents.removeAll(where: {$0 == event.notifID})
        }
        createBasePushRequest(uuidString: event.notifID, title: event.symbol ?? "", body: event.description ?? "", date: Date().addingTimeInterval(60), repeats: false, threadIdentifier: threadID)
    }
    
    fileprivate func createBasePushRequest(uuidString: String, title: String, body: String, date: Date, repeats: Bool, threadIdentifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.threadIdentifier = threadIdentifier
        content.summaryArgument = "Gainy"
        
        
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date), repeats: repeats)
        
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) {[weak self] (error) in
            if error == nil {
                print("\nAdded \(title) - \(date)\n")
                self?.scheduledSymbolEvents.append(uuidString)
            }
        }
    }
    
    
    func removeSchedule(_ event: RemoteTicker.TickerEvent) {
        if scheduledSymbolEvents.contains(event.notifID) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [event.notifID])
            scheduledSymbolEvents.removeAll(where: {$0 == event.notifID})
        }
    }
    
    func isScheduled(_ event: RemoteTicker.TickerEvent) -> Bool {
        scheduledSymbolEvents.contains(event.notifID)
    }
    
}
