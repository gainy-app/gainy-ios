//
//  LineView.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct LineView: View {
    init(data: ChartData, title: String? = nil, legend: String? = nil, style: ChartStyle = Styles.lineChartStyleGrow, valueSpecifier: String = "%.1f", legendSpecifier: String = "%.2f", viewModel: LineViewModel,
         minDataValue: Double? = nil,
         maxDataValue: Double? = nil
    ) {
        self.data = data
        self.title = title
        self.legend = legend
        self.style = style
        self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
        self.valueSpecifier = valueSpecifier
        self.legendSpecifier = legendSpecifier
        self.viewModel = viewModel
        self.minDataValue = minDataValue
        self.maxDataValue = maxDataValue
    }
    
    
    @ObservedObject var data: ChartData
    public var title: String?
    public var legend: String?
    public var style: ChartStyle
    public var darkModeStyle: ChartStyle
    public var valueSpecifier: String
    public var legendSpecifier: String
    var minDataValue: Double?
    var maxDataValue: Double?
    
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
    
    
    //    self.data = data
    //    self.title = title
    //    self.legend = legend
    //    self.style = style
    //    self.valueSpecifier = valueSpecifier!
    //    self.legendSpecifier = legendSpecifier!
    //    self.darkModeStyle = style.darkModeStyle != nil ? style.darkModeStyle! : Styles.lineViewDarkMode
    //    self.viewModel = viewModel
    //    self.minDataValue = minDataValue
    //    self.maxDataValue = maxDataValue
    
    //    init(data: ChartData,
    //                title: String? = nil,
    //                legend: String? = nil,
    //                style: ChartStyle = Styles.lineChartStyleGrow,
    //                valueSpecifier: String? = "%.1f",
    //                legendSpecifier: String? = "%.2f",
    //                minDataValue: Double? = nil,
    //                maxDataValue: Double? = nil,
    //                viewModel: LineViewModel) {
    //
    //    }
    
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    public var body: some View {
        
        GeometryReader{ geometry in
            ZStack{
                GeometryReader{ reader in
                    
//                    if viewModel.showCloseLine && title != Constants.Chart.sypChartName {
//                        HLine()
//                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
//                            .foregroundColor(Color(hex: "E0E6EA"))
//                            .frame(height: 1)
//                            .offset(x: 0, y: getOpenLineY(frame: CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - chartOffset, height: reader.frame(in: .local).height + 25)))
//                            .opacity(viewModel.chartPeriod == .d1 ? 1.0 : 0.0)
//                            .opacity(viewModel.isSPYVisible ? 0.0 : 1.0)
//                    }
//
                    if(self.showLegend && viewModel.isSPYVisible == false && viewModel.indicatorLocation == .zero){
                        Legend(data: self.data,
                               frame: .constant(reader.frame(in: .local)),
                               hideHorizontalLines: $viewModel.hideHorizontalLines,
                               showCloseLine: $viewModel.showCloseLine,
                               closeLineValue: $viewModel.lastDayPrice,
                               minMaxPercent: $viewModel.minMaxPercent,
                               minDataValue: .constant(minDataValue),
                               maxDataValue:.constant(maxDataValue),
                               specifier: legendSpecifier)
                        .animation(.none)
                    }
                    
                    Line(data: self.data,
                         frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - chartOffset, height: reader.frame(in: .local).height + 25)),
                         touchLocation: $viewModel.indicatorLocation,
                         showIndicator: $viewModel.hideHorizontalLines,
                         isSPYVisible:$viewModel.isSPYVisible,
                         minDataValue: .constant(minDataValue),
                         maxDataValue:.constant(maxDataValue),
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

