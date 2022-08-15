//
//  ScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.08.2021.
//

import SwiftUI
import SwiftDate
import ActivityIndicatorView

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: Double(r) / 0xff,
            green: Double(g) / 0xff,
            blue: Double(b) / 0xff
        )
    }
    
    static let chartBackground = Color.init(hex: "F8FBFD")
    static let selectorColor = Color.init(hex: "131313")
    static let textColor = Color.init(hex: "1F2E35")
}



struct ScatterChartView: View {
    
    init(viewModel: ScatterChartViewModel, delegate: ScatterChartDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
    }
    
    @ObservedObject
    var viewModel: ScatterChartViewModel
    
    @ObservedObject
    var delegate: ScatterChartDelegate
    
    enum ChartPeriod: String, CaseIterable {
        case d1 = "1D", w1 = "1W", m1 = "1M", m3 = "3M", y1 = "1Y", y5 = "5Y", all = "ALL"
        
        var longName: String {
            switch self {
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
    }
    
    @State
    private var selectedTag: ChartPeriod = .d1 {
        didSet {
            guard  lineViewModel.chartPeriod != selectedTag else {return}
            lineViewModel.chartPeriod = selectedTag
            isLeftDurationVis = selectedTag == .d1
            lineViewModel.showCloseLine = selectedTag == .d1
            delegate.range = selectedTag
            hapticTouch.impactOccurred()
            GainyAnalytics.logEvent("ticker_chart_period_changed", params: ["tickerSymbol" : self.viewModel.ticker.symbol ?? "none", "period" : selectedTag.rawValue, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        }
    }
    
    @State
    private var isMedianVisible: Bool = false {
        didSet {
            if isMedianVisible {
                GainyAnalytics.logEvent("ticker_chart_period_median_pressed", params: ["tickerSymbol" : self.viewModel.ticker.symbol ?? "none", "period" : selectedTag.rawValue, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
            }
        }
    }
    
    @State
    private var isLeftDurationVis: Bool = true
    
    var body: some View {
        if #available(iOS 14.0, *) {
            GeometryReader(content: { rootGeo in
                VStack {
                    headerView
                    chartView
                        .padding(.top, 20)
                        .opacity(viewModel.isLoading ? 0.0 : 1.0)
                    ActivityIndicatorView()
                        .frame(width: 50, height: 50)
                        .offset(y: -70)
                        .opacity(viewModel.isLoading ? 1.0 : 0.0)
                    compareLegend
                    GeometryReader(content: { geometry in
                        bottomMenu(geometry)
                    }).frame(maxHeight: 40)
                    
                }
                .frame(height: 341)
            }).onAppear(perform: {
                hapticTouch.prepare()
            }).frame(height: 341)
                .ignoresSafeArea()
                .padding(.top, 0)
                .onChange(of: viewModel.lastDayPrice) { newValue in
                    lineViewModel.lastDayPrice = newValue
                }
        } else {
            GeometryReader(content: { rootGeo in
                VStack {
                    headerView
                    chartView
                        .padding(.top, 20)
                        .opacity(viewModel.isLoading ? 0.0 : 1.0)
                    ActivityIndicatorView()
                        .frame(width: 50, height: 50)
                        .offset(y: -70)
                        .opacity(viewModel.isLoading ? 1.0 : 0.0)
                    compareLegend
                    GeometryReader(content: { geometry in
                        bottomMenu(geometry)
                    }).frame(maxHeight: 40)
                    
                }
                .frame(height: 341)
            }).onAppear(perform: {
                hapticTouch.prepare()
            }).frame(height: 341)
                .padding(.top, 0)
            //.background(LinearGradient(colors: [UIColor(hexString: "F7F8F9")!.uiColor, Color.white], startPoint: .top, endPoint: .bottom))
        }
    }
    
    //MARK:- Haptics
    private let hapticTouch = UIImpactFeedbackGenerator()
    
    //MARK:- Body sections
    
    private var headerView: some View {
        
        ZStack {
            HStack(spacing: 0) {
                //Right Stock price
                VStack(alignment: .trailing, spacing: 0) {
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        
                        Group {
                            Text(viewModel.ticker.symbol ?? "")
                                .foregroundColor(UIColor(hexString: "#6C5DD3")!.uiColor)
                                .font(UIFont.compactRoundedSemibold(14.0).uiFont)
                                .padding(.top, 4)
                                .padding(.bottom, 4)
                                .padding(.leading, 8)
                                .padding(.trailing, 8)
                        }
                        .background(UIColor(hexString: "#F7F8F9")!.uiColor)
                        .cornerRadius(8.0)
                        
                        Spacer()
                        
                        Text(statsDayName)
                            .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                            .font(UIFont.compactRoundedSemibold(14.0).uiFont)
                            .padding(.top, 2)
                        Image(uiImage: UIImage(named: statsDayValueRaw >= 0 ? "small_up" : "small_down")!)
                            .resizable()
                            .frame(width: 8, height: 8)
                        Text(statsDayValue.replacingOccurrences(of: "-", with: ""))
                            .foregroundColor(statsDayValue.hasPrefix("-") ? UIColor(named: "mainRed")!.uiColor : UIColor(named: "mainGreen")!.uiColor)
                            .font(UIFont.compactRoundedSemibold(14.0).uiFont)
                            .padding(.trailing, 24)
                        
                    }.opacity(lineViewModel.hideHorizontalLines ? 0.0 : 1.0)
                        .padding(.top, 10)
                    HStack {
                        
                        //Median
                        bottomMedian
                            .opacity(viewModel.localTicker.haveMedian ? 1.0 : 0.0)
                        
                        Spacer()
                        
                        Text(lineViewModel.hideHorizontalLines ? lineViewModel.currentDataValue : (viewModel.ticker.currentPrice.price))
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.compactRoundedSemibold(24.0).uiFont)
                            .animation(.none)
                            .padding(.trailing, 24)
                    }
                }
                .frame(height: 78)
                Spacer()
            }
            .padding(.leading, 24)
            .padding(.top, 0)
            .offset(y: -10)
            
        }
        .padding(.all, 0)
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
            return "3M"
        case .y1:
            return "Year"
        case .y5:
            return "5Y"
        case .all:
            return "All"
            
        }
    }
    
    private var statsDayValue: String {
        switch selectedTag {
        case .d1:
            return (viewModel.ticker.priceChangeToday * 100.0).percentRaw
        case .m1:
            return ((viewModel.ticker.tickerMetrics?.priceChange_1m ?? 0.0) * 100.0).percentRaw
        case .w1:
            return ((viewModel.ticker.tickerMetrics?.priceChange_1w ?? 0.0) * 100.0).percentRaw
        case .m3:
            return ((viewModel.ticker.tickerMetrics?.priceChange_3m ?? 0.0) * 100.0).percentRaw
        case .y1:
            return ((viewModel.ticker.tickerMetrics?.priceChange_1y ?? 0.0) * 100.0).percentRaw
        case .y5:
            return ((viewModel.ticker.tickerMetrics?.priceChange_5y ?? 0.0) * 100.0).percentRaw
        case .all:
            return ((viewModel.ticker.tickerMetrics?.priceChangeAll ?? 0.0) * 100.0).percentRaw
        }
    }
    
    private var statsDayValueRaw: Float {
        switch selectedTag {
        case .d1:
            return viewModel.ticker.priceChangeToday
        case .w1:
            return viewModel.ticker.tickerMetrics?.priceChange_1w ?? 0.0
        case .m1:
            return viewModel.ticker.tickerMetrics?.priceChange_1m ?? 0.0
        case .m3:
            return viewModel.ticker.tickerMetrics?.priceChange_3m ?? 0.0
        case .y1:
            return viewModel.ticker.tickerMetrics?.priceChange_1y ?? 0.0
        case .y5:
            return viewModel.ticker.tickerMetrics?.priceChange_5y ?? 0.0
        case .all:
            return viewModel.ticker.tickerMetrics?.priceChangeAll ?? 0.0
        }
    }
    
    @ObservedObject
    var lineViewModel: LineViewModel = LineViewModel()
    
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    
    private var chartView: some View {
        GeometryReader{ geometry in
            ZStack {
                if viewModel.chartData.onlyPoints().uniqued().count > 1 {
                    LineView(data: viewModel.chartData,
                             title: "Full chart",
                             style: statsDayValueRaw >= 0.0 ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop,
                             viewModel: lineViewModel,
                             minDataValue: viewModel.min,
                             maxDataValue: viewModel.max
                    ).offset(y: -60)
                    
                    if viewModel.medianData.onlyPoints().uniqued().count > 1 {
                        LineView(data: viewModel.medianData,
                                 title: "Full chart",
                                 style: Styles.lineChartStyleMedian,
                                 viewModel: lineViewModel,
                                 minDataValue: viewModel.min,
                                 maxDataValue: viewModel.max
                        ).offset(y: -60)
                            .opacity(lineViewModel.isSPYVisible ? 1.0 : 0.0)
                    }
                } else {
                    //no_data_graph_down
                    if let metrics = viewModel.ticker.realtimeMetrics, let date =  ((metrics.lastKnownPriceDatetime ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()).convertTo(region: Region.current).date {
                        ZStack(alignment: .center) {
                            Image(uiImage: UIImage(named: "no_data_graph_up")!)
                                .padding(.all, 0)
                            VStack(alignment: .center, spacing: 8.0) {
                                
                                Text("Market is closed.\nLast known price for \(date.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.current))")
                                    .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                                    .font(UIFont.compactRoundedSemibold(14).uiFont)
                                    .multilineTextAlignment(.center)
                                
                                Text(metrics.lastKnownPrice?.price ?? "")
                                    .foregroundColor(UIColor(named: "mainText")!.uiColor)
                                    .font(UIFont.compactRoundedSemibold(24).uiFont)
                            }
                        }.padding(.leading, 8)
                    }
                    
                    //                    VStack {
                    //                        Spacer()
                    //                        HStack {
                    //                            Spacer()
                    //                            VStack {
                    //                                Text("Not enough data")
                    //                                    .foregroundColor(UIColor(named: "mainText")!.uiColor)
                    //                                    .font(UIFont.proDisplaySemibold(12).uiFont)
                    //                                Rectangle()
                    //                                    .fill(UIColor(named: "mainGreen")!.uiColor)
                    //                                    .frame(height: 2)
                    //                            }
                    //                            Spacer()
                    //                        }
                    //                        Spacer()
                    //                    }
                }
                //            VStack(alignment: .leading) {
                //                Spacer()
                //                HStack {
                //                    Text("Market closes in 15 MIN".uppercased())
                //                        .padding(.leading, 20)
                //                        .foregroundColor(Color(hex: "879095"s))
                //                        .font(UIFont.proDisplayRegular(9).uiFont)
                //                    Spacer()
                //                }
                //            }
                //            .opacity(isLeftDurationVis ? 1.0 : 0.0)
                //            .opacity(isMedianVisible ? 0.0 : 1.0)
                //            .padding(.bottom, -5)
            }
            .padding(.all, 0)
            .animation(.linear)
            .background(Rectangle().fill().foregroundColor(Color.white).opacity(0.01))
            .gesture(isMedianVisible ? nil : DragGesture(minimumDistance: 0)
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
    
    var compareLegend: some View {
        HStack(alignment: .center, spacing: 8.0) {
            Rectangle()
                .frame(width: 40, height: 1.5)
                .foregroundColor(UIColor(hexString: "0062FF")!.uiColor)
            Text("\(viewModel.compareTTFName)")
                .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                .font(UIFont.compactRoundedSemibold(12).uiFont)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .frame(height: 20)
        .opacity(isMedianVisible ? 1.0 : 0.0)
        .padding(.leading, 30)
        .offset(y: -16)
    }
    
    var bottomMedian: some View {
        HStack(spacing: 8) {
            //            Button(action: {
            //                hapticTouch.impactOccurred()
            //                delegate.comparePressed()
            //            }, label: {
            //                HStack {
            //                    Image("tiny plus")
            //                        .renderingMode(.original)
            //                    Text("Compare stocks")
            //                        .padding(.all, 0)
            //                        .font(UIFont.compactRoundedSemibold(12).uiFont)
            //                        .foregroundColor(UIColor(named: "mainText")!.uiColor)
            //                }
            //                .padding(.leading, 8)
            //                .padding(.trailing, 8)
            //                .padding(.top, 4)
            //                .padding(.bottom, 4)
            //                .background(Rectangle().fill(UIColor(hexString: "F7F8F9", alpha: 1.0)!.uiColor).cornerRadius(20))
            //            })
            
            Button(action: {
                isMedianVisible.toggle()
                viewModel.isSPPVisible = isMedianVisible
                lineViewModel.isSPYVisible = isMedianVisible
                hapticTouch.impactOccurred()
            }, label: {
                HStack(spacing: 4) {
                    Image(viewModel.isSPPVisible ? "toggle_on" : "toggle_off")
                        .renderingMode(.original)
                    Text("Compare to TTF")
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(12).uiFont)
                        .foregroundColor(isMedianVisible ? Color.white : UIColor(hexString: "#B1BDC8")!.uiColor)
                    Image(uiImage: UIImage(named:viewModel.localTicker.medianGrow >= 0 ? "small_up" : "small_down")!)
                        .resizable()
                        .frame(width: 8, height: 8)
                    Text("\(selectedTag == .d1 ? (viewModel.relatedCollection1DGain * 100.0).cleanOneDecimal : viewModel.localTicker.medianGrow.cleanOneDecimal)%".replacingOccurrences(of: "-", with: ""))
                        .foregroundColor(UIColor(named: viewModel.localTicker.medianGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                        .font(UIFont.proDisplaySemibold(12).uiFont)
                }
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .padding(.top, 4)
                .padding(.bottom, 4)
                .background(Rectangle().fill(viewModel.isSPPVisible ? UIColor.init(hexString: "0062FF")!.uiColor : UIColor(hexString: "F7F8F9", alpha: 1.0)!.uiColor).cornerRadius(8))
            })
            .opacity(viewModel.localTicker.haveMedian ? 1 : 0.0)
            
            
            Spacer()
        }
        .padding(.top, 8)
        .frame(height: 24)
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
//
//struct ScatterChartView_Previews: PreviewProvider {
//    static var previews: some View {
////        Group {
////            ScatterChartView().previewLayout(.fixed(width: 375, height: 812))
////            ScatterChartView().previewLayout(.fixed(width: 812, height: 375))
////                .environment(\.horizontalSizeClass, .compact)
////                .environment(\.verticalSizeClass, .compact)
////        }
//    }
//}
