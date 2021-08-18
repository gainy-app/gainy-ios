//
//  CollectionsBottomView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import SwiftUI
import SwiftHEXColors

struct CollectionsBottomView: View {
    
    private let topPadding: CGFloat = 8.0
    private let buttonWidth: CGFloat = 48.0
    
    @State
    var showingAlert: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(UIColor(hexString: "0062FF")?.uiColor).cornerRadius(8.0).offset(x: 0, y: topPadding)
            HStack {
                Text("Add custom\ncollection").font(UIFont.proDisplayBold(20).uiFont).foregroundColor(.white).multilineTextAlignment(.leading)
                Spacer()
                Button(action: {
                    showingAlert.toggle()
                }, label: {
                    ZStack {
                        Rectangle().foregroundColor(UIColor(hexString: "0062FF")?.uiColor).cornerRadius(20.0)
                        Image("plus_icon").resizable().foregroundColor(.white).frame(width: 20, height: 20)
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
        CollectionsBottomView().frame(width: 375, height: 96)
    }
}
