//
//  LineView.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 02..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

class LineViewModel: ObservableObject {
    @Published
    var dragLocation:CGPoint = .zero
    
    @Published
    var indicatorLocation:CGPoint = .zero
    
    @Published
    var closestPoint: CGPoint = .zero
    
    @Published
    var opacity:Double = 0
    
    @Published
    var currentDataNumber: String = ""
    
    @Published
    var currentDataValue: String = ""
    
    @Published
    var hideHorizontalLines: Bool = false
    
    @Published
    var isMedianVisible: Bool = false
}

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
                        
                        HLine()
                            .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .foregroundColor(Color(hex: "E0E6EA"))
                            .frame(height: 1)
                            .offset(x: 0, y: 40 + 40)
                            .opacity(viewModel.hideHorizontalLines ? 0.0 : 1.0)
                        
                        if(self.showLegend && viewModel.isMedianVisible == false && viewModel.indicatorLocation == .zero){
                            Legend(data: self.data,
                                   frame: .constant(reader.frame(in: .local)), hideHorizontalLines: $viewModel.hideHorizontalLines, specifier: legendSpecifier)
                                .animation(.none)
                        }
                        
                                                
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width - chartOffset, height: reader.frame(in: .local).height + 25)),
                             touchLocation: $viewModel.indicatorLocation,
                             showIndicator: $viewModel.hideHorizontalLines,
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

