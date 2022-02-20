//
//  ScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.08.2021.
//

import SwiftUI
import SwiftDate

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
    static let selectorColor = Color.init(hex: "3A4448")
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
            lineViewModel.chartPeriod = selectedTag
            isLeftDurationVis = selectedTag == .d1
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
        GeometryReader(content: { rootGeo in
            VStack {
                headerView
                chartView
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.top, 20)
                bottomMedian
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
        
        ZStack {
            HStack(spacing: 0) {
                //Right Stock price
                VStack(alignment: .trailing, spacing: 0) {
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
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
                        Spacer()
                    }.opacity(lineViewModel.hideHorizontalLines ? 0.0 : 1.0)
                    HStack {
                        Text(lineViewModel.hideHorizontalLines ? lineViewModel.currentDataValue : (viewModel.ticker.currentPrice.price))
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.compactRoundedSemibold(24.0).uiFont)
                            .animation(.none)
                        
                        Spacer()
                    }
                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("MEDIAN")
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.proDisplaySemibold(9).uiFont)
                            .padding(.top, 2)
                        Image(uiImage: UIImage(named:viewModel.localTicker.medianGrow >= 0 ? "small_up" : "small_down")!)
                            .resizable()
                            .frame(width: 8, height: 8)
                        Text("\(viewModel.localTicker.medianGrow.cleanTwoDecimal)%".replacingOccurrences(of: "-", with: ""))
                            .foregroundColor(UIColor(named: viewModel.localTicker.medianGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                            .font(UIFont.proDisplaySemibold(11).uiFont)
                        Spacer()
                    }
                    .opacity(isMedianVisible && viewModel.localTicker.haveMedian ? 1.0 : 0.0)
                    
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
                    LineView(data: viewModel.chartData, title: "Full chart", style: statsDayValueRaw >= 0.0 ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop, viewModel: lineViewModel).offset(y: -60)
                    
                    if isMedianVisible && viewModel.localTicker.haveMedian &&  viewModel.medianData.onlyPoints().uniqued().count > 1 {
                        LineView(data: viewModel.medianData, title: "Full chart", style: viewModel.medianData.startEndDiff >= 0.0 ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop, viewModel: lineViewModel).offset(y: -60)
                    }
                } else {
                    //no_data_graph_down
                    if let metrics = viewModel.ticker.realtimeMetrics, let date =  ((metrics.lastKnownPriceDatetime ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()).convertTo(region: Region.current).date {
                        ZStack {
                            Image(uiImage: UIImage(named: "no_data_graph_up")!)
                            VStack(spacing: 8.0) {
                                
                            Text("Market is closed.\nLast known price for \(date.toRelative(style: RelativeFormatter.defaultStyle(), locale: Locales.current))")
                                .foregroundColor(UIColor(hexString: "B1BDC8", alpha: 1.0)!.uiColor)
                                .font(UIFont.compactRoundedSemibold(14).uiFont)
                                .multilineTextAlignment(.center)
                                
                                Text(metrics.lastKnownPrice?.price ?? "")
                                    .foregroundColor(UIColor(named: "mainText")!.uiColor)
                                    .font(UIFont.compactRoundedSemibold(24).uiFont)
                            }
                        }
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
                hapticTouch.impactOccurred()
            }, label: {
                HStack {
                    Image(isMedianVisible ? "toggle_on" : "toggle_off")
                        .renderingMode(.original)
                    Text("Industry median")
                        .padding(.all, 0)
                        .font(UIFont.compactRoundedSemibold(12).uiFont)
                        .foregroundColor(isMedianVisible ? Color.white : UIColor(named: "mainText")!.uiColor)
                }
                .padding(.leading, 8)
                .padding(.trailing, 8)
                .padding(.top, 4)
                .padding(.bottom, 4)
                .background(Rectangle().fill(isMedianVisible ? UIColor.init(hexString: "0062FF")!.uiColor : UIColor(hexString: "F7F8F9", alpha: 1.0)!.uiColor).cornerRadius(20))
            })
                .opacity(viewModel.localTicker.haveMedian ? 1 : 0.0)
            
            
            Spacer()
        }.padding(.leading, 20)
            .padding(.top, 8)
            .frame(height: 24)
    }
    
    private func bottomMenu(_ geometry: GeometryProxy) -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(ChartPeriod.allCases, id: \.self) { tag in
                
                Button(action: {
                    selectedTag = tag
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(tag == selectedTag ? UIColor(hexString: "09141F", alpha: 1.0)!.uiColor : Color.clear)
                            .cornerRadius(16.0)
                            .frame(height: 24)
                            .frame(minWidth: 48)
                        Text(tag.rawValue)
                            .foregroundColor(tag == selectedTag ? Color.white : UIColor(hexString: "09141F", alpha: 1.0)!.uiColor)
                            .font(UIFont.compactRoundedMedium(12).uiFont)
                    }
                    .animation(.easeIn)
                }).frame(width: widthForGeometry(geometry), height: 20)
            }
        }.padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 16)
    }
    
    private func widthForGeometry(_ geometry: GeometryProxy) -> CGFloat {
        48
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
