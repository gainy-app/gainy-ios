//
//  CompareScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.08.2021.
//

import SwiftUI
import SwiftDate

struct ChartCompareData: Identifiable {
    
    var id: String {
        symbol
    }
    
    let symbol: String
    let growth: Double
    //var chartData: ChartData
}

final class CompareScatterChartViewModel: ObservableObject {
    
    @Published
    var comparableStocks: [ChartCompareData] = [] {
        didSet {
            dprint("set")
        }
    }
    
    init(comparableStocks: [ChartCompareData]) {
        self.comparableStocks = comparableStocks
    }
}

struct CompareScatterChartView: View {
    
    @ObservedObject
    var viewModel: CompareScatterChartViewModel
    
    @ObservedObject
    var delegate: ScatterChartDelegate
    
    @State
    private var selectedTag: ScatterChartView.ChartPeriod = .d1 {
        didSet {
            isLeftDurationVis = selectedTag == .d1
            delegate.range = selectedTag
            hapticTouch.impactOccurred()
        }
    }
    
    @State
    private var isLeftDurationVis: Bool = true
    
    var body: some View {
        GeometryReader(content: { rootGeo in
            VStack(alignment: .leading) {
                headerView
                Spacer()
                chartView
                    .offset(y: -80)
                    .padding(.leading, 8)
                    .padding(.trailing, 8)
                    .frame(height: 145)
                Spacer()
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
            ForEach(viewModel.comparableStocks) { stock in
                HStack(alignment: .center, spacing: 16) {
                    Text(stock.symbol)
                        .foregroundColor(UIColor(hexString: "#3A4448")!.uiColor)
                        .font(UIFont.proDisplayRegular(14).uiFont)
                        .padding(.top, 2)
                    Text(stock.growth.percentRaw)
                        .foregroundColor(UIColor(hexString: "#1F2E35")!.uiColor)
                        .font(UIFont.compactRoundedSemibold(14).uiFont)
                }
            }
        }
        .padding(.all, 0)
        .padding(.top, 28)
        .padding(.leading, 28)
        .frame(height: 48.0 + 16.0)
    }
    
    @ObservedObject
    var lineViewModel = LineViewModel()
    
    private var chartView: some View {
        GeometryReader{ geometry in
            ZStack {
                ZStack {
                    ForEach((0..<viewModel.comparableStocks.count).reversed(), id: \.self) { stockIdx in
                        LineView(data: ChartData(points: [18,54,23,32,42,37,7,53,63].shuffled()), title: "Full chart", style: stockIdx == 0 ? Styles.lineChartStyleDrop : Styles.lineChartStyleMedian, viewModel: lineViewModel)
                    }
                }
                .padding(.all, 0)
                .animation(.linear)
            }
        }.onAppear {
            lineViewModel.showCloseLine = false
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
