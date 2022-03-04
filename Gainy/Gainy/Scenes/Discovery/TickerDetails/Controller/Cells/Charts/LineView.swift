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
    @State private var showLegend = false {
        didSet {
            if showLegend == false {
                hapticTouch.selectionChanged()
            }
        }
    }
    
    @ObservedObject
    var viewModel: LineViewModel
    
    //MARK:- Haptics
    private let hapticTouch = UISelectionFeedbackGenerator()
    
    init(data: ChartData,
                title: String? = nil,
                legend: String? = nil,
                style: ChartStyle = Styles.lineChartStyleGrow,
                valueSpecifier: String? = "%.1f",
                legendSpecifier: String? = "%.2f",
                viewModel: LineViewModel) {
        self.data = data
        self.viewModel = viewModel
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
        
         GeometryReader{ geometry in
                ZStack{
                    GeometryReader{ reader in
                        
                        if viewModel.showCloseLine && title != Constants.Chart.sypChartName {
                        HLine()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(Color(hex: "E0E6EA"))
                            .frame(height: 1)
                            .offset(x: 0, y: getOpenLinePoint(frame: CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - chartOffset, height: reader.frame(in: .local).height + 25)).y)
                            .opacity(viewModel.chartPeriod == .d1 ? 1.0 : 0.0)
                            .opacity(viewModel.isSPYVisible ? 0.0 : 1.0)
                        }
                        
                        if(self.showLegend && viewModel.isSPYVisible == false && viewModel.indicatorLocation == .zero){
                            Legend(data: self.data,
                                   frame: .constant(reader.frame(in: .local)), hideHorizontalLines: $viewModel.hideHorizontalLines, specifier: legendSpecifier)
                                .animation(.none)
                        }
                                                
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - chartOffset, height: reader.frame(in: .local).height + 25)),
                             touchLocation: $viewModel.indicatorLocation,
                             showIndicator: $viewModel.hideHorizontalLines,
                             isSPYVisible:$viewModel.isSPYVisible,
                             minDataValue: .constant(nil),
                             maxDataValue: .constant(nil),
                             indicatorVal: $viewModel.currentDataNumber,
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
                                  
                }
                .offset(x: 0, y: 40)
                .frame(width: geometry.frame(in: .local).size.width, height: chartHeight)
                
        }.onAppear(perform: {
            hapticTouch.prepare()
        })
    }
    
    
    func getOpenLinePoint(frame: CGRect) -> CGPoint {
        guard data.points.count > 0 else {return .zero}
        
        let points = data.onlyPoints()
        let stepHeight: CGFloat = (frame.size.height - 30) / CGFloat(points.max()! - points.min()!)
        return CGPoint(x: 0, y: (frame.size.height - 25) - CGFloat(points[1] - points.min()!) * stepHeight)
    }
}

//struct LineView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            LineView(data:ChartData.init(points: [8,23,54,32,12,37,7,23,43]), title: "Full chart", style: Styles.lineChartStyleGrow, isMedianVisible: .constant(false))
//
//            LineView(data: ChartData.init(points:[282.502, 284.495, 283.51, 285.019, 285.197, 286.118, 288.737, 288.455, 289.391, 287.691, 285.878, 286.46, 286.252, 284.652, 284.129, 284.188]), title: "Full chart", style: Styles.lineChartStyleGrow, isMedianVisible: .constant(false))
//
//        }
//    }
//}

