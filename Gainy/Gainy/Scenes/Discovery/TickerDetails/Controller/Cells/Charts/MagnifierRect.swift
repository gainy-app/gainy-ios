//
//  MagnifierRect.swift
//  
//
//  Created by Samu András on 2020. 03. 04..
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        VStack(spacing: 0){
            Text(currentNumber)
                .font(UIFont.compactRoundedSemibold(10).uiFont)
                .foregroundColor(UIColor(named: "mainText")?.uiColor)
            VLine()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundColor(Color(hex: "E0E6EA"))
                .frame(width: 1)
        }.frame(height: 180)
    }
}
