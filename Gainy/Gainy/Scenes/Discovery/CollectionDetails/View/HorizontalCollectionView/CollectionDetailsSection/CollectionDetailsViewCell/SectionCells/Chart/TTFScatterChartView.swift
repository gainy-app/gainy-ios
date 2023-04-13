//
//  TTFScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.04.2022.
//

import SwiftUI
import SwiftDate
import ActivityIndicatorView
import AnimatedImage

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
    private var selectedTag: ScatterChartView.ChartPeriod = .w1 {
        didSet {
            //guard  lineViewModel.chartPeriod != selectedTag else {return}
            //            isSPPVisible = false
            //            lineViewModel.isSPYVisible = false
            lineViewModel.chartPeriod = selectedTag
            isLeftDurationVis = selectedTag == .d1
            lineViewModel.showCloseLine = true
            delegate.changeRange(range: selectedTag, viewModel: viewModel)
            hapticTouch.impactOccurred()
        }
    }
    
    @State
    private var isSPPVisible: Bool = false {
        didSet {
            viewModel.isSPPVisible = isSPPVisible
            lineViewModel.isSPYVisible = isSPPVisible
            if isSPPVisible {
                GainyAnalytics.logEventAMP("ttf_chart_period_sp500_tapped", params: ["collectionID" : viewModel.collectionID, "period" : selectedTag.rawValue])
            }
        }
    }
    
    @State
    private var isLeftDurationVis: Bool = true
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack {
                ZStack {
                    
                    if !viewModel.isLoading {
                        chartView
                            .offset(y: -20)
                    } else {
                        ActivityIndicatorView()
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(height: 240)
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                        .opacity(viewModel.isLoading ? 0.0 : 1.0)
                        .offset(y: 50)
                })
            }
            .onAppear(perform: {
                hapticTouch.prepare()
            })
            .onChange(of: viewModel.isSPPVisible, perform: { newValue in
                isSPPVisible = newValue
                lineViewModel.isSPYVisible = newValue
            })
            .onChange(of: viewModel.selectedTag, perform: { newValue in
                selectedTag = newValue
            })
            .frame(height: 256 + 90.0)
            .ignoresSafeArea()
            .padding(.top, 0)
            .padding(.leading, 0)
            .padding(.trailing, 0)
            .onChange(of: viewModel.lastDayPrice) { newValue in
                lineViewModel.lastDayPrice = newValue
            }
        } else {
            VStack {
                ZStack {
                    chartView
                        .frame(height: 240)
                        .offset(y: -20)
                        .activityIndicator(isVisible: viewModel.isLoading)
                }
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                        .opacity(viewModel.isLoading ? 0.0 : 1.0)
                        .offset(y: 50)
                })
            }
            .background(RemoteConfigManager.shared.mainBackColor.uiColor)
            .onAppear(perform: {
                hapticTouch.prepare()
            })
            .frame(height: 256 + 90.0)
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
    
    private var isChartGrows: Bool {
        //        if selectedTag == .d1 {
        return viewModel.dayGrow >= 0.0
        //        }
        //        return viewModel.chartData.startEndDiff >= 0.0
    }
    
    @ObservedObject
    var lineViewModel: LineViewModel = LineViewModel(chartPeriod: .m1, minMaxPercent: true)
    
    private let chartHeight: CGFloat = 147.0
    private let chartOffset: CGFloat = 0.0
    
    private var disclaimerView: some View {
        VStack {
            HStack {
                Button {
                    delegate.openDisclaimer()
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: 24.0, height: 24.0)
                            .cornerRadius(8.0)
                        Image("chart_disc_btn")
                            .resizable()
                            .frame(width: 16.0, height: 16.0)
                        
                        //                        AnimatedImage(data: gemData)
                        //                            .frame(width: 16.0, height: 16.0)
                        //                            .scaledToFit()
                    }.padding(0)
                }
                .frame(width: 24.0, height: 24.0)
                Spacer()
            }.padding(0)
            Spacer()
        }
        .padding(0)
        .padding(.leading, 24)
        .offset(y: -8)
    }
    
    private var gemData: Data {
        NSDataAsset(name: "gem")!.data
    }
    
    private var chartView: some View {
        GeometryReader{ geometry in
            ZStack {
                if viewModel.isMarketJustOpened && selectedTag == .d1 {
                    marketJustOpened
                        .frame(height: 300)
                } else {
                    if viewModel.chartData.onlyPoints().uniqued().count > 2 {
                        LineView(data: viewModel.chartData,
                                 title: "Full chart",
                                 style: isChartGrows ? Styles.lineChartStyleGrow : Styles.lineChartStyleDrop,
                                 viewModel: lineViewModel,
                                 minDataValue: viewModel.min,
                                 maxDataValue: viewModel.max,
                                 chartHeight: 240.0
                        )
                    }  else {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Not enough data")
                                    .foregroundColor(UIColor(named: "mainText")!.uiColor)
                                    .font(UIFont.proDisplaySemibold(12).uiFont)
                                    .onAppear {
                                        if !viewModel.isLoading && viewModel.collectionID > 0  {
                                            GainyAnalytics.logEventAMP("ttf_not_enough_data_shown")
                                        }
                                    }
                                Spacer()
                            }
                            Spacer()
                        }
                        .opacity(viewModel.isLoading ? 0.0 : 1.0)
                    }
                    if viewModel.sypChartData.points.count > 2 {
                        LineView(data: viewModel.sypChartData,
                                 title: Constants.Chart.sypChartName,
                                 style: Styles.lineChartStyleMedian,
                                 viewModel: lineViewModel,
                                 minDataValue: viewModel.min,
                                 maxDataValue: viewModel.max,
                                 chartHeight: 240.0)
                        .opacity(lineViewModel.isSPYVisible ? 1.0 : 0.0)
                    }
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
                    viewModel.dragActive = true
                    delegate.dragOnChartChanged(showDiff: true, diffVal: viewModel.currentDataDiff)
                })
                    .onEnded({ value in
                        lineViewModel.opacity = 0
                        lineViewModel.hideHorizontalLines = false
                        lineViewModel.indicatorLocation = .zero
                        viewModel.dragActive = false
                        delegate.dragOnChartChanged(showDiff: false, diffVal: viewModel.currentDataDiff)
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
            viewModel.currentDataDiff = viewModel.chartData.startEndDiff(to: index)
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
                    Image(viewModel.isSPPVisible  ? "toggle_on" : "toggle_off")
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
            .background(Rectangle().fill(viewModel.isSPPVisible  ? UIColor.init(hexString: "0062FF")!.uiColor : UIColor(hexString: "F7F8F9", alpha: 1.0)!.uiColor).cornerRadius(8))
            Spacer()
        }
    }
    
    private func bottomMenu(_ geometry: GeometryProxy) -> some View {
        HStack(alignment: .center, spacing: 4) {
            ForEach(ScatterChartView.ChartPeriod.allCases, id: \.self) { tag in
                Button(action: {
                    selectedTag = tag
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(tag == lineViewModel.chartPeriod ? Color.selectorColor : Color.clear)
                            .cornerRadius(8.0)
                            .frame(height: 24)
                            .frame(minWidth: 48)
                            .padding(.all, 0)
                        Text(tag.rawValue)
                            .foregroundColor(tag == lineViewModel.chartPeriod ? Color.white : Color.textColor)
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


