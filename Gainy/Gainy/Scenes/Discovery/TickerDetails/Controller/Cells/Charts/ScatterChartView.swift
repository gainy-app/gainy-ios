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
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                }).frame(maxHeight: 40)
                
            }
            .background(UIColor.init(hexString: "F8FBFD")!.uiColor)
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
                    isMedianVisible.toggle()
                    hapticTouch.impactOccurred()
                }, label: {
                    HStack {
                            Image(isMedianVisible ? "toggle_on" : "toggle_off")
                                .renderingMode(.original)
                        Text("Industry median")
                            .padding(.all, 0)
                            .font(UIFont.proDisplayRegular(13).uiFont)
                            .foregroundColor(isMedianVisible ? Color.white : UIColor(named: "mainText")!.uiColor)
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .background(Rectangle().fill(isMedianVisible ? UIColor.init(hexString: "0062FF")!.uiColor : Color.white).cornerRadius(20))
                }).opacity(viewModel.localTicker.haveMedian ? 1 : 0.0)
                Button(action: {
                    hapticTouch.impactOccurred()
                }, label: {
                    HStack {
                        Image("tiny plus")
                            .renderingMode(.original)
                        Text("Compare")
                            .padding(.all, 0)
                            .font(UIFont.proDisplayRegular(13).uiFont)
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                    }
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .padding(.top, 4)
                    .padding(.bottom, 4)
                    .background(Rectangle().fill(Color.white).cornerRadius(20))
                })
                Spacer()
            }.padding(.leading, 20)
            .padding(.top, 8)
            .frame(height: 24)
            HStack {
                //Left median
                VStack(spacing: 2) {
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("MEDIAN")
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.proDisplaySemibold(9).uiFont)
                            .padding(.top, 2)
                            .frame(width: 40)
                        Text("\(viewModel.localTicker.medianGrow >= 0 ? "+" : "")\(viewModel.localTicker.medianGrow.cleanTwoDecimal)%")
                            .foregroundColor(UIColor(named: viewModel.localTicker.medianGrow >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                            .font(UIFont.proDisplaySemibold(11).uiFont)
                            .frame(width: 45)
                    }.frame(height: 12)
                        .frame(width: 70)
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("% Diff".uppercased())
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.proDisplaySemibold(9).uiFont)
                            .padding(.top, 2)
                            .frame(width: 40)
                        Text("\((statsDayValueRaw - viewModel.localTicker.medianGrow).cleanTwoDecimal)%")
                            .foregroundColor(UIColor(named: (statsDayValueRaw -  viewModel.localTicker.medianGrow) >= 0 ? "mainGreen" : "mainRed")!.uiColor)
                            .font(UIFont.proDisplaySemibold(11).uiFont)
                            .frame(width: 45)
                            
                    }.frame(height: 12)
                        .frame(width: 70)
                }.padding(.leading, 20)
                    .opacity(isMedianVisible && viewModel.localTicker.haveMedian ? 1.0 : 0.0)
                
                Spacer()
                //Right Stock price
                VStack(alignment: .trailing) {
                    HStack(alignment: .lastTextBaseline, spacing: 4) {
                        Text(statsDayName)
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.compactRoundedMedium(12).uiFont)
                            .padding(.top, 2)
                        Text(statsDayValue)
                            .foregroundColor(statsDayValue.hasPrefix("-") ? UIColor(named: "mainRed")!.uiColor : UIColor(named: "mainGreen")!.uiColor)
                            .font(UIFont.compactRoundedMedium(12).uiFont)
                    }.opacity(lineViewModel.hideHorizontalLines ? 0.0 : 1.0)
                    HStack {
                        Spacer()
                        Text(lineViewModel.hideHorizontalLines ? lineViewModel.currentDataValue : (viewModel.ticker.currentPrice.price))
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.compactRoundedMedium(20).uiFont)
                            .animation(.none)
                    }
                    
                }
                .padding(.trailing, 20)
                .offset(y: -25)
            }
        }
        .padding(.all, 0)
        .frame(height: 74)
        .animation(.easeIn)
    }
    
    private var statsDayName: String {
        switch selectedTag {
        case .d1:
            return "TODAY"
        case .w1:
            return "WEEK"
        case .m1:
            return "MONTH"
        case .m3:
            return "3M"
        case .y1:
            return "YEAR"
        case .y5:
            return "5Y"
        case .all:
            return "ALL"
            
        }
    }
    
    private var statsDayValue: String {
        switch selectedTag {
        case .d1:
            return viewModel.ticker.priceChangeToday.percentRaw
        default:
            return viewModel.chartData.startEndDiffString
        }
    }
    
    private var statsDayValueRaw: Float {
        switch selectedTag {
        case .d1:
            return viewModel.ticker.priceChangeToday
        default:
            return Float(viewModel.chartData.startEndDiff)
        }
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
        .background(Rectangle().fill().foregroundColor(UIColor(hexString: "F8FBFD")!.uiColor))
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
            ForEach(ChartPeriod.allCases, id: \.self) { tag in
                
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
