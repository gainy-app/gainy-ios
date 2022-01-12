//
//  WSRView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2021.
//

import SwiftUI
import Combine

class WSRViewModel: ObservableObject {
    
    @Published
    var totalScore: Float
    
    @Published
    var priceTarget: Float
    
    @Published
    var progress: [TickerInfo.WSRData.WSRDataDetails] {
        didSet {
            progressUpdate.send()
        }
    }
    
    var progressUpdate: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    init(totalScore: Float, priceTarget: Float, progress: [TickerInfo.WSRData.WSRDataDetails]) {
        self.totalScore = totalScore
        self.priceTarget = priceTarget
        self.progress = progress
    }
}

struct WSRView: View {
    init(viewModel: WSRViewModel) {
        self.viewModel = viewModel
    }
    
    let cirlceRadius: CGFloat = 119.0 / 2.0
    
    @State
    var pieData: [PieData] = []
    
    @ObservedObject
    var viewModel: WSRViewModel
    
    struct PieData: Hashable {
        let startAngle: Angle
        let progress: Double
        let color: Color
        let name: String
        let count: Int
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
        static func == (lhs: PieData, rhs: PieData) -> Bool {
            return lhs.name == rhs.name
        }
    }
    
    private var lastAngle: Angle = .degrees(0)
    
    private var totalPriceString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .halfUp
        return formatter.string(from: NSNumber(value: viewModel.totalScore)) ?? ""
    }
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    ForEach(pieData, id: \.self) { pie in
                        ArcShape(startAngle: pie.startAngle,
                                 partialProgress: pie.progress
                        ).fill(pie.color).frame(width: 119, height: 119)
                    }.scaleEffect(CGSize(width: 1.0, height: -1.0))
                    
                    VStack {
                        Text("\(totalPriceString)")
                            .foregroundColor(UIColor(hexString: "25C685")!.uiColor)
                            .font(UIFont.compactRoundedSemibold(28).uiFont)
                        Text(totalText)
                            .foregroundColor(UIColor(hexString: "25C685")!.uiColor)
                            .font(UIFont.compactRoundedRegular(11).uiFont)
                    }
                }
                .frame(width: 119, height: 119)
                .offset(y: 32)
                
                Spacer().frame(width: 62)
                VStack(alignment: .center, spacing: 10) {
                    ForEach(pieData, id: \.self) { curProgress in
                        HStack {
                            Text(curProgress.name)
                                .foregroundColor(UIColor(hexString: "687379")!.uiColor)
                                .font(UIFont.compactRoundedRegular(11).uiFont)
                                .frame(height: 16)
                            Spacer()
                            Text("\(curProgress.count)")
                                .foregroundColor(curProgress.color)
                                .font(UIFont.compactRoundedSemibold(15).uiFont)
                                .frame(height: 16)
                        }
                    }
                }
                
            }
            .fixedSize(horizontal: false, vertical: false)
            .onAppear(perform: {
                DispatchQueue.main.async {
                    self.loadStats()
                }
            })
            targetView
                .offset(x:8, y: 30)
        }.onReceive(viewModel.progressUpdate) { _ in
            DispatchQueue.main.async {
                self.loadStats()
            }
        }
    }
    
    func loadStats() {
        var lastAngle: Angle = .degrees(0.0)
        var colors = Array([UIColor(hexString: "009459")!.uiColor, UIColor(hexString: "2FDD97")!.uiColor, UIColor(hexString: "F3BD00")!.uiColor, UIColor(hexString: "FC5058")!.uiColor, UIColor(hexString: "C60009")!.uiColor].reversed())
        
        let totalCount = Double(viewModel.progress.map(\.count).reduce(0, +))
        
        pieData.removeAll()
        
        var pieDataList: [PieData] = []
        for val in viewModel.progress {
            let progress = Double(val.count) / totalCount
            
            pieDataList.append(PieData.init(startAngle: lastAngle,
                                        progress: progress,
                                        color: colors.popLast()!,
                                        name: val.name,
                                        count: val.count))
            lastAngle = .degrees(lastAngle.degrees + (360 * progress))
        }
        pieData.append(contentsOf: pieDataList)
    }
    
    var totalText: String {
        let list = Array(["VERY BULLISH", "BULLISH", "NEUTRAL", "BEARISH", "VERY BEARISH"].reversed())
        let index = Int(round(viewModel.totalScore)) - 1
        return index >= 0 && index <= 4 ? list[index] : ""
    }
    
    var targetView: some View {
        HStack(spacing: 0.0) {
            Spacer()
            VStack(spacing: 0.0) {
                Spacer()
                ZStack {
                    HStack(spacing: 0.0)  {
                        Text("PRICE TARGET")
                            .foregroundColor(UIColor(hexString: "687379")!.uiColor)
                            .font(UIFont.compactRoundedRegular(11).uiFont)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    
                    HStack(spacing: 0.0)  {
                        Spacer()
                        Text("\(viewModel.priceTarget.cleanTwoDecimal)$")
                            .foregroundColor(UIColor(hexString: "09141F")!.uiColor)
                            .font(UIFont.compactRoundedSemibold(15).uiFont)
                            .padding(.trailing, 8)
                    }
                }.background(Rectangle().cornerRadius(8.0).foregroundColor(UIColor(hexString: "F7F8F9")!.uiColor).frame(height: 32.0))
                    .frame(width: 168)
                    .frame(height: 32.0)
            }
        }
    }
}

struct ArcShape : Shape {
    
    let startAngle: Angle
    let partialProgress: Double
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.addArc(center: CGPoint(x: rect.width / 2.0, y:rect.width / 2.0), radius: rect.width / 2.0, startAngle: startAngle, endAngle: .degrees(startAngle.degrees + (360.0 * partialProgress)), clockwise: false)
        return p.strokedPath(.init(lineWidth: 6, lineCap: .square, lineJoin: .bevel))
    }
}

struct WSRView_Previews: PreviewProvider {
    static var previews: some View {
        WSRView(viewModel: WSRViewModel.init(totalScore: 4.45, priceTarget: 85.56, progress: []))
    }
}
