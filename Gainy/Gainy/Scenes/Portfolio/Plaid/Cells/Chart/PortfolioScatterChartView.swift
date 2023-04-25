//
//  PortfolioScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.11.2021.
//

import SwiftUI
import SwiftDate
import ActivityIndicatorView

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
            guard  lineViewModel.chartPeriod != selectedTag else {return}
            lineViewModel.chartPeriod = selectedTag
            lineViewModel.showCloseLine = selectedTag != .all
            isLeftDurationVis = selectedTag == .d1
            delegate.changeRange(range: selectedTag, viewModel: viewModel)
            hapticTouch.impactOccurred()
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
                headerView
                //sppView
                //    .frame(height: 24)
                ZStack {
                    if !viewModel.isLoading {
                        chartView
                            .frame(height: 220)
                    } else {
                        ZStack {
                            ActivityIndicatorView()
                                .frame(width: 50, height: 50)
                        }
                        .frame(height: 220)
                    }
                }.frame(height: 220)
                Spacer()
                
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                })
                
            }
            .onAppear(perform: {
                hapticTouch.prepare()
                lineViewModel.lastDayPrice = viewModel.lastDayPrice
            })
            .frame(height: 360)
            .ignoresSafeArea()
            .padding(.top, 20)
            .onChange(of: viewModel.lastDayPrice) { newValue in
                lineViewModel.lastDayPrice = newValue
            }
            .background(RemoteConfigManager.shared.mainBackColor.uiColor)
        } else {
            VStack {
                headerView
                //sppView
                //    .frame(height: 24)
                ZStack {
                    if !viewModel.isLoading {
                        chartView
                            .frame(height: 220)
                    } else {
                        ActivityIndicatorView()
                            .frame(width: 50, height: 50)
                    }
                }
                Spacer()
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                })
                
            }
            .onAppear(perform: {
                hapticTouch.prepare()
            })
            .frame(height: 360)
            .padding(.top, 20)
            .background(RemoteConfigManager.shared.mainBackColor.uiColor)
        }
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
                    if !RemoteConfigManager.shared.canShowPortoGains {
                        Spacer()
                    }
                    Text(statsDayName)
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(14).uiFont)
                        .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                        .opacity(viewModel.rangeGrow == 0.0 ? 0.0 : 1.0)
                    if RemoteConfigManager.shared.canShowPortoGains {
                        Image(viewModel.rangeGrow >= 0 ? "small_up" : "small_down")
                            .resizable()
                            .frame(width: 8.0, height: 8.0)
                            .opacity(viewModel.rangeGrow == 0.0 ? 0.0 : 1.0)
                        Text("\(viewModel.rangeGrow.percentUnsigned)")
                            .padding(.all, 0)
                            .font(UIFont.compactRoundedSemibold(14).uiFont)
                            .foregroundColor(UIColor(named: viewModel.rangeGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                            .opacity(viewModel.rangeGrow == 0.0 ? 0.0 : 1.0)
                    }
                }
                //.opacity(selectedTag == .d1 ? 1.0 : 0.0)
                .animation(.none)
                .opacity(lineViewModel.hideHorizontalLines ? 0.0 : 1.0)
            }
            HStack(spacing: 4) {
                Text(lineViewModel.hideHorizontalLines ? lineViewModel.currentDataValue : viewModel.balance.price)
                    .font(UIFont.compactRoundedSemibold(24).uiFont)
                    .foregroundColor(UIColor(hexString: "09141F", alpha: 1.0)?.uiColor)
                Spacer()
                
                Text(viewModel.rangeGrowBalance.price)
                    .padding(.all, 0)
                    .font(UIFont.compactRoundedSemibold(24).uiFont)
                    .foregroundColor(UIColor(named: viewModel.rangeGrowBalance >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                //.opacity(selectedTag == .d1 ? 1.0 : 0.0)
                    .opacity(lineViewModel.hideHorizontalLines ? 0.0 : 1.0)
                    .opacity(viewModel.rangeGrowBalance == 0.0 ? 0.0 : 1.0)
                    .animation(.none)
            }
        }
        .padding(.leading, 24)
        .padding(.trailing, 24)
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
    
    private var isChartGrows: Bool {
        if let sharedVal = SharedValuesManager.shared.rangeGrowBalanceFor(selectedTag, forPorto: true) {
            return sharedVal >= 0.0
        } else {
            return viewModel.chartData.startEndDiff >= 0.0
        }
    }
    
    @ObservedObject
    var lineViewModel: LineViewModel = LineViewModel()
    
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    
    private var chartView: some View {
        GeometryReader{ geometry in
            ZStack {
                if LatestTradingSessionManager.shared.is15PortoMarketOpen && selectedTag == .d1 {
                    marketJustOpened
                        .frame(height: 200)
                    
                } else {
                    if viewModel.chartData.onlyPoints().uniqued().count > 1 {
                        LineView(data: viewModel.chartData,
                                 title: "Full chart",
                                 style: isChartGrows ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop,
                                 viewModel: lineViewModel,
                                 minDataValue: viewModel.min,
                                 maxDataValue: viewModel.max)
                    }  else {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Not enough data")
                                    .foregroundColor(UIColor(named: "mainText")!.uiColor)
                                    .font(UIFont.proDisplaySemibold(12).uiFont)
                                    .onAppear {
                                        GainyAnalytics.logEventAMP("portfolio_not_enough_data_shown")
                                    }
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                    if viewModel.sypChartData.points.count > 1 {
                        LineView(data: viewModel.sypChartData,
                                 title: Constants.Chart.sypChartName,
                                 style: Styles.lineChartStyleMedian,
                                 viewModel: lineViewModel,
                                 minDataValue: viewModel.min,
                                 maxDataValue: viewModel.max)
                        .opacity(isSPPVisible ? 1.0 : 0.0)
                    }
                }
            }
            .padding(.all, 0)
            .animation(.linear)
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ value in
                    guard viewModel.chartData.onlyPoints().uniqued().count > 2 else {return}
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
    
    var marketJustOpened: some View {
        ZStack {
            Image(uiImage: UIImage(named: "no_data_graph_up")!)
                .padding(.all, 0)
                .frame(maxWidth: .infinity)
            VStack(alignment: .center, spacing: 8.0) {
                
                Text("Markets have just opened.\nThe chart will be updated shortly.")
                    .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                    .font(UIFont.compactRoundedSemibold(14).uiFont)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
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
            .background(Rectangle().fill(isSPPVisible ? UIColor.init(hexString: "0062FF")!.uiColor : RemoteConfigManager.shared.mainButtonColor.uiColor).cornerRadius(8))
            Spacer()
        }
        .padding(.leading, 16)
        .padding(.top, 30)
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
        .frame(width: UIScreen.main.bounds.width - 24 * 2.0)
        .padding(.leading, 24)
    }
    
    private func widthForGeometry(_ geometry: GeometryProxy) -> CGFloat {
        (UIScreen.main.bounds.width - 24 * 2.0 - 2.0 * 6) / 7.0
    }
}

