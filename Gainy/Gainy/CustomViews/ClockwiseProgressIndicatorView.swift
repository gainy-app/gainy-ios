//
//  ClockwiseProgressIndicatorView.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/30/21.
//

import SwiftUI

class ClockwiseProgressIndicatorViewObject: ObservableObject {
    
    @Published
    var progress: Float = 0.25
    
    @Published
    var color: UIColor = UIColor.black
    
    init(progress: Float, color: UIColor) {
        
        self.progress = progress
        self.color = color
    }
}

struct ClockwiseProgressIndicatorView: View {
    
    @ObservedObject
    var progressObject: ClockwiseProgressIndicatorViewObject
    
    var body: some View {
        ZStack {
            ForEach(0..<12) { tick in
                VStack {
                    Circle()
                        .fill(Color.init(self.progressObject.color.withAlphaComponent(0.3)))
                        .frame(width: 3, height: 3)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick) / 12 * 360))
            }
            
            let degreePercent = self.progressObject.progress * 360
            ForEach(0..<180) { tick in
                VStack {
                    Circle()
                        .fill(Color.init(self.progressObject.color))
                        .frame(width: 3, height: 3)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick) / Double(180) * Double(degreePercent)))
                .animation(.easeInOut)
            }
        }
        .frame(width: 35, height: 35)
        .fixedSize(horizontal: true, vertical: true)
    }
}

#if DEBUG
//struct Clock_Previews: PreviewProvider {
//    static var previews: some View {
//        ClockwiseProgressIndicatorView()
//    }
//}
#endif
