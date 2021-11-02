//
//  WSRView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2021.
//

import SwiftUI


struct WSRView: View {
    init(totalScore: Float, priceTarget: Float, progress: [TickerInfo.WSRData.WSRDataDetails], lastAngle: Angle = .degrees(0)) {
        self.totalScore = totalScore
        self.priceTarget = priceTarget
        self.progress = progress
        self.lastAngle = .degrees(0)
    }
    
    let cirlceRadius: CGFloat = 119.0 / 2.0
    
    @State
    var pieData: [PieData] = []
    
    let totalScore: Float
    let priceTarget: Float
    let progress: [TickerInfo.WSRData.WSRDataDetails]
    
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
        return formatter.string(from: NSNumber(value: totalScore)) ?? ""
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
            
        }.fixedSize(horizontal: false, vertical: false)
            .onAppear(perform: {
                
                var lastAngle: Angle = .degrees(0.0)
                var colors = Array([UIColor(hexString: "009459")!.uiColor, UIColor(hexString: "2FDD97")!.uiColor, UIColor(hexString: "F3BD00")!.uiColor, UIColor(hexString: "FC5058")!.uiColor, UIColor(hexString: "C60009")!.uiColor].reversed())
                
                let totalCount = Double(progress.map(\.count).reduce(0, +))
                
                progress.forEach({
                    let progress = Double($0.count) / totalCount
                    pieData.append(PieData.init(startAngle: lastAngle,
                                                progress: progress,
                                                color: colors.popLast()!,
                                                name: $0.name,
                                                count: $0.count))
                    lastAngle = .degrees(lastAngle.degrees + (360 * progress))
                })
            })
            
            targetView
                .offset(x:8, y: 30)
        }
    }
    
    var totalText: String {
        let list = Array(["VERY BULLISH", "BULLISH", "NEUTRAL", "BEARISH", "VERY BEARISH"].reversed())
        let index = Int(round(totalScore)) - 1
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
                    Text("\(priceTarget.cleanTwoDecimal)$")
                        .foregroundColor(UIColor(hexString: "09141F")!.uiColor)
                        .font(UIFont.compactRoundedSemibold(15).uiFont)
                        .padding(.trailing, 8)
                    }
                }.background(Rectangle().cornerRadius(8.0).foregroundColor(UIColor(hexString: "F7F8F9")!.uiColor).frame(height: 32.0))
                    .frame(width: 156)
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
        WSRView(totalScore: 4.23, priceTarget: 113.86, progress: [])
    }
}
