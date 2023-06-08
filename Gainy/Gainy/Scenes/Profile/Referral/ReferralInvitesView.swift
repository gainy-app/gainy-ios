//
//  ReferralInvitesView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.06.2023.
//

import SwiftUI
import GainyCommon

struct Invite: Identifiable {
    var id = UUID()
    enum InviteState {
        case inProgress, completed
    }
    
    let name: String
    let state: InviteState
}

struct ReferralInvitesView: View {
    
    @Binding var isShowing: Bool
    @State private var isShowingDetail = false
    @Environment(\.presentationMode) var presentationMode
    @Environment (\.modalMode) var modalMode
    
    var invites: [Invite] = [Invite(name: "Garry", state: .inProgress),
                             Invite(name: "Liz", state: .inProgress),
                             Invite(name: "Tom", state: .completed),
                             Invite(name: "Tim", state: .completed),
                             Invite(name: "Carrie", state: .inProgress),
                             Invite(name: "Marcos", state: .completed),]
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack {
                navView
                titleView
                stats
                invitesList
                Spacer()
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        } else {
            VStack {
                navView
                titleView
                stats
                invitesList
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
            Text("Invites History")
                .font(UIFont.proDisplayBold(24).uiFont)
                .foregroundColor(.black)
                .padding(.leading,24)
            Spacer()
        }
        .padding(.top, 32)
    }
    
    var stats: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8) {
                Text("You earned")
                    .font(UIFont.proDisplaySemibold(12).uiFont)
                Text("$\(invites.filter({$0.state == .completed}).count * 25)")
                    .font(UIFont.proDisplaySemibold(24).uiFont)
            }
            .padding(.leading,24)
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text("Success Invites")
                    .font(UIFont.proDisplaySemibold(12).uiFont)
                progressView
            }
            .padding(.trailing, 80)
        }
        .padding(.top, 44)
    }
    
    var progressView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(UIColor(hexString: "#D7DBE7")!.uiColor.opacity(0.3))
                .cornerRadius(16)
            HStack {
                ZStack {
                    Circle()
                        .stroke(
                            UIColor(hexString: "6C5DD3")!.uiColor,
                            lineWidth: 2
                        )
                        .frame(width: 12, height: 12)
                        .opacity(0.3)
                    Circle()
                        .trim(from: 0, to: CGFloat(invites.filter({$0.state == .completed}).count) / CGFloat(invites.count)) // 1
                        .stroke(
                            UIColor(hexString: "6C5DD3")!.uiColor,
                            lineWidth: 2
                        )
                        .rotationEffect(.degrees(-90))
                        .frame(width: 12, height: 12)
                }
                .padding(.leading,6)
                Text("\(Int(CGFloat(invites.filter({$0.state == .completed}).count) / CGFloat(invites.count) * 100.0))%")
                    .padding(.trailing,6)
                    .font(UIFont.proDisplaySemibold(14).uiFont)
                    .minimumScaleFactor(0.3)
            }
        }
        .frame(width: 55, height: 24)
    }
    
    var invitesList: some View {
        ScrollView {
            if #available(iOS 14.0, *) {
                LazyVStack(spacing: 8.0) {
                    ForEach(invites) { invite in
                        NavigationLink(isActive: $isShowingDetail) {
                            RefferalInviteDetailView(isShowing: $isShowingDetail, invite: invite)
                                .environment(\.modalMode, self.modalMode)
                        } label: {
                            InviteRow(invite: invite)
                        }
                    }
                }
                .padding(.bottom, 88)
            }
        }
        .padding(.top, 34)
    }
    
}

struct InviteRow: View {
    
    let invite: Invite
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(invite.name)
                        .font(UIFont.proDisplayBold(16).uiFont)
                        .foregroundColor(.black)
                        //.padding([.top], -8)
                        .padding([.leading], 16)
                    Group {
                            Text(invite.state == .inProgress ? "IN PROGRESS" : "COMPLETED")
                            .font(UIFont.proDisplaySemibold(11).uiFont)
                            .foregroundColor(invite.state == .inProgress ? UIColor(hexString: "1EBF85")!.uiColor : .white)
                                .padding([.top, .bottom], 6)
                                .padding([.leading, .trailing], 8)
                    }
                    .padding([.top], 10)
                    .padding([.leading], 16)
                    .background(
                        Rectangle()
                            .foregroundColor(UIColor(hexString: "1EBF85")!.uiColor)
                            .opacity(invite.state == .inProgress ? 0.15 : 1.0)
                            .cornerRadius(16)
                            .padding([.top], 10)
                            .padding([.leading], 16)
                            
                    )
                }
                Spacer()
                Text("+ $25")
                    .font(UIFont.proDisplaySemibold(16).uiFont)
                    .foregroundColor(UIColor(hexString: "1EBF85")!.uiColor)
                    .padding([.trailing], 24)
                    .opacity(invite.state == .inProgress ? 0.0 : 1.0)
            }
        }
        .frame(height: 88)
        //.frame(maxWidth: .infinity)
        .background(Rectangle().foregroundColor(UIColor(hexString: "#F3F3F3")!.uiColor).cornerRadius(16))
        .padding([.trailing, .leading], 16)
        .cornerRadius(16)
        
    }
}


struct ReferralInvitesView_Previews: PreviewProvider {
    static var previews: some View {
        ReferralInvitesView(isShowing: .constant(true))
    }
}
