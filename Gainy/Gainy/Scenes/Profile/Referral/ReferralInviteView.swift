//
//  ReferralInviteView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.06.2023.
//

import SwiftUI
import GainyCommon
import ActivityIndicatorView

struct ReferralInviteView: View {
    
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        
        init() {
            impactFeedback.prepare()
        }
    
    struct FAQItem: Identifiable {
        var id = UUID()
        let header: String
        let details: String
    }
    
    let faqItems: [FAQItem] = [
        FAQItem.init(header: "What's Gainy?", details: "Gainy is a thematic investment platform for retail investors. Gainy's Thematic Trading Fractionals (TTFs) are a solution for investors who want flexibility and control but may not have the time or expertise for extensive stock research and portfolio optimization. TTFs  are model portfolios of usually 10-20 hand-picked companies with automatic rebalancing. They provide diversification, reduce single-stock risks, and optimize returns. There are 80 model portfolios starting from popular ones such as Cybersecurity, to new ones like AI and Machine learning, to event-driven like Inflation-Proof or Short Market TTF."),
        FAQItem(header: "Who can I refer to Gainy?", details: "Gainy can find a key to anyone’s heart. Our recommendation engine guides users to investments tailored to their unique needs based on their interests and investment goals. So you are welcome to share with all your friends and family. "),
        FAQItem(header: "What is my reward for inviting a friend?", details: "You will get $25 for each friend. For example, if you invite John and Lucy and both of them buy a stock and/or TTF, then you will get $50 that you will be able to invest in any portfolio on Gainy."),
        FAQItem(header: "How can I use my reward? ", details: "Each friend that has completed required steps* will bring you $25 worth of free TTF, i.e. you can only invest this money in TTF. But you have a variety of TTFs to choose and profit from.  "),
        FAQItem(header: "How many friends can I invite? ", details: "As many as you want. The only limit that you have is that your reward can not exceed $1000 per year. It’s equal to 40 persons."),
        FAQItem(header: "What are the conditions to get a reward?", details: "Need info"),
        FAQItem(header: "When will I get my reward? ", details: "You will receive your reward within a few days after your friend completes all the required steps. You will be notified via email, as well as push-notification. "),
        FAQItem(header: "Will my reward expire? ", details: "Yes, your reward will expire after 60 days. It's important to utilize your reward within this timeframe."),
        FAQItem(header: "Can I withdraw my reward?", details: "The reward has a specific process for utilization. Customers have 60 days to spend their reward on TTF before the reward expires. It's important to note that TTF bought with rewards cannot be sold until 3 trading days after the reward is granted. Additionally, the cash value of the TTF rewards may not be withdrawn for 30 days after the reward is claimed.")
    ]
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingDetail = false
    @State var showModal: Bool = false
    
