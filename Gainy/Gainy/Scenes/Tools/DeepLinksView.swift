//
//  DeepLinksView.swift
//  SwiftUITasks
//
//  Created by Anton Gubarenko on 17.08.2022.
//

import SwiftUI
import Combine

@available(iOS 15.0, *)
struct DeepLinksView: View {
    
    enum LinkType: Int, CaseIterable {
        case invite, ttf, stock
        
        var name: String {
            switch self {
            case .invite:
                return "Invite"
            case .ttf:
                return "TTF"
            case .stock:
                return "Stock"
            }
        }
    }
    
    @StateObject
    private var viewModel = DeepLinksViewModel()
    
    @FocusState
    private var isFocused: Bool
    
    var body: some View {
        ZStack {
        Form {
            Section(header: Text("Link type")) {
                VStack {
                    Picker("Link type", selection: $viewModel.currentLink) {
                        ForEach(LinkType.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            
            Section(header: Text("Parameter for Link")) {
                VStack(alignment: .center, spacing: 8){
                    Text(viewModel.parameterName)
                    TextField(viewModel.parameterPlaceholder, text: $viewModel.parameterValue)
                        .foregroundColor(.secondary)
                        .focused($isFocused)
                        .onChange(of: viewModel.parameterValue) { string in
                                        if string.last == "\n"
                                        {
                                            viewModel.parameterValue.removeLast()
                                            isFocused = false
                                        }
                                    }
                }.padding()
            }
            
            Section(header: Text("Main")) {
                List {
                    VStack(alignment: .center, spacing: 8){
                        Text("Title")
                        TextEditor(text: $viewModel.title)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .focused($isFocused)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                    .padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("Content Description")
                        TextEditor(text: $viewModel.contentDescription)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .focused($isFocused)
                            .frame(maxWidth: .infinity, maxHeight: 400)
                    }.padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("Image URL")
                        TextEditor(text: $viewModel.imageUrl)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .focused($isFocused)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .onChange(of: viewModel.imageUrl) { string in
                                            if string.last == "\n"
                                            {
                                                viewModel.imageUrl.removeLast()
                                                isFocused = false
                                                Task {
                                                    await viewModel.reloadImage()
                                                }
                                            }
                                        }
                        if let image = viewModel.image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 128, height: 128)
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                        } else {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.gray)
                                .frame(width: 128, height: 128)
                        }
                    }.padding()
                    .frame(maxWidth: .infinity)
                    
                }
            }.task {
                await viewModel.reloadImage()
            }
            
            Section(header: Text("Properties")) {
                List {
                    VStack(alignment: .center, spacing: 8){
                        Text("Feature")
                        TextEditor(text: $viewModel.feature)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                    .padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("Campaign")
                        TextEditor(text: $viewModel.campaign)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                    .padding()
                    VStack(alignment: .center, spacing: 8){
                        Text("Channel")
                        TextEditor(text: $viewModel.channel)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                    }
                    .padding()
                }
            }.task {
                await viewModel.reloadImage()
            }
        }.safeAreaInset(edge: .bottom) {
            Spacer().frame(height: 80)
        }
            VStack {
                Spacer()
                Button {
                    Task {
                        if let shareLink = await viewModel.getShareLink() {
                            await MainActor.run {
                                showShareSheet(with: shareLink)
                            }
                        }
                    }
                } label: {
                    Text("Share")
                        .font(Font.headline)
                }
                
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 16).fill(Color.blue))

            }.padding(.leading, 16)
                .padding(.trailing, 16)
        }
        .navigationTitle("DeepLink Creation")
    }
    
    private func showShareSheet(with urlShare: URL) {
            let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.presentedViewController?.present(activityVC, animated: true, completion: nil)
        }
}

@available(iOS 15.0, *)
struct DeepLinksView_Previews: PreviewProvider {
    static var previews: some View {
        DeepLinksView()
    }
}
