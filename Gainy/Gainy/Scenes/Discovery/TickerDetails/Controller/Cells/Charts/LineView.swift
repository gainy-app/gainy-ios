//
//  LineView.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct LineView: View {
    
    @ObservedObject var data: ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var valueSpecifier: String
    public var legendSpecifier: String
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var showLegend = false
    @State private var dragLocation:CGPoint = .zero
    @State private var indicatorLocation:CGPoint = .zero
    @State private var closestPoint: CGPoint = .zero
    @State private var opacity:Double = 0
    @State private var currentDataNumber: String = ""
    @State private var hideHorizontalLines: Bool = false
    @Binding private var isMedianVisible: Bool
    
    init(data: ChartData,
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleGrow,
                valueSpecifier: String? = "%.1f",
                legendSpecifier: String? = "%.2f",
                isMedianVisible: Binding<Bool>) {
        self.data = data
        self._isMedianVisible = isMedianVisible
        self.title = title
        self.legend = legend
        self.style = style
        self.valueSpecifier = valueSpecifier!
        self.legendSpecifier = legendSpecifier!
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
    }
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    
    public var body: some View {
        
        let tap = TapGesture().onEnded {
        }
        GeometryReader{ geometry in
                ZStack{
                    GeometryReader{ reader in
                        
                        HLine()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(Color(hex: "E0E6EA"))
                            .frame(height: 1)
                            .offset(x: 0, y: 40 + 40)
                            .opacity(hideHorizontalLines ? 0.0 : 1.0)
                        
                        if(self.showLegend && isMedianVisible == false){
                            Legend(data: self.data,
                                   frame: .constant(reader.frame(in: .local)), hideHorizontalLines: self.$hideHorizontalLines, specifier: legendSpecifier)
                                .animation(.none)
                        }
                        
                                                
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - chartOffset, height: reader.frame(in: .local).height + 25)),
                             touchLocation: self.$indicatorLocation,
                             showIndicator: self.$hideHorizontalLines,
                             minDataValue: .constant(nil),
                             maxDataValue: .constant(nil),
                             showBackground: false,
                             gradient: self.style.gradientColor
                        )
                        .offset(x: chartOffset)
                        .onAppear(){
                            self.showLegend = true
                        }
                        .onDisappear(){
                            self.showLegend = false
                        }
                    }
                    .frame(width: geometry.frame(in: .local).size.width, height: chartHeight)
                    .background(Rectangle().fill().foregroundColor(isMedianVisible ? Color.clear : UIColor(hexString: "F8FBFD")!.uiColor).animation(.none))
                    
                    MagnifierRect(currentNumber: self.$currentDataNumber)
                        .opacity(self.opacity)
                        .offset(x: self.dragLocation.x - geometry.frame(in: .local).size.width/2)
                }
                //.background(Rectangle().fill().foregroundColor(UIColor(hexString: "F8FBFD")!.uiColor))
                .offset(x: 0, y: 40)
                .frame(width: geometry.frame(in: .local).size.width, height: chartHeight)
                .gesture(isMedianVisible ? nil : DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    self.dragLocation = value.location
                    self.indicatorLocation = CGPoint(x: max(value.location.x-chartOffset,0), y: 32)
                    self.opacity = 1
                    self.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width-chartOffset, height: chartHeight)
                    self.hideHorizontalLines = true
                })
                    .onEnded({ value in
                        self.opacity = 0
                        self.hideHorizontalLines = false
                    })
                )
        }
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = self.data.onlyPoints()
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x-15)/stepWidth))
        if (index >= 0 && index < points.count){
            self.currentDataNumber = self.data.points[index].0
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineView(data:ChartData.init(points: [8,23,54,32,12,37,7,23,43]), title: "Full chart", style: Styles.lineChartStyleGrow, isMedianVisible: .constant(false))
            
            LineView(data: ChartData.init(points:[282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188]), title: "Full chart", style: Styles.lineChartStyleGrow, isMedianVisible: .constant(false))
            
        }
    }
}

