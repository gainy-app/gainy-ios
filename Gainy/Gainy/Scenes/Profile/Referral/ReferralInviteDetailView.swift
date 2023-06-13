//
//  ReferralInviteDetailView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 07.06.2023.
//

import SwiftUI
import GainyCommon

struct ReferralInviteDetailView: View {
    
    @Binding var isShowing: Bool
    @Environment(\.presentationMode) var presentationMode
    @Environment (\.modalMode) var modalMode
    
    let invite: ReferralInvite
    
    struct InviteActionItem: Identifiable {
        var id = UUID()
        let index: Int
        let title: String
    }
    
    let actionItems: [InviteActionItem] = [
        InviteActionItem.init(index: 1, title: "Sign up using your invite link"),
        InviteActionItem.init(index: 2, title: "Open brokerage account with Gainy"),
        InviteActionItem.init(index: 3, title: "Deposit $500 or more within 4 weeks")
    ]
        
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack(alignment: .leading) {
                navView
                titleView
                faqView
                Spacer()
            }
            .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
        } else {
            VStack(alignment: .leading) {
                navView
                titleView
                faqView
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    var navView: some View {
        HStack {
            Button {
                isShowing.toggle()
            } label: {
                Image("iconArrowLeft")
            }
            Spacer()
            Button {
                modalMode.wrappedValue.toggle()
            } label: {
                Image("iconClose")
            }
        }
        .padding([.leading, .trailing], 20)
        .padding(.top, 20)
    }
    
    var titleView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(invite.name)
                    .font(UIFont.proDisplayBold(24).uiFont)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                Group {
                        Text(invite.isCompleted ? "COMPLETED" : "IN PROGRESS")
                            .font(UIFont.proDisplaySemibold(11).uiFont)
                            .foregroundColor(invite.isCompleted ? .white : UIColor(hexString: "1EBF85")!.uiColor)
                            .padding([.top, .bottom], 6)
                            .padding([.leading, .trailing], 8)
                }
                .padding([.top], 10)
                .background(
                    Rectangle()
                        .foregroundColor(UIColor(hexString: "1EBF85")!.uiColor)
                        .opacity(invite.isCompleted ? 1.0 : 0.15)
                        .cornerRadius(16)
                        .padding([.top], 10)
                        
                )
            }
            .padding(.leading,24)
            Spacer()
            VStack {
                Text("You earned")
                    .font(UIFont.proDisplaySemibold(12).uiFont)
                Text("$5")
                    .font(UIFont.proDisplaySemibold(24).uiFont)
            }
            .background(
                Circle()
                    .foregroundColor(UIColor(hexString: invite.isCompleted ? "DCF64F" : "#F3F3F3")!.uiColor)
                    .frame(width: 80, height: 80)
            )
            .padding(.trailing,32)
            .opacity(invite.isCompleted ? 1.0 : 0.3)
        }
        .padding(.top, 32)
    }
    
    var faqView: some View {
        VStack(alignment: .leading) {
            Text("Required actions")
                .font(UIFont.proDisplaySemibold(16).uiFont)
                .padding([.leading], 24)
            
            ZStack {
                Rectangle()
                    .foregroundColor(UIColor(hexString: "#F3F3F3")!.uiColor)
                    .cornerRadius(16)
                    .padding([.leading, .trailing], 16)
                    faqList
            }
            .padding(.top, 16)
            .frame(height: 72.0 * CGFloat(actionItems.count))
            Spacer()
        }
        .padding(.top, 28)
    }
    
    var faqList: some View {
        VStack {
            ForEach(actionItems) { item in
                HStack {
                    Text("\(item.index)")
                        .foregroundColor(UIColor(hexString: "#F3F3F3")!.uiColor)
                        .font(UIFont.proDisplayBold(13).uiFont)
                        .background(
                            Circle()
                                .foregroundColor(UIColor(hexString: "#0062FF")!.uiColor)
                                .frame(width: 24, height: 24)
                        )
                        .padding([.leading], 16)
                    Text(item.title)
                        .font(UIFont.proDisplayRegular(16).uiFont)
                        .padding([.leading], 16)
                    Spacer()
                }
                .frame(height: 72.0)
                .opacity(invite.state.rawValue < item.index ? 0.15 : 1.0)
            }
        }
        .padding([.leading, .trailing], 32)
    }
}

struct RefferalInviteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReferralInviteDetailView(isShowing: .constant(true), invite: .init(name: "Larry", state: .step2, isCompleted: false))
            ReferralInviteDetailView(isShowing: .constant(true), invite: .init(name: "Kate", state: .step3, isCompleted: true))
        }
    }
}
