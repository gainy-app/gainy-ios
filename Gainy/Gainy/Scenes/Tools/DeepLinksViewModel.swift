//
//  DeepLinksViewModel.swift
//  SwiftUITasks
//
//  Created by Anton Gubarenko on 17.08.2022.
//

import SwiftUI
import Combine

//let buo = BranchUniversalObject.init(canonicalIdentifier: "invite")
//buo.title = "\(UserProfileManager.shared.fullName) invited you to Gainy Premium"
//buo.contentDescription = "Track all your investment accounts in one place. Follow stock collections from leading analysts. Safe and balanced investing in sectors you believe in with Thematic Trading Fractional."
//buo.imageUrl = "https://uceb1323dc638e314608dee3acec.previews.dropboxusercontent.com/p/thumb/ABgYr7N88APNt8iacn0Ki8PMR6AiXdc1jr5wm31Z2qNQ_5kF5oQjGWu7u6p-3T7tPajrMrVRldMPc5A8s5jFO9E8Xq4t83_E8j1IkowAC0nzN5on6eqlj4RpLqhtHxIQmx3kz_opmyNTy-LCw16WhMZR_tZjN3lIZbbIxHoNhYrN8TACOj5Z9KYAHCG9Aycc8JMkUbx3R2c3warCGI1K8v_AegNY9r9f6ma8xJr02pNghC3OllugVJ-vQ_UuGB2sVbvZUirShEFBzIfWTPaWwfNPHB5l3FnI3VNyqJQeO6BuQvh4mSdE2C_i47RCSgtkVf8axwMAJGKCAO-hx2XqgHwVqjzfToA0wE7yymn3YAO4YL53jstWZzI31y3sXiTG8dQ0888IMczRUjgX1yyjhFD4AXjXJpgmmYf869qjvmfcjA/p.jpeg"
//buo.publiclyIndex = true
//buo.locallyIndex = true
//
//let linkProperties: BranchLinkProperties = BranchLinkProperties()
//linkProperties.feature = "Purchase_swipe"
//linkProperties.campaign = "Referral_Invite"
//linkProperties.channel = "Share"
//linkProperties.addControlParam("refId", withValue: "\(UserProfileManager.shared.profileID ?? 0)")
//linkProperties.addControlParam("$ios_passive_deepview_", withValue: "false")

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
                parameterName = "Stock Symbol"
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
    var imageUrl: String = "https://www.hackingwithswift.com/img/paul-2.png"
    
    
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
}
