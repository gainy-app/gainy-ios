//
//  UserProfileManager+Referral.swift
//  Gainy
//
//  Created by Anton Gubarenko on 09.06.2023.
//

import Foundation
import Foundation
import GainyCommon
import GainyAPI
import GainyDriveWealth


extension UserProfileManager: GainyProfileProtocol {
    
    @discardableResult func getInvitesHistory() async -> [ReferralInvite] {
        guard let profileID = profileID else {
            return [ReferralInvite]()
        }
        return await
        withCheckedContinuation { continuation in
            Network.shared.fetch(query: GetInvitationHistoryQuery(profile_id: profileID)) {result in
                switch result {
                case .success(let graphQLResult):
                    guard let accounts = graphQLResult.data?.invitationHistory.compactMap({
                        var state: ReferralInvite.InviteState = .empty
                        if $0.step1SignedUp ?? false {
                            state = .step1
                        }
                        if $0.step2BrokerateAccountOpen ?? false {
                            state = .step2
                        }
                        if $0.step3DepositedEnough ?? false {
                            state = .step3
                        }
                        return ReferralInvite(name: $0.name ?? "",
                                       state: state,
                                       isCompleted: $0.isComplete ?? false,
                                              invitedProfileId: $0.invitedProfileId ?? 0)
                        
                    }) else {
                        continuation.resume(returning: [ReferralInvite]())
                        return
                    }
                    continuation.resume(returning: accounts)
                case .failure( _):
                    continuation.resume(returning: [ReferralInvite]())
                }
            }
        }
    }
}
