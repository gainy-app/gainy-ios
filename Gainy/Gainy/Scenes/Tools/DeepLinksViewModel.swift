//
//  DeepLinksViewModel.swift
//  SwiftUITasks
//
//  Created by Anton Gubarenko on 17.08.2022.
//

import SwiftUI
import Combine
import Branch

@available(iOS 15.0, *)
class DeepLinksViewModel: ObservableObject {
    
    //Main
    
    var currentLink: DeepLinksView.LinkType = .invite {
        didSet {
            switch currentLink {
            case .invite:
                title = " invited you to Gainy Premium"
                feature = "Purchase_swipe"
                campaign = "Referral_Invite"
                parameterName = "refId"
                parameterValue = ""
                parameterPlaceholder = "Profile ID"
                break
            case .ttf:
                title = "TTF in Gainy"
                feature = "Purchase_swipe"
                campaign = "Referral_Invite"
                parameterName = "ttfId"
                parameterValue = ""
                parameterPlaceholder = "TTF ID"
                break
            case .stock:
                title = "Stock in Gainy"
                feature = "Purchase_swipe"
                campaign = "Referral_Invite"
                parameterName = "stockSymbol"
                parameterValue = ""
                parameterPlaceholder = "Stock Symbol"
                break
            }
        }
    }
    
    @Published
    var title: String = " invited you to Gainy Premium"
    
    @Published
    var contentDescription: String = "Track all your investment accounts in one place. Follow stock collections from leading analysts. Safe and balanced investing in sectors you believe in with Thematic Trading Fractional."
    
    
    @Published
    var imageUrl: String = "https://scontent.fhel3-1.fna.fbcdn.net/v/t39.30808-6/242423507_224879329681015_8261017465975889589_n.png?_nc_cat=110&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=Mk3bLigvc4YAX-YgC6n&_nc_ht=scontent.fhel3-1.fna&oh=00_AT8PyqGKa3H_npwyNJhrCRBXQgCxenJ7fsWCpCr9W7NDNw&oe=6302F178"
    
    
    @Published
    var image: UIImage?
    
    //Link Properties
    @Published
    var feature: String = "Purchase_swipe"
    
    @Published
    var campaign: String = "Referral_Invite"
    
    @Published
    var channel: String = "Share"
    
    func reloadImage() async {
        let loaded = await loadImage(from: URL(string: imageUrl)!)
        await MainActor.run {
            image = loaded
        }
    }
    
    private func loadImage(from url: URL) async -> UIImage? {
        let request = URLRequest.init(url:url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                return nil }
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    //Parameters
    @Published
    var parameterName: String = "refId"
    
    @Published
    var parameterValue: String = ""
    
    @Published
    var parameterPlaceholder: String = "profile_id"
    
    func getShareLink() async -> URL? {
        let buo = BranchUniversalObject.init(canonicalIdentifier: "invite")
        buo.title = self.title
        buo.contentDescription = self.contentDescription
        buo.imageUrl = self.imageUrl
        buo.publiclyIndex = true
        buo.locallyIndex = true
        
        let linkProperties: BranchLinkProperties = BranchLinkProperties()
        linkProperties.feature = self.feature
        linkProperties.campaign = self.campaign
        linkProperties.channel = self.channel
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
