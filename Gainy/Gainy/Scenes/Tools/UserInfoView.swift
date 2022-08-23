//
//  UserInfoView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2022.
//

import SwiftUI
import Firebase
@_exported import BugfenderSDK

struct UserInfoView: View {
    var body: some View {
        Form {
            HStack(alignment: .center) {
                Spacer()
                Text("Values are tappable")
                Spacer()
            }
            Section(header: Text("User Info")) {
                List {
                    VStack(alignment: .center, spacing: 8){
                        Text("Name")
                        Text(UserProfileManager.shared.fullName)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = UserProfileManager.shared.fullName
                                    }) {
                                        Text("Copy")
                                        Image(systemName: "doc.on.doc")
                                    }
                                 }
                    }
                    .padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("E-mail")
                        Text(UserProfileManager.shared.email ?? "")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = UserProfileManager.shared.email ?? ""
                                    }) {
                                        Text("Copy")
                                        Image(systemName: "doc.on.doc")
                                    }
                                 }
                    }
                    .padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("Profile ID")
                        Text("\(UserProfileManager.shared.profileID ?? 0)")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = "\(UserProfileManager.shared.profileID ?? 0)"
                                    }) {
                                        Text("Copy")
                                        Image(systemName: "doc.on.doc")
                                    }
                                 }
                    }
                    .padding()
                }
            }
            Section(header: Text("Dev Info")) {
                List {
                    VStack(alignment: .center, spacing: 8){
                        Text("Firebase ID")
                        Text(Auth.auth().currentUser?.uid ?? "")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = Auth.auth().currentUser?.uid ?? ""
                                    }) {
                                        Text("Copy")
                                        Image(systemName: "doc.on.doc")
                                    }
                                 }
                    }
                    .padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("BF link")
                        Text("\(Bugfender.deviceIdentifierUrl()?.absoluteString ?? "")")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .contextMenu {
                                    Button(action: {
                                        UIPasteboard.general.string = "\(Bugfender.deviceIdentifierUrl()?.absoluteString ?? "")"
                                    }) {
                                        Text("Copy")
                                        Image(systemName: "doc.on.doc")
                                    }
                                 }
                    }
                    .padding()
                }
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}
