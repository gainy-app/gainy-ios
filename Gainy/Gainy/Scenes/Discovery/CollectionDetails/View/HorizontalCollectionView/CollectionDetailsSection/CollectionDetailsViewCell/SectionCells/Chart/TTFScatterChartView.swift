//
//  TTFScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.04.2022.
//

import SwiftUI
import SwiftDate

struct TTFScatterChartView: View {
    
    init(viewModel: TTFChartViewModel, delegate: TTFScatterChartDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    @ObservedObject
    var viewModel: TTFChartViewModel
    
    @ObservedObject
    var delegate: TTFScatterChartDelegate
    
    
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
        if #available(iOS 14.0, *) {
            VStack {
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                }).offset(y: 16)
                Spacer()
                ZStack {
                    chartView
                        .frame(height: 220)
                }
                sppView
                    .frame(height: 24).offset(x: 16, y: -16)
            }
            .background(Rectangle().foregroundColor(.white).cornerRadius(16).frame(height: 320).shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2))
            .onAppear(perform: {
                hapticTouch.prepare()
            })
            .frame(height: 320)
            .ignoresSafeArea()
            .padding(.top, 0)
            .padding(.leading, 4)
            .padding(.trailing, 4)
        } else {
            VStack {
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                })
                Spacer()
                ZStack {
                    chartView
                        .frame(height: 136)
                }
                sppView
                    .frame(height: 24)
                    .offset(y: -16)
            }
            .background(Color.white)
            .onAppear(perform: {
                hapticTouch.prepare()
            })
            .frame(height: 320)
            .padding(.top, 0)
        }
    }
    //MARK:- Haptics
    private let hapticTouch = UIImpactFeedbackGenerator()
    
    //MARK:- Body sections
    
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
    
    private var isChartGrows: Bool {
        return viewModel.chartData.startEndDiff >= 0.0
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
                             style: isChartGrows ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop,
                             viewModel: lineViewModel)
                }  else {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Not enough data")
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
                    .opacity(lineViewModel.isSPYVisible ? 1.0 : 0.0)
                }                
            }
            .padding(.all, 0)
            .animation(.linear)
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
                    Text("\(viewModel.spGrow.cleanTwoDecimalP.replacingOccurrences(of: "+", with: "").replacingOccurrences(of: "-", with: ""))")
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(13).uiFont)
                        .foregroundColor(UIColor(named: viewModel.spGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
                .padding(.top, 6)
                .padding(.bottom, 6)
            })
            .frame(height: 24)
            .background(Rectangle().fill(isSPPVisible ? UIColor.init(hexString: "0062FF")!.uiColor : UIColor(hexString: "F7F8F9", alpha: 1.0)!.uiColor).cornerRadius(12))
            Spacer()
        }
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
                            .cornerRadius(8.0)
                            .frame(height: 24)
                            .frame(minWidth: 48)
                            .padding(.all, 0)
                        Text(tag.rawValue)
                            .foregroundColor(tag == selectedTag ? Color.white : Color.textColor)
                            .font(UIFont.compactRoundedMedium(12).uiFont)
                            .padding(.all, 0)
                    }
                    .padding(.all, 0)
                    .animation(.easeIn)
                }).frame(width: widthForGeometry(geometry), height: 20)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32.0 * 2.0)
        .padding(.leading, 16)
    }
    
    private func widthForGeometry(_ geometry: GeometryProxy) -> CGFloat {
        (UIScreen.main.bounds.width - 32 * 2.0 - 2.0 * 6) / 7.0
    }
}


