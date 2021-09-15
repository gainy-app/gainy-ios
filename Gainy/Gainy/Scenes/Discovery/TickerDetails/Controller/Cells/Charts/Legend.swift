//
//  Legend.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct Legend: View {
    @ObservedObject var data: ChartData
    @Binding var frame: CGRect
    @Binding var hideHorizontalLines: Bool
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var specifier: String = "%.2f"
    var bigSpecifier: String = "%.0f"
    let padding:CGFloat = 3
    
    var stepWidth: CGFloat {
        if data.points.count < 2 {
            return 0
        }
        return frame.size.width / CGFloat(data.points.count-1)
    }
    var stepHeight: CGFloat {
        let points = self.data.onlyPoints()
        if let min = points.min(), let max = points.max(), min != max {
            if (min < 0){
                return (frame.size.height-padding) / CGFloat(max - min)
            }else{
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        let points = self.data.onlyPoints()
        return CGFloat(points.min() ?? 0)
    }
    
    var max: CGFloat {
        let points = self.data.onlyPoints()
        return CGFloat(points.max() ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach((0...1), id: \.self) { height in
                HStack(alignment: .center){
                        Text("$\(self.getYLegendSafe(height: height), specifier: (max - min) > 1.0 ? bigSpecifier : specifier)")
                            .frame(maxHeight: 12)
                            .minimumScaleFactor(0.1)
                            .offset(x: getXposition(height: height), y: self.getYposition(height: height) + (height == 0 ? 7 : -3) )
                            .foregroundColor(UIColor(hexString: "B1BDC8")!.uiColor)
                            .font(UIFont.compactRoundedSemibold(10).uiFont)
                    self.line(atHeight: self.getYLegendSafe(height: height), width: self.frame.width)
                        .stroke(Color.clear, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, dash: [5,height == 0 ? 0 : 10]))
                        .opacity((self.hideHorizontalLines && height != 0) ? 0 : 1)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeOut(duration: 0.2))
                        .clipped()
                }.background(Color.clear)
            }
        }
    }
    
    private func getYLegendSafe(height:Int)->CGFloat{
        if let legend = getYLegend() {
            return CGFloat(legend[height])
        }
        return 0
    }
    
    private func getYposition(height: Int)-> CGFloat {
        if let legend = getYLegend() {
            let res = (self.frame.height-((CGFloat(legend[height]) - min)*self.stepHeight))-(self.frame.height/2)
            return res
        }
        return 0
       
    }
    
    private func getXposition(height: Int)-> CGFloat {
            let points = self.data.onlyPoints()
        guard let max = points.max() else { return 0.0}
        guard let min = points.min() else { return 0.0}
        
        let minWidth = min.price.widthOfString(usingFont: UIFont.compactRoundedSemibold(10))
        let maxWidth = max.price.widthOfString(usingFont: UIFont.compactRoundedSemibold(10))
        
        let maxIndex = self.data.onlyPoints().firstIndex(of: max) ?? -1
        let minIndex = self.data.onlyPoints().firstIndex(of: min) ?? -1
        let finalRes = stepWidth * (height == 0 ? CGFloat(minIndex) : CGFloat(maxIndex))
        var adjustedRes = finalRes
        if height == 0 {
            adjustedRes -= minWidth / 2.0
        } else {
            adjustedRes -= maxWidth / 2.0
        }
        let textWidth = (height == 0 ? minWidth : maxWidth)
        return fmax(0.0, (adjustedRes + textWidth  >= frame.width ? (finalRes - textWidth) : adjustedRes))
    }
    
    private func line(atHeight: CGFloat, width: CGFloat) -> Path {
        var hLine = Path()
        hLine.move(to: CGPoint(x:5, y: (atHeight-min)*stepHeight))
        hLine.addLine(to: CGPoint(x: width, y: (atHeight-min)*stepHeight))
        return hLine
    }
    
    
    
    private func getYLegend() -> [Double]? {
        let points = self.data.onlyPoints()
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        return [min, max]
    }
}

struct Legend_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Legend(data: ChartData(points: [0.2,0.4,1.4,4.5]), frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: .constant(false))
        }.frame(width: 320, height: 200)
    }
}
