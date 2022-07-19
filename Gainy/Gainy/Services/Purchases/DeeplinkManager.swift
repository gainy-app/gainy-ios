//
//  ReedemInviteManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 01.06.2022.
//

import Foundation

final class DeeplinkManager {
    static let shared = DeeplinkManager()
    
    /// If we have a valid invite
    @UserDefaultBool(Constants.UserDefaults.isInviteAvaialble)
    var isInviteAvaialble: Bool
    
    /// If we have a valid TTF link
    @UserDefaultBool(Constants.UserDefaults.isTTFAvaialble)
    var isTTFAvaialble: Bool
    
    /// RefID from deeplink
    @UserDefault(Constants.UserDefaults.fromInviteId)
    var fromId: Int?
    
    /// TTF ID from deeplink
    @UserDefault(Constants.UserDefaults.toTTFId)
    var ttfId: Int?
    
    func redeemInvite() {
        guard isInviteAvaialble else {return}
        
        dprint("Invite redeem started \(fromId ?? -1)")
        GainyAnalytics.logEvent("invite_started", params: ["refID" : fromId ?? -1])
        if let profileID = UserProfileManager.shared.profileID, let fromId = fromId {
            let query = RedeemInvitationMutation(fromId: fromId, toId: profileID)
            Network.shared.apollo.perform(mutation: query) { result in
                switch result {
                case .success(let data):
                    self.isInviteAvaialble = false
                    dprint("Invite redeem received \(fromId)")
                    GainyAnalytics.logEvent("invite_done", params: ["refID" : fromId])
                    UserProfileManager.shared.fetchProfile { _ in
                    }
                    break
                case .failure(let error):
                    dprint("Invite error: \(error.localizedDescription)")
                    break
                }
            }
        }
    }
    
    func showDelayedTTF() {
        guard isTTFAvaialble else {return}
        
        isTTFAvaialble = false
        dprint("Invite redeem started \(ttfId ?? -1)")
        GainyAnalytics.logEvent("ttf_deeplink_open_delayed", params: ["ttfID" : ttfId ?? -1])
        
        if let ttfId = ttfId {
        NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: ttfId)
        }
    }
}