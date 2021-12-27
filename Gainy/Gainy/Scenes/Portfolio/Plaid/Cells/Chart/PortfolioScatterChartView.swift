//
//  PortfolioScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.11.2021.
//

import SwiftUI
import SwiftDate

struct PortfolioScatterChartView: View {
    
    init(viewModel: HoldingChartViewModel, delegate: HoldingScatterChartDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    @ObservedObject
    var viewModel: HoldingChartViewModel
    
    @ObservedObject
    var delegate: HoldingScatterChartDelegate
    
    
    @State
    private var selectedTag: ScatterChartView.ChartPeriod = .d1 {
        didSet {
            lineViewModel.chartPeriod = selectedTag
            isLeftDurationVis = selectedTag == .d1
            delegate.changeRange(range: selectedTag, viewModel: viewModel)
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
            lineViewModel.isSPYVisible = isSPPVisible
        }
    }
    
    @State
    private var isLeftDurationVis: Bool = true
    
    var body: some View {
        VStack {
            headerView
            chartView
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .frame(height: 220)
            Spacer()
            sppView
                .offset(y: -16)
            GeometryReader(content: { geometry in
                bottomMenu(geometry)
            })
            
        }
        .background(Color.white)
        .onAppear(perform: {
            hapticTouch.prepare()
        })
    }
    //MARK:- Haptics
    private let hapticTouch = UIImpactFeedbackGenerator()
    
    //MARK:- Body sections
    
    private var headerView: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text("Balance")
                    .font(UIFont.compactRoundedSemibold(14).uiFont)
                    .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)?.uiColor)
                Spacer()
                
                HStack(spacing: 4) {
                    Text(statsDayName)
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(14).uiFont)
                        .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                    Image(viewModel.rangeGrow >= 0 ? "small_up" : "small_down")
                        .resizable()
                        .frame(width: 8.0, height: 8.0)
                    Text("\(viewModel.rangeGrow.cleanTwoDecimalP)")
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(14).uiFont)
                        .foregroundColor(UIColor(named: viewModel.rangeGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                }
            }
            HStack(spacing: 4) {
                Text(viewModel.balance.price)
                    .font(UIFont.compactRoundedSemibold(24).uiFont)
                    .foregroundColor(UIColor(hexString: "09141F", alpha: 1.0)?.uiColor)
                Spacer()
                
                Text(viewModel.rangeGrowBalance.price)
                    .padding(.all, 0)
                    .font(UIFont.compactRoundedSemibold(24).uiFont)
                    .foregroundColor(UIColor(named: viewModel.rangeGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
            }
        }
        .opacity(0.0)
        .padding(.leading, 16)
        .padding(.trailing, 16)
        .frame(height: 48)
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
    
    @ObservedObject
    var lineViewModel: LineViewModel = LineViewModel()
    
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    
    private var chartView: some View {
        GeometryReader{ geometry in
            ZStack {
                if viewModel.chartData.onlyPoints().uniqued().count > 2 {
                    LineView(data: viewModel.chartData,
                             title: "Full chart",
                             style: viewModel.chartData.startEndDiff > 0 ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop,
                             viewModel: lineViewModel)
                }  else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Not enought data")
                                .foregroundColor(UIColor(named: "mainText")!.uiColor)
                                .font(UIFont.proDisplaySemibold(12).uiFont)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                if viewModel.sypChartData.points.count > 2 {
                    LineView(data: viewModel.sypChartData,
                             title: Constants.Chart.sypChartName,
                             style: Styles.lineChartStyleMedian,
                             viewModel: lineViewModel)
                        .opacity(isSPPVisible ? 1.0 : 0.0)
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
    var sppView: some View {
        HStack {
            Button(action: {
                isSPPVisible.toggle()
                hapticTouch.impactOccurred()
            }, label: {
                HStack(spacing: 4.0) {
                    Image(isSPPVisible ? "toggle_on" : "toggle_off")
                        .renderingMode(.original)
                    Text("S&P500")
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(12).uiFont)
                        .foregroundColor(isSPPVisible ? Color.white : UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                    
                    Image(viewModel.spGrow >= 0 ? "small_up" : "small_down")
                        .resizable()
                        .frame(width: 8.0, height: 8.0)
                    Text("\(viewModel.spGrow.cleanTwoDecimalP)")
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(13).uiFont)
                        .foregroundColor(UIColor(named: viewModel.spGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 6)
                .padding(.bottom, 6)
                .background(Rectangle().fill(isSPPVisible ? UIColor.init(hexString: "0062FF")!.uiColor : UIColor(hexString: "F7F8F9", alpha: 1.0)!.uiColor).cornerRadius(20))
            })
            Spacer()
        }
        .padding(.leading, 16)
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
        }.padding(.leading, 16)
            .padding(.trailing, 16)
            .padding(.top, 0)
            .frame(width: UIScreen.main.bounds.width)
    }
    
    private func widthForGeometry(_ geometry: GeometryProxy) -> CGFloat {
        (UIScreen.main.bounds.width - 16.0 * 2.0 - 2.0 * 6) / 7.0
    }
}

