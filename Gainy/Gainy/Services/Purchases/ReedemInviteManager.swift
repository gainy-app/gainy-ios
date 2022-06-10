//
//  ReedemInviteManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 01.06.2022.
//

import Foundation

final class RedeemInviteManager {
    static let shared = RedeemInviteManager()
    
    /// If we have a valid invite
    @UserDefaultBool(Constants.UserDefaults.isInviteAvaialble)
    var isInviteAvaialble: Bool
    
    /// RefID from deeplink
    @UserDefault(Constants.UserDefaults.fromInviteId)
    var fromId: Int?
    
    func redeemInvite() {
        guard isInviteAvaialble else {return}
        
        dprint("Invite redeem started \(fromId ?? -1)")
        GainyAnalytics.logDevEvent("invite_started", params: ["refID" : fromId ?? -1])
        if let profileID = UserProfileManager.shared.profileID, let fromId = fromId {
            let query = RedeemInvitationMutation(fromId: fromId, toId: profileID)
            Network.shared.apollo.perform(mutation: query) { result in
                switch result {
                case .success(let data):
                    self.isInviteAvaialble = false
                    dprint("Invite redeem received \(fromId)")
                    GainyAnalytics.logDevEvent("invite_done", params: ["refID" : fromId])
                    break
                case .failure(let error):
                    dprint("Invite error: \(error.localizedDescription)")
                    break
                }
            }
        }
    }
}
