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
    var isInviteAvaialble: Bool = false
    
    /// RefID from deeplink
    var fromId: Int = 0
    
    func redeemInvite() {
        guard isInviteAvaialble else {return}
        if let profileID = UserProfileManager.shared.profileID {
            let query = RedeemInvitationMutation(fromId: fromId, toId: profileID)
            Network.shared.apollo.perform(mutation: query) { result in
                switch result {
                case .success(let data):
                    self.isInviteAvaialble = false
                    break
                case .failure(let error):
                    dprint("Invite error: \(error.localizedDescription)")
                    break
                }
            }
        }
    }
}
