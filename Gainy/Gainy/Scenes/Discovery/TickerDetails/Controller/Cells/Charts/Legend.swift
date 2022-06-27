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
    @Binding var showCloseLine: Bool
    @Binding var closeLineValue: Float
    @Binding var minMaxPercent: Bool
    @Binding var minDataValue: Double?
    @Binding var maxDataValue: Double?
    
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
        var min: Double?
        var max: Double?
        let points = self.data.onlyPoints()
        if minDataValue != nil && maxDataValue != nil {
            min = minDataValue!
            max = maxDataValue!
        }else if let minPoint = points.min(), let maxPoint = points.max(), minPoint != maxPoint {
            min = minPoint
            max = maxPoint
        }else {
            return 0
        }
        if let min = min, let max = max, min != max {
            if (min < 0){
                return (frame.size.height-padding) / CGFloat(max - min)
            }else{
                return (frame.size.height-padding) / CGFloat(max - min)
            }
        }
        return 0
    }
    
    var min: CGFloat {
        return CGFloat(minDataValue ?? 0)
    }
    
    //    var max: CGFloat {
    //        let points = self.data.onlyPoints()
    //        return CGFloat(points.max() ?? 0)
    //    }
    
    var body: some View {
        ZStack(alignment: .topLeading){
            ForEach((0...1), id: \.self) { height in
                HStack(alignment: .center){
                    Text(minMaxPercent ? Float(self.getYLegendSafePercent(height: height)).percentRaw : "\(Float(self.getYLegendSafe(height: height)).price)")
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
            if closeLineValue != 0.0 && showCloseLine {
                self.line(atHeight: CGFloat(closeLineValue), width: self.frame.width)
                    .stroke(UIColor(hexString: "B1BDC8")!.uiColor,
                            style: StrokeStyle(lineWidth: 1.0, lineCap: .round, dash: [1, 4]))
                    .rotationEffect(.degrees(180), anchor: .center)
                    .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    .animation(.easeOut(duration: 0.2))
                    .opacity(0.5)
                    .clipped()
            }
        }
    }
    
    private func getYLegendSafePercent(height:Int)->CGFloat{
        if let legend = getYLegendPercent() {
            return CGFloat(legend[height])
        }
        return 0
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
        return fmax(6.0, (adjustedRes + textWidth  >= frame.width ? (finalRes - textWidth - 6.0) : adjustedRes))
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
    
    private func getYLegendPercent() -> [Double]? {
        func pctDiff(_ x1: Double, _ x2: Double) -> Double {
            var diff = (x2 - x1) / x1
            if x1 < 0 && x2 < 0 {
                diff = -diff
            }
            return Double(round(100 * (diff * 100)) / 100)
        }
        
        let points = self.data.onlyPoints()
        guard let max = points.max() else { return nil }
        guard let min = points.min() else { return nil }
        let first = points.first ?? 0.0
        return [pctDiff(first, min), pctDiff(first, max)]
    }
    
    
}

struct Legend_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader{ geometry in
            Legend(data: ChartData(points: [0.2,0.4,1.4,4.5]), frame: .constant(geometry.frame(in: .local)), hideHorizontalLines: .constant(false),
                   showCloseLine: .constant(true),
                   closeLineValue: .constant(0.0),
                   minMaxPercent: .constant(false),minDataValue: .constant(0.2),
                   maxDataValue:.constant(4.5))
        }.frame(width: 320, height: 200)
    }
}
