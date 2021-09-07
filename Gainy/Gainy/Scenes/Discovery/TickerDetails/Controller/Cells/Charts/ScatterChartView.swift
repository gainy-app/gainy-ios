//
//  ScatterChartView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 24.08.2021.
//

import SwiftUI

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
    
    /// Bottom range tags
    private let tags: [String] = ["1D", "1W", "1M", "3M", "1Y", "5Y", "ALL"]
    
    
    @State
    private var selectedTag: String = "1D" {
        didSet {
            isLeftDurationVis = selectedTag == "1D"
        }
    }
    
    @State
    private var isMedianVisible: Bool = false
    
    @State
    private var isLeftDurationVis: Bool = true
    
    var body: some View {
        GeometryReader(content: { rootGeo in
            VStack {
                headerView
                chartView
                GeometryReader(content: { geometry in
                    bottomMenu(geometry)
                }).frame(maxHeight: 40)
                
            }
            .background(UIColor.init(hexString: "F8FBFD")!.uiColor)
        })
    }
    
    //MARK:- Body sections
    
    private var headerView: some View {
        VStack {
            HStack(spacing: 8) {
                Button(action: {
                    isMedianVisible.toggle()
                }, label: {
                    HStack {
                        Image(isMedianVisible ? "toggle_on" : "toggle_off")
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
                })
                Button(action: {
                    
                }, label: {
                    HStack {
                        Image("tiny plus")
                        Text("Compare stocks")
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
                HStack(alignment: .center, spacing: 2) {
                    Text("MEDIAN")
                        .foregroundColor(UIColor(named: "mainText")!.uiColor)
                        .font(UIFont.proDisplayRegular(9).uiFont)
                        .padding(.top, 2)
                    Text("+2.34%")
                        .foregroundColor(UIColor(named: "mainText")!.uiColor)
                        .font(UIFont.proDisplayRegular(11).uiFont)
                }.padding(.leading, 20)
                .opacity(isMedianVisible ? 1.0 : 0.0)
                
                Spacer()
                //Right Stock price
                VStack {
                    Text("$93.05")
                        .foregroundColor(Color(hex: "FC5058"))
                        .font(UIFont.compactRoundedMedium(20).uiFont)
                    HStack(alignment: .center, spacing: 2) {
                        Text("TODAY")
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.compactRoundedRegular(9).uiFont)
                            .padding(.top, 2)
                        Text("-2.42%")
                            .foregroundColor(UIColor(named: "mainText")!.uiColor)
                            .font(UIFont.compactRoundedRegular(11).uiFont)
                    }
                }
                .padding(.trailing, 20)
            }
        }
        .padding(.all, 0)
        .frame(height: 74)
        .animation(.easeIn)
    }
    
    private var chartView: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text("Market closes in 15 MIN".uppercased())
                        .padding(.leading, 20)
                        .foregroundColor(Color(hex: "879095"))
                        .font(UIFont.proDisplayRegular(9).uiFont)
                    Spacer()
                }
            }
            .opacity(isLeftDurationVis ? 1.0 : 0.0)
            .opacity(isMedianVisible ? 0.0 : 1.0)
            .padding(.bottom, 10)
            
            LineView(data: [8,23,54,32,12,37,7,23,43], title: "Full chart", style: Styles.lineChartStyleOne).background(Rectangle().stroke())
            
            //ScatterChart(symbolColor: Color(hex: "FC5058"), isMedianVisible: $isMedianVisible, selectedTag: $selectedTag)
            //ScatterChart(symbolColor: Color(hex: "0062FF"), isMedianVisible: $isMedianVisible, selectedTag: $selectedTag)
             //   .opacity(isMedianVisible ? 1.0 : 0.0)
        }
        .padding(.all, 0)
        .animation(.linear)
    }
    
    private func bottomMenu(_ geometry: GeometryProxy) -> some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(tags, id: \.self) { tag in
                
                Button(action: {
                    selectedTag = tag
                }, label: {
                    ZStack {
                        Rectangle()
                            .fill(tag == selectedTag ? Color.selectorColor : Color.clear)
                            .cornerRadius(16.0)
                            .frame(height: 24)
                            .frame(minWidth: 48)
                        Text(tag)
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

struct ScatterChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScatterChartView().previewLayout(.fixed(width: 375, height: 812))
            ScatterChartView().previewLayout(.fixed(width: 812, height: 375))
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .compact)
        }
    }
}