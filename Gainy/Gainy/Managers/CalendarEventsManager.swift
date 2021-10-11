//
//  CalendarEventsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.10.2021.
//

import UIKit
import EventKit
import EventKitUI


class CalendarEventsManager: NSObject {
    
    var eventStore: EKEventStore!
    
    override init() {
        eventStore = EKEventStore()
    }
    
    private func requestAccess(completion: @escaping EKEventStoreRequestAccessCompletionHandler) {
        eventStore.requestAccess(to: EKEntityType.event) { (accessGranted, error) in
            completion(accessGranted, error)
        }
    }
    
    private func getAuthorizationStatus() -> EKAuthorizationStatus {
        return EKEventStore.authorizationStatus(for: EKEntityType.event)
    }
    
    func addEventToCalendar(event: RemoteTicker.TickerEvent) {
        let authStatus = getAuthorizationStatus()
        switch authStatus {
        case .authorized:
            self.addEvent(event: event)
        case .notDetermined:
            requestAccess { (accessGranted, error) in
                if accessGranted {
                    self.addEvent(event: event)
                }
            }
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
    }
    
    private func addEvent(event: RemoteTicker.TickerEvent) {
    }
    
    func deleteEvent(event: RemoteTicker.TickerEvent) {
        if let event = eventStore.event(withIdentifier: event.notifID) {
            do {
                try eventStore.remove(event, span: .thisEvent)
            } catch let error as NSError {
                print("failed to save event with error : \(error)")
            }
        }
    }
    
    private func eventAlreadyExists(event eventToAdd: RemoteTicker.TickerEvent) -> Bool {
        return eventStore.event(withIdentifier: eventToAdd.notifID) != nil
    }
}
