//
//  HoldingViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import UIKit
import GainyAPI

struct HoldingViewModel {
    let matchScore: Int
    let name: String
    let balance: Float
    let tickerSymbol: String
    let type: SecType
    
    let tickerTags: [TickerTag]
    
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
    
    let brokerIds: [String]
    let accountIds: [Int]
    let tickerInterests: [Int]
    let tickerCategories: [Int]
    let rawTicker: RemoteTickerDetailsFull?
    
    var isCash: Bool {
        type == .cash
    }
    
    var isCrypto: Bool {
        tickerSymbol.hasSuffix(".CC")
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
    
    func tagsHeight(isExpanded: Bool) -> CGFloat {
        let tagHeight: CGFloat = 24.0
        let margin: CGFloat = 8.0
        
        let totalWidth: CGFloat = UIScreen.main.bounds.width - 80.0 - 64.0
        var xPos: CGFloat = 0.0
        var yPos: CGFloat = 0.0
        var lines: Int = 1
        
        var subCount: Int = 0
        for tag in tickerTags {
            let width = (tag.url.isEmpty ? 8.0 : 26.0) + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(12)) + margin
            if xPos + width + margin > totalWidth && subCount > 0 {
                xPos = 0.0
                yPos = yPos + tagHeight + margin
                lines += 1
            }
            xPos += width + margin
            subCount += 1
        }
        if lines <= 2 {
            return -tagHeight + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
        } else {
            if isExpanded {
                return -tagHeight + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
            } else {
                return -tagHeight + tagHeight * CGFloat(2) + margin * CGFloat(1)
            }
        }
        
    }
    
    //Height calc
    func heightForState(range: ScatterChartView.ChartPeriod, isExpaned: Bool, isTagExpanded: Bool) -> CGFloat {
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
            return height + 8.0 + tagsHeight(isExpanded: isTagExpanded)
        } else {
            if isCash {
                return 112.0 + 16
            }
            if event != nil {
                return 232.0 + 22.0 + tagsHeight(isExpanded: isTagExpanded)
            } else {
                return 184.0 + 22.0 + tagsHeight(isExpanded: isTagExpanded)
            }
            
        }
    }
    
    var holdingsCount: NSMutableAttributedString {
        guard !isCash else { return NSMutableAttributedString.init(string: "") }
        var secCount: [SecType : Float] = [:]
        for sec in securities {
            if let haveCount = secCount[sec.type] {
                secCount[sec.type] = haveCount + sec.quantity
            } else {
                secCount[sec.type] = sec.quantity
            }
        }
        
        
        var attrArr: [NSMutableAttributedString] = []
        for key in secCount.keys {
            attrArr.append(key.name.attr(font: .compactRoundedSemibold(14.0),
                                             color: .init(hexString: "B1BDC8", alpha: 1.0)!) + " ×".attr(font: .compactRoundedSemibold(12.0),
                                                                                                         color: .init(hexString: "09141F", alpha: 1.0)!) + "\(secCount[key]!)".attr(font: .compactRoundedSemibold(14.0),
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
