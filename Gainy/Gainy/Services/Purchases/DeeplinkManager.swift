//
//  ReedemInviteManager.swift
//  Gainy
//
//  Created by Anton Gubarenko on 01.06.2022.
//

import Foundation
import GainyAPI
import GainyCommon
import Branch

final class DeeplinkManager {
    static let shared = DeeplinkManager()
    
    /// If we have a valid invite
    @UserDefaultBool(Constants.UserDefaults.isInviteAvaialble)
    var isInviteAvaialble: Bool
    
    /// If we have a valid TTF link
    @UserDefaultBool(Constants.UserDefaults.isTTFAvaialble)
    var isTTFAvaialble: Bool
    
    /// If we have a valid Stock link
    @UserDefaultBool(Constants.UserDefaults.isStockAvaialble)
    var isStockAvaialble: Bool
    
    /// RefID from deeplink
    @UserDefault(Constants.UserDefaults.fromInviteId)
    var fromId: Int?
    
    /// TTF ID from deeplink
    @UserDefault(Constants.UserDefaults.toTTFId)
    var ttfId: Int?
    
    /// Stock symbol from deeplink
    @UserDefault(Constants.UserDefaults.toStockSymbol)
    var stockSymbol: String?
    
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
        dprint("TTF view started \(ttfId ?? -1)")
        GainyAnalytics.logEvent("ttf_deeplink_open_delayed", params: ["ttfID" : ttfId ?? -1])
        
        if let ttfId = ttfId {
            NotificationCenter.default.post(name: NotificationManager.requestOpenCollectionWithIdNotification, object: ttfId)
        }
    }
    
    func showDelayedStock() {
        guard isStockAvaialble else {return}
        
        isStockAvaialble = false
        dprint("Stock view started \(stockSymbol ?? "")")
        GainyAnalytics.logEvent("stock_deeplink_open_delayed", params: ["symbol" : stockSymbol ?? ""])
        
        if let stockSymbol = stockSymbol {
            NotificationCenter.default.post(name: NotificationManager.requestOpenStockWithIdNotification, object: stockSymbol)
        }
    }
    
    /// If we have a valid invite
    @UserDefaultBool(Constants.UserDefaults.isTradingAvailable)
    var isTradingAvailable: Bool
    
    func activateDelayedTrading() {
        guard isTradingAvailable else {return}
        guard let profileID = UserProfileManager.shared.profileID else {return}
        UserProfileManager.shared.isTradingActive = true
        UserProfileManager.shared.userRegion = .us
        Network.shared.apollo.perform(mutation: UpdateProfileTradingMutation(profile_id: profileID, is_trading_enabled: true)){ result in
            switch result {
            case .success(let data):
                dprint("Profile Trade Enabled")
                self.isTradingAvailable = false
                break
            case .failure(let error):
                dprint("Profile trade error: \(error.localizedDescription)")
                break
            }
        }
    }
    
    //MARK: - Creation
    
    func getShareLink(title: String, parameterName: String, parameterValue: String) async -> URL? {
        let imageUrl: String = "https://uploads-ssl.webflow.com/611e92d9f135c73f8263bcd2/643fe4f513f10f096b5101c5_Icon%20400px.png"
        
        let buo = BranchUniversalObject.init(canonicalIdentifier: "invite")
        buo.title = title
        buo.contentDescription = "Track all your investment accounts in one place. Follow stock collections from leading analysts. Safe and balanced investing in sectors you believe in with Thematic Trading Fractional."
        buo.imageUrl = imageUrl
        buo.publiclyIndex = true
        buo.locallyIndex = true
        
        let linkProperties: BranchLinkProperties = BranchLinkProperties()
        linkProperties.feature = "card"
        linkProperties.campaign = "share"
        linkProperties.channel = "app"
        linkProperties.addControlParam(parameterName, withValue: parameterValue.uppercased())
        linkProperties.addControlParam("$ios_passive_deepview_", withValue: "false")
        
        return await withCheckedContinuation { continuation in
            buo.getShortUrl(with: linkProperties) { (url, error) in
                if (error == nil) {
                    if let url = url {
                        continuation.resume(returning: URL(string: url))
                    } else {
                        continuation.resume(returning: nil)
                    }
                } else {
                    continuation.resume(returning: nil)
                    dprint(String(format: "Branch error : %@", error! as CVarArg))
                }
            }
        }
    }
}
