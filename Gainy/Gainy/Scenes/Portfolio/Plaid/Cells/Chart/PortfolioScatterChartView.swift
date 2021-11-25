//
//  PortfolioScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.11.2021.
//

import SwiftUI
import SwiftDate

struct PortfolioScatterChartView: View {
    
    init(viewModel: HoldingChartViewModel, delegate: ScatterChartDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    @ObservedObject
    var viewModel: HoldingChartViewModel
    
    @ObservedObject
    var delegate: ScatterChartDelegate
    
    
    @State
    private var selectedTag: ScatterChartView.ChartPeriod = .d1 {
        didSet {
            lineViewModel.chartPeriod = selectedTag
            isLeftDurationVis = selectedTag == .d1
            delegate.range = selectedTag
            hapticTouch.impactOccurred()
            GainyAnalytics.logEvent("portfolio_chart_period_changed", params: ["period" : selectedTag.rawValue, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        }
    }
    
    @State
    private var isSPPVisible: Bool = false {
        didSet {
            if isSPPVisible {
                GainyAnalytics.logEvent("portfolio_chart_period_spp_pressed", params: [ "period" : selectedTag.rawValue, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            }
        }
    }
    
    @State
    private var isLeftDurationVis: Bool = true
    
    var body: some View {
        GeometryReader(content: { rootGeo in
            VStack {
                headerView
                chartView
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                }).frame(maxHeight: 40)
                
            }
            .background(Color.white)
        }).onAppear(perform: {
            hapticTouch.prepare()
        })
    }
    //MARK:- Haptics
    private let hapticTouch = UIImpactFeedbackGenerator()
    
    //MARK:- Body sections
    
    private var headerView: some View {
        VStack {
            HStack(spacing: 8) {
                Button(action: {
                    isSPPVisible.toggle()
                    hapticTouch.impactOccurred()
                }, label: {
                    HStack {
                            Image(isSPPVisible ? "toggle_on" : "toggle_off")
                                .renderingMode(.original)
                        Text("S&P500")
                            .padding(.all, 0)
                            .font(UIFont.proDisplayRegular(13).uiFont)
                            .foregroundColor(isSPPVisible ? Color.white : UIColor(named: "mainText")!.uiColor)
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .background(Rectangle().fill(isSPPVisible ? UIColor.init(hexString: "0062FF")!.uiColor : Color.white).cornerRadius(20))
                })
            }
        }
        .padding(.all, 0)
        .frame(height: 74)
        .animation(.easeIn)
    }
    
    private var statsDayName: String {
        switch selectedTag {
        case .d1:
            return "Today"
        case .w1:
            return "Week"
        case .m1:
            return "Month"
        case .m3:
            return "3 Months"
        case .y1:
            return "Year"
        case .y5:
            return "5 Years"
        case .all:
            return "All"
            
        }
    }
    
    private var statsDayValue: String {
        return viewModel.chartData.startEndDiffString
    }
    
    private var statsDayValueRaw: Float {
        return 0.5
    }
    
    @ObservedObject
    var lineViewModel: LineViewModel = LineViewModel()
    
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    
    private var chartView: some View {
        GeometryReader{ geometry in
        ZStack {
            if viewModel.chartData.points.count > 1 {
                LineView(data: viewModel.chartData, title: "Full chart", style: viewModel.chartData.startEndDiff > 0 ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop, viewModel: lineViewModel).offset(y: -40)
            }
        }
        .padding(.all, 0)
        .animation(.linear)
        .background(Rectangle().fill().foregroundColor(.white))
        .gesture(DragGesture(minimumDistance: 0)
        .onChanged({ value in
            lineViewModel.dragLocation = value.location
            lineViewModel.indicatorLocation = CGPoint(x: max(value.location.x-chartOffset,0), y: 32)
            lineViewModel.opacity = 1
            lineViewModel.closestPoint = self.getClosestDataPoint(toPoint: value.location, width: geometry.frame(in: .local).size.width-chartOffset, height: chartHeight)
            lineViewModel.hideHorizontalLines = true
        })
            .onEnded({ value in
                lineViewModel.opacity = 0
                lineViewModel.hideHorizontalLines = false
                lineViewModel.indicatorLocation = .zero
            }
            )
        )
        }
    }
    
    func getClosestDataPoint(toPoint: CGPoint, width:CGFloat, height: CGFloat) -> CGPoint {
        let points = viewModel.chartData.onlyPoints()
        guard points.count > 1 else { return .zero}
        let stepWidth: CGFloat = width / CGFloat(points.count-1)
        let stepHeight: CGFloat = height / CGFloat(points.max()! + points.min()!)
        
        let index:Int = Int(floor((toPoint.x)/stepWidth))
        if (index >= 0 && index < points.count){
            lineViewModel.currentDataNumber = viewModel.chartData.points[index].0
            lineViewModel.currentDataValue = Float(viewModel.chartData.points[index].1).price
            return CGPoint(x: CGFloat(index)*stepWidth, y: CGFloat(points[index])*stepHeight)
        }
        return .zero
    }
    
    private func bottomMenu(_ geometry: GeometryProxy) -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(ScatterChartView.ChartPeriod.allCases, id: \.self) { tag in                
                Button(action: {
                    selectedTag = tag
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(tag == selectedTag ? Color.selectorColor : Color.clear)
                            .cornerRadius(16.0)
                            .frame(height: 24)
                            .frame(minWidth: 48)
                        Text(tag.rawValue)
                            .foregroundColor(tag == selectedTag ? Color.white : Color.textColor)
                            .font(UIFont.compactRoundedMedium(12).uiFont)
                    }
                    .animation(.easeIn)
                }).frame(width: widthForGeometry(geometry), height: 20)
            }
        }.padding(.leading, 20)
        .padding(.trailing, 20)
        .padding(.top, 8)
    }
    
    private func widthForGeometry(_ geometry: GeometryProxy) -> CGFloat {
        48
    }
}
