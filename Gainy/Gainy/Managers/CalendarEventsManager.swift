//
//  CalendarEventsManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 11.10.2021.
//

import UIKit
import EventKit
import EventKitUI

struct EventMatch: Codable {
    let remoteEventID: String
    let localEventID: String
}

class CalendarEventsManager: NSObject {
    
    static let shared = CalendarEventsManager()
    
    @UserDefaultArray(key: Constants.UserDefaults.scheduledCalendarEvents)
    var scheduledEvents: [EventMatch]
    
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
        let storeEvent: EKEvent = EKEvent(eventStore: eventStore)              
        storeEvent.title = "\(event.description ?? "")"
        storeEvent.startDate = event.am9Time
        storeEvent.endDate = event.pm11Time
        storeEvent.isAllDay = true
        storeEvent.calendar = eventStore.defaultCalendarForNewEvents
              do {
                  try eventStore.save(storeEvent, span: .thisEvent)
                  scheduledEvents.append(EventMatch.init(remoteEventID: event.notifID, localEventID: storeEvent.eventIdentifier))
              } catch let error as NSError {
                  print("failed to save event with error : \(error)")
              }
    }
    
    func deleteEvent(event: RemoteTicker.TickerEvent) {
        
        if let eventStored = scheduledEvents.first(where: {$0.remoteEventID == event.notifID}) {
            if let eventLocal = eventStore.event(withIdentifier: eventStored.localEventID) {
                do {
                    try eventStore.remove(eventLocal, span: .thisEvent)
                    scheduledEvents.removeAll(where: {$0.remoteEventID == event.notifID})
                } catch let error as NSError {
                    print("failed to save event with error : \(error)")
                }
            }
        }        
    }
    
    func isScheduled(event eventToAdd: RemoteTicker.TickerEvent) -> Bool {
        if let event = scheduledEvents.first(where: {$0.remoteEventID == eventToAdd.notifID}) {
            return eventStore.event(withIdentifier: event.localEventID) != nil
        } else {
            return false
        }
    }
}
