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
            print("set")
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
                headerView.background(Rectangle().stroke().foregroundColor(.red))
                //chartView
                //    .padding(.leading, 8)
                //    .padding(.trailing, 8)
                GeometryReader(content: { geometry in
                    bottomMenu(geometry).background(Rectangle().stroke())
                }).frame(maxHeight: 40)
                
            }
            .background(UIColor.init(hexString: "F8FBFD")!.uiColor)
        }).onAppear(perform: {
            hapticTouch.prepare()
        }).background(Rectangle().stroke())
    }
    //MARK:- Haptics
    private let hapticTouch = UIImpactFeedbackGenerator()
    
    //MARK:- Body sections
    
    private var headerView: some View {
        VStack {
            ForEach(viewModel.comparableStocks) { stock in
                HStack(alignment: .center, spacing: 16) {
                    Text(stock.symbol)
                        .foregroundColor(UIColor(named: "mainText")!.uiColor)
                        .font(UIFont.proDisplayRegular(14).uiFont)
                        .padding(.top, 2)
                    Text("\(stock.growth.percent)")
                        .foregroundColor(UIColor(named: "mainText")!.uiColor)
                        .font(UIFont.compactRoundedSemibold(14).uiFont)
                }
            }
        }
        .padding(.all, 0)
        .padding(.top, 28)
        .padding(.leading, 28)
        .frame(height: 48.0 + 16.0)
    }
    
    private var chartView: some View {
        ZStack {
            ForEach(viewModel.comparableStocks) { stock in                
                LineView(data: ChartData(points: [18,54,23,32,42,37,7,53,63].shuffled()), title: "Full chart", style: Styles.lineChartStyleDrop, isMedianVisible: .constant(false)).offset(y: -40)
            }
        }
        .padding(.all, 0)
        .animation(.linear)
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
