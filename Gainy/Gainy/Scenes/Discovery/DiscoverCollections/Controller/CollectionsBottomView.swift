//
//  CollectionsBottomView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import SwiftUI
import SwiftHEXColors

protocol CollectionsBottomViewDelegate: AnyObject {
    func bottomActionPressed(view: CollectionsBottomView)
}

class CollectionsBottomViewModel: ObservableObject {
    //"Add custom\ncollection"
    @Published
    var actionTitle: String = ""
    
    @Published
    var actionIcon: String = ""
    
    init(actionTitle: String, actionIcon: String) {
        self.actionTitle = actionTitle
        self.actionIcon = actionIcon
    }
}

struct CollectionsBottomView: View {
    
    weak var delegate: CollectionsBottomViewDelegate?
    
    private let topPadding: CGFloat = 8.0
    private let buttonWidth: CGFloat = 48.0
    
    @ObservedObject
    var model: CollectionsBottomViewModel
    
    @State
    var showingAlert: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(UIColor(hexString: "0062FF")?.uiColor).cornerRadius(8.0).offset(x: 0, y: topPadding)
            HStack {
                Text(model.actionTitle).font(UIFont.proDisplayBold(20).uiFont).foregroundColor(.white).multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    if delegate == nil {
                        showingAlert.toggle()
                    }
                    delegate?.bottomActionPressed(view: self)
                    GainyAnalytics.logEvent("add_custom_collection_pressed")
                }, label: {
                    ZStack {
                        Rectangle().foregroundColor(UIColor(hexString: "0062FF")?.uiColor).cornerRadius(20.0)
                        Image(model.actionIcon).resizable().foregroundColor(.white).frame(width: 20, height: 20)
                    }.frame(width: buttonWidth, height: buttonWidth, alignment: .center).shadow(radius: 16)
                })
            }.padding(.leading, 32).padding(.trailing, 32).offset(x: 0, y: topPadding / 2.0).frame(maxWidth: .infinity, maxHeight: .infinity)
        }.background(Color.clear).clipped().alert(isPresented: $showingAlert) {
            Alert(title: Text("Early access"),
                  message: Text("Will be done later"),
                                dismissButton: .default(Text("OK")))
        }
    }
}

struct CollectionsBottomView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionsBottomView(model: CollectionsBottomViewModel.init(actionTitle: "Add custom\ncollection", actionIcon: "plus_icon")).frame(width: 375, height: 96)
    }
}
