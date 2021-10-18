//
//  WSRView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2021.
//

import SwiftUI


struct WSRView: View {
    init(totalScore: Float, progress: [TickerInfo.WSRData.WSRDataDetails], lastAngle: Angle = .degrees(0)) {
        self.totalScore = totalScore
        self.progress = progress
        self.lastAngle = .degrees(0)
    }
    
    let cirlceRadius: CGFloat = 119.0 / 2.0
    
    @State
    var pieData: [PieData] = []
    
    let totalScore: Float
    let progress: [TickerInfo.WSRData.WSRDataDetails]
    
    struct PieData: Hashable {
        let startAngle: Angle
        let progress: Double
        let color: Color
        let name: String
        let count: Int
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
                        Spacer()
                        Text("\(curProgress.count)")
                            .foregroundColor(curProgress.color)
                            .font(UIFont.compactRoundedSemibold(15).uiFont)
                    }
                }
            }
            
        }.fixedSize(horizontal: false, vertical: false)
        .onAppear(perform: {
            
            var lastAngle: Angle = .degrees(0.0)
            var colors = [UIColor(hexString: "009459")!.uiColor, UIColor(hexString: "2FDD97")!.uiColor, UIColor(hexString: "FFD600")!.uiColor, UIColor(hexString: "FC5058")!.uiColor, UIColor(hexString: "C60009")!.uiColor, UIColor(hexString: "009459")!.uiColor]
            
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
    }
    
    var totalText: String {
        let list = ["VERY BULLISH", "BULLISH", "NEUTRAL", "BEARISH", "VERY BEARISH"]
        let index = Int(round(totalScore)) - 1
        return index >= 0 && index <= 4 ? list[index] : ""
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
        WSRView(totalScore: 4.23, progress: [])
    }
}
