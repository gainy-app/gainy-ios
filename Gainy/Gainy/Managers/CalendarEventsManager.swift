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
            DispatchQueue.main.async { [weak self] in
                self?.addEvent(event: event)
            }
        case .notDetermined:
            requestAccess { (accessGranted, error) in
                if accessGranted {
                    DispatchQueue.main.async { [weak self] in
                        self?.addEvent(event: event)
                    }
                }
            }
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
    }
    
    private var storableEventId: String = ""
    private func addEvent(event: RemoteTicker.TickerEvent) {
        let storeEvent: EKEvent = EKEvent(eventStore: eventStore)
        dprint("Adding event")
        dprint("\(event.description ?? "") \(event.am9Time) \(event.pm11Time) \(event.timestamp ?? "")")
        storeEvent.title = "\(event.description ?? "")"
        storeEvent.startDate = event.am9Time
        storeEvent.endDate = event.am9Time
        storeEvent.isAllDay = true
        storeEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        let eventModalVC = EKEventEditViewController()
        eventModalVC.event = storeEvent
        eventModalVC.eventStore = eventStore
        eventModalVC.editViewDelegate = self
        DispatchQueue.main.async {
            if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
                 rootVC.presentedViewController?.present(eventModalVC, animated: true, completion: nil)
            }
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

extension CalendarEventsManager: EKEventEditViewDelegate {
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        if action == .saved {
            scheduledEvents.append(EventMatch.init(remoteEventID: storableEventId, localEventID: controller.event?.eventIdentifier ?? ""))
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
