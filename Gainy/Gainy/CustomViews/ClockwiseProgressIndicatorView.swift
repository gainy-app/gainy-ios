//
//  ClockwiseProgressIndicatorView.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/30/21.
//

import SwiftUI

class ClockwiseProgressIndicatorViewProgress: ObservableObject {
    @Published var progress = Float(0.25)
    
    init(progress: Float) {
        
        self.progress = progress
    }
}

struct ClockwiseProgressIndicatorView: View {
    
    @EnvironmentObject var progressObject: ClockwiseProgressIndicatorViewProgress
    
    var body: some View {
        ZStack {
            ForEach(0..<12) { tick in
                VStack {
                    Circle()
                        .fill(Color.init(UIColor(red: 0.6352941176470588, green: 0.6431372549019608, blue: 0.6549019607843137, alpha: 1.0)))
                        .frame(width: 3, height: 3)
                    Spacer()
                }
                .rotationEffect(Angle.degrees(Double(tick) / 12 * 360))
            }
            let binding = Binding<Float>(get: { () -> Float in
                 self.progressObject.progress
             }) { (value) in
                 self.progressObject.progress = value
            }
            
            let degreePercent = self.progressObject.progress * 360
            ForEach(0..<180) { tick in
                VStack {
                    Circle()
                        .fill(Color.black)
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
