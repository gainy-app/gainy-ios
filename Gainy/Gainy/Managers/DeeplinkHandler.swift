//
//  DeeplinkHandler.swift
//  Gainy
//
//  Created by Anton Gubarenko on 13.05.2022.
//

import UIKit
import FirebaseDynamicLinks

class DeeplinkHandler {
    
    static let shared = DeeplinkHandler()
    
    func handleCustomScheme(_ url: URL) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            guard let url = dynamicLink.url,
                  let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return false
            }
            dprint("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
            guard let params = components.queryItems else {
                return false
            }
            
            if let refId = params.first(where: { $0.name == "refID" })?.value {
                dprint("Dynamic link ref found: \(refId)")
                GainyAnalytics.logEvent("invite_received", params: ["refID" : refId])
            } else {
                dprint("No ref found")
            }
        }
        return false
    }
    
    
    func handleActivity(_ userActivity: NSUserActivity) {
        guard let url = userActivity.webpageURL else {return}
        handleUrl(url)
    }
    
    @discardableResult func handleUrl(_ url: URL) -> Bool {
        return DynamicLinks.dynamicLinks().handleUniversalLink(url) { dynamicLink, error in
            guard error == nil,
                  let dynamicLink = dynamicLink,
                  let url = dynamicLink.url,
                  let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true)else {
                return
            }
            dprint("Dynamic link match type: \(dynamicLink.matchType.rawValue)")
            guard let params = components.queryItems else {
                return
            }
            
            if let refId = params.first(where: { $0.name == "refID" })?.value {
                dprint("Dynamic link ref found: \(refId)")
                GainyAnalytics.logEvent("invite_received", params: ["refID" : refId])
                
            } else {
                dprint("No ref found")
            }
        }
    }
}
