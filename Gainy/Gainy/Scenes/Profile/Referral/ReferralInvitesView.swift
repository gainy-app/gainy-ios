//
//  ReferralInvitesView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 06.06.2023.
//

import SwiftUI

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
   @Environment(\.presentationMode) var presentationMode
    
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
               presentationMode.wrappedValue.dismiss()
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
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
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
                Text("$\(invites.filter({$0.state == .completed}).count * 25)")
            }
            .padding(.leading,24)
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                Text("Success Invites")
                progressView
            }
            .padding(.trailing, 80)
        }
        .padding(.top, 44)
    }
    
    var progressView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue.opacity(0.3))
                .cornerRadius(16)
            HStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 2)
                        .frame(width: 12, height: 12)
                    Circle()
                        .trim(from: 0, to: CGFloat(invites.filter({$0.state == .completed}).count) / CGFloat(invites.count)) // 1
                        .stroke(
                            Color.pink,
                            lineWidth: 2
                        )
                        .rotationEffect(.degrees(-90))
                    
                        .frame(width: 12, height: 12)
                }
                .padding(.leading,6)
                Text("\(Int(CGFloat(invites.filter({$0.state == .completed}).count) / CGFloat(invites.count) * 100.0))%")
            }
        }
        .frame(width: 55, height: 24)
    }
    
    var invitesList: some View {
        ScrollView {
            if #available(iOS 14.0, *) {
                LazyVStack(spacing: 8.0) {
                    ForEach(invites) { invite in
                        InviteRow(invite: invite)
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
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding([.top], -8)
                        .padding([.leading], 16)
                    Group {
                        if invite.state == .inProgress {
                            Text("IN PROGRESS")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding([.top, .bottom], 6)
                                .padding([.leading, .trailing], 8)
                        } else {
                            Text("COMPLETED")
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                                .padding([.top, .bottom], 6)
                                .padding([.leading, .trailing], 8)
                            
                        }
                    }
                    .padding([.top], 10)
                    .padding([.leading], 16)
                    .background(
                        Rectangle()
                            .cornerRadius(16)
                            .padding([.top], 10)
                            .padding([.leading], 16)
                        
                    )
                }
                Spacer()
                Text("+ $25")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding([.trailing], 24)
                    .opacity(invite.state == .inProgress ? 0.0 : 1.0)
            }
        }
        .frame(height: 88)
        //.frame(maxWidth: .infinity)
        .background(Rectangle().foregroundColor(.green).cornerRadius(16))
        .padding([.trailing, .leading], 16)
        .cornerRadius(16)
        
    }
}


struct ReferralInvitesView_Previews: PreviewProvider {
    static var previews: some View {
        ReferralInvitesView(isShowing: .constant(true))
    }
}
