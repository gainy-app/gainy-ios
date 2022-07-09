//
//  MagnifierRect.swift
//  
//
//  Created by Samu András on 2020. 03. 04..
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: String
    @Binding var frame: CGRect
    var textOffset: CGFloat
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        VStack(spacing: 0){
                Text(currentNumber)
                    .font(UIFont.compactRoundedSemibold(10).uiFont)
                    .foregroundColor(UIColor(named: "mainText")?.uiColor)
                    .offset(x: textOffset(textWidth: currentNumber.widthOfString(usingFont: UIFont.compactRoundedSemibold(10))))
            VLine()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                .foregroundColor(Color(hex: "E0E6EA"))
                .frame(width: 1)
        }
        .frame(height: frame.size.height)
        .offset(y: frame.size.height > 200 ? 30.0 : 0.0)
    }
    
    private func textOffset(textWidth: CGFloat) -> CGFloat {
        
        if textOffset < 20 {
            return textWidth / 2.0
        }
        
        if frame.width - textOffset < 20 {
            return -(textWidth / 2.0)
        }
        return 0.0
    }
}