    @State var invitesList: [ReferralInvite] = []
    
    
    var body: some View {
        NavigationView {
            ZStack {
                    if #available(iOS 14.0, *) {
                        Rectangle().foregroundColor(Color(hexString: "#1B45FB"))                            .ignoresSafeArea()
                        .onChange(of: showModal) {newValue in
                            presentationMode.wrappedValue.dismiss()
                        }
                    } else {
                        Rectangle().foregroundColor(Color(hexString: "#1B45FB"))
                    }
                ScrollView(.vertical) {
                    VStack(spacing: 0) {
                        headerView
                        stepsView
                        faqView
                        if !invitesList.isEmpty {
                            pastLink
                        }
                        shareLink
                        termsView
                    }
                }
                HStack {
                    VStack {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("close_modal_white")
                        }
                        .frame(width: 44, height: 44)
                        .padding([.leading, .top], 16)
                        Spacer()
                    }
                    Spacer()
                }
            }
            .onAppear {
                Task {
                    invitesList = await UserProfileManager.shared.getInvitesHistory()
                }
            }
                
        }
        .navigationViewStyle(.stack)
    }
    
    var headerView: some View {
        Group {
            Text("Invite a friend.\nGet $25 to invest\nin TTF")
                .font(UIFont.proDisplayBold(32).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 56)
            Text("Invite a friend to Gainy and you both get $25 worth of free TTF")
                .font(UIFont.proDisplayMedium(16).uiFont)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing, .top], 24)
            ZStack {
                RadialGradient(gradient: Gradient(colors: [UIColor(hexString: "FC84AA")!.uiColor.opacity(0.8) ,.purple.opacity(0.0)]), center: .center, startRadius: 0, endRadius: 130)
                    .offset(y: 40)
                Image("profile_referral_logo")
                    .resizable()
                    .frame(height: 240)
                .padding([.top], 24)
            }
        }
    }
    
    var stepsView: some View {
        Group {
            Text("Your friends has to")
                .font(UIFont.proDisplaySemibold(24).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 24)
            Text("1")
                .font(UIFont.proDisplayBold(16).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(UIColor(hexString: "#1B45FB")!.uiColor)
                .background(Circle().foregroundColor(UIColor(hexString: "#DCF64F")!.uiColor).frame(width: 40, height: 40))
                .padding(.top, 30)
            Text("Sign up using your invite link")
                .font(UIFont.proDisplayMedium(16).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 30)
            Text("2")
                .font(UIFont.proDisplayBold(16).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(UIColor(hexString: "#1B45FB")!.uiColor)
                .background(Circle().foregroundColor(UIColor(hexString: "#DCF64F")!.uiColor).frame(width: 40, height: 40))
                .padding(.top, 30)
            Text("Open brokerage account with Gainy")
                .font(UIFont.proDisplayMedium(16).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 30)
            Text("3")
                .font(UIFont.proDisplayBold(16).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(UIColor(hexString: "#1B45FB")!.uiColor)
                .background(Circle().foregroundColor(UIColor(hexString: "#DCF64F")!.uiColor).frame(width: 40, height: 40))
                .padding(.top, 30)
            Text("Deposit $500 or more within 4 weeks after brokerage account is opened")
                .font(UIFont.proDisplayMedium(16).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 30)
                .padding([.leading, .trailing], 24)
        }
    }
    
    let colors: [Color] = [.red, .green, .blue]
    
    var faqView: some View {
        Group {
            Text("Frequently asked questions")
                .font(UIFont.proDisplaySemibold(24).uiFont)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.top, 64)
            
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(16)
                    .padding([.leading, .trailing], 16)
                    faqList
            }
            .padding(.top, 28)
        }
    }
    
    var faqList: some View {
        VStack {
            if #available(iOS 14.0, *) {
                ForEach(faqItems) { item in
                    DisclosureGroup(
                        content: {
                            Text(item.details)
                                .font(UIFont.proDisplayRegular(16).uiFont)
                                .foregroundColor(.black)
                        },
                        label: {
                            Text(item.header)
                                .lineLimit(1)
                                .minimumScaleFactor(0.3)
                                .font(UIFont.proDisplaySemibold(16).uiFont)
                                .foregroundColor(.black)
                        }
                    ).frame(minHeight: 16.0 + 24.0 + 16)
                }
            }
        }
        .padding([.leading, .trailing], 32)
        .padding([.top, .bottom], 8)
    }
    
    var pastLink: some View {
        NavigationLink(isActive: $isShowingDetail) {
            ReferralInvitesView(isShowing: $isShowingDetail, invites: $invitesList)
                .environment(\.modalMode, self.$showModal)
        } label: {
            Group {
                HStack {
                    Text("Past invites")
                        .font(UIFont.proDisplaySemibold(16).uiFont)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 16)
                    Spacer()
                    Image(systemName: "chevron.right")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding([.leading, .trailing], 16)
                }
                
            }
            .frame(height: 56.0)
            .background(Color.white)
            .cornerRadius(16)
            .padding([.leading, .trailing], 16)
        }
        .padding([.top,], 40)
    }
    
    @State var loadingLink: Bool = false
    var shareLink: some View {
        ZStack {
            Button {
                guard !loadingLink else {return}
                withAnimation {
                    loadingLink = true
                }
                impactFeedback.impactOccurred()
                SubscriptionManager.shared.generateInviteLink {url in
                    let items = [url]
                    let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                    
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene
                    if #available(iOS 15.0, *) {
                        windowScene?.keyWindow?.rootViewController?.presentedViewController?.present(ac, animated: true, completion: nil)
                    } else {
                        // Fallback on earlier versions
                    }
                    loadingLink = false
                }
            } label: {
                ZStack {
                    Rectangle().foregroundColor(UIColor(hexString: "#DCF64F")!.uiColor)
                    Text("Share my referral link")
                        .font(UIFont.proDisplayMedium(16).uiFont)
                        .foregroundColor(UIColor(hexString: "#1B45FB")!.uiColor)
                }
            }
            .frame(height: 56.0)
            .cornerRadius(16)
            .padding([.top], 52)
            .padding([.leading, .trailing], 32)
            .opacity(loadingLink ? 0.3 : 1)
            ActivityIndicatorView()
                .offset(y: 25)
                .frame(width: 44.0, height: 44)
                .opacity(loadingLink ? 1 : 0.0)
        }
    }
    
    var termsView: some View {
        HStack {
            Text("By applying to this program, you confirm that you have read and agreed to our [Terms & Conditions](https://www.gainy.app/legal-hub/terms-of-service)")
                .lineSpacing(5.0)
                .font(UIFont.proDisplaySemibold(14).uiFont)
                .foregroundColor(.white)
            
        }
        .padding([.top], 18)
        .padding([.leading, .trailing], 32)
        .padding([.bottom], 32)
    }
}

struct ReferralInviteView_Previews: PreviewProvider {
    static var previews: some View {
        ReferralInviteView()
    }
}

