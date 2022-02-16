//
//  HoldingViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import UIKit

struct HoldingViewModel {
    let matchScore: Int
    let name: String
    let balance: Float
    let tickerSymbol: String
    
    
    let industries: [RemoteTickerDetailsFull.TickerIndustry]
    let categories: [RemoteTickerDetailsFull.TickerCategory]
    
    let showLTT: Bool
    
    let todayPrice: Float
    let todayGrow: Float
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    let percentInProfile: Float
    
    let securities: [HoldingSecurityViewModel]
    let securityTypes: [String]
    
    let holdingDetails: GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Detail?
    
    let event: String?
    
    let accountIds: [Int]
    let tickerInterests: [Int]
    let tickerCategories: [Int]
    let rawTicker: RemoteTickerDetailsFull?
    
    var isCash: Bool {
        tickerSymbol.hasPrefix("CUR")
    }
    
    func infoForRange(_ range: ScatterChartView.ChartPeriod) -> (String, UIImage, String, String, UIColor?, UIColor?) {
        if isCash {
            return ("", UIImage(), "", "", .clear, .clear)
        } else {
            return (range.longName,
                    UIImage(named: relativeGains[range] ?? 0.0 >= 0.0 ?  "small_up" : "small_down")!,
                    absoluteGains[range]?.priceRaw ?? "",
                    (relativeGains[range]?.cleanTwoDecimalP ?? "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: ""),
                    relativeGains[range] ?? 0.0 >= 0.0 ? UIColor(named: "mainGreen") :  UIColor(named: "mainRed"),
                    relativeGains[range] ?? 0.0 >= 0.0 ? UIColor(named: "mainGreen") :  UIColor(named: "mainRed"))
        }
    }
    
    //Height calc
    func heightForState(range: ScatterChartView.ChartPeriod, isExpaned: Bool) -> CGFloat {
        let eventHeight: CGFloat = 16.0 + 32.0
        if isExpaned {
            let secHeight: CGFloat = Double(securities.count) * 80.0 + Double(securities.count - 1) * 8.0
            var height = 184.0 + secHeight + 16.0 + 16.0
            if isCash {
                return 112.0 + secHeight + 16.0 + 16.0
            }
            if event != nil {
                height += eventHeight
            }
            return height + 8.0
        } else {
            
            if isCash {
                return 112.0 + 16.0
            }
            if event != nil {
                return 232.0 + 22.0
            } else {
                return 184.0 + 22.0
            }
            
        }
    }
    
    var holdingsCount: NSMutableAttributedString {
        guard !isCash else { return NSMutableAttributedString.init(string: "") }
        var secCount: [HoldingSecurityViewModel.SecType : Float] = [:]
        for sec in securities {
            if let haveCount = secCount[sec.type] {
                secCount[sec.type] = haveCount + sec.quantity
            } else {
                secCount[sec.type] = sec.quantity
            }
        }
        
        var attrArr: [NSMutableAttributedString] = []
        for key in secCount.keys {
            attrArr.append(key.rawValue.attr(font: .compactRoundedSemibold(14.0),
                                             color: .init(hexString: "B1BDC8", alpha: 1.0)!) + " ×\(secCount[key]!)".attr(font: .compactRoundedSemibold(14.0),
                                                                                                                          color: .init(hexString: "09141F", alpha: 1.0)!))
        }
        let totalList = NSMutableAttributedString.init(string: "")
        for share in attrArr {
            totalList.append(share)
            totalList.append(" ".attr())
        }
        return totalList
    }
}

extension HoldingViewModel: Equatable {
    static func == (lhs: HoldingViewModel, rhs: HoldingViewModel) -> Bool {
        lhs.name == rhs.name
    }
    
    
}

extension HoldingViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.name)
        hasher.combine(self.tickerSymbol)
        hasher.combine(self.matchScore)
    }
}
