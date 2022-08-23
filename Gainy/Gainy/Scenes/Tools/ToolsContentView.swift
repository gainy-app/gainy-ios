//
//  ContentView.swift
//  SwiftUITasks
//
//  Created by Anton Gubarenko on 17.08.2022.
//

import SwiftUI

@available(iOS 15.0, *)
struct ToolsContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Info")) {
                    NavigationLink {
                        UserInfoView()
                    } label: {
                        Text("Profile Info")
                    }
                }
                Section(header: Text("Creator")) {
                    NavigationLink {
                        DeepLinksView()
                    } label: {
                        Text("DeepLinks by Branch.io")
                    }
                }
            }.navigationTitle("Gainy Tools")
            
        }
    }
}

@available(iOS 15.0, *)
struct ToolsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsContentView()
    }
}
