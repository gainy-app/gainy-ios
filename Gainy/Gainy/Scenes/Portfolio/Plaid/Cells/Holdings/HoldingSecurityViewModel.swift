//
//  HoldingSecurityViewModel.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.11.2021.
//

import Foundation
import UIKit
import GainyAPI

struct HoldingSecurityViewModel {
    
    enum SecType: String {
        case option = "Option", share = "Shares", cash = "Cash", crypto = "Crypto", etf = "ETF"
        
        var name: String {
            switch self {
            case .option:
                return "Option"
            case .share:
                return "Shares"
            case .cash:
                return "Cash"
            case .crypto:
                return "Coins"
            case .etf:
                return "ETF"
            }
        }
    }
    
    let name: NSAttributedString
    let type: SecType
    let percentInHolding: Float
    let totalPrice: Float
    let quantity: Float
    
    let singlePrice: String
    
    let absoluteGains: [ScatterChartView.ChartPeriod : Float]
    let relativeGains: [ScatterChartView.ChartPeriod : Float]
    
    func infoForRange(_ range: ScatterChartView.ChartPeriod) -> (String, UIImage, String, String, UIColor?, UIColor?) {
        return (range.longName, UIImage(named: relativeGains[range] ?? 0.0 >= 0.0 ?  "small_up" : "small_down")!,
                absoluteGains[range]?.priceRaw ?? "",
                (relativeGains[range]?.cleanTwoDecimalP ?? "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "+", with: ""),
                relativeGains[range] ?? 0.0 >= 0.0 ? UIColor(named: "mainGreen") :  UIColor(named: "mainRed"),
                relativeGains[range] ?? 0.0 >= 0.0 ? UIColor(named: "mainGreen") :  UIColor(named: "mainRed"))
        
    }
    
    init(holding: GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Holding) {
        let rawType = holding.holdingDetails?.securityType ?? ""
        if rawType == "derivative" {
            type = .option
        } else {
            if rawType == "equity" {
                type = .share
            } else {
                if rawType == "crypto" {
                    type = .crypto
                } else {
                    if rawType == "etf" {
                        type = .share
                    } else {
                        type = .cash
                    }
                }
            }
        }
        let correctName = (type == .option ? holding.lovelyTitle.companyMarkRemoved  : type.name)
        
        let accountID =  (UserProfileManager.shared.linkedPlaidAccounts.first(where: {
            $0.institutionID == (holding.holdingDetails?.holding?.accessToken?.institution?.id ?? 0)
        })?.name ?? (holding.name ?? ""))
        
        self.name = (type == .cash ? accountID.attr(font: .compactRoundedSemibold(14), color: UIColor(named: "mainText")!) :  (correctName.attr(font: .compactRoundedSemibold(14), color: UIColor(named: "mainText")!) + " ×".attr(font: .compactRoundedSemibold(12), color: UIColor(named: "mainText")!) + "\(holding.quantity ?? 0.0)".attr(font: .compactRoundedSemibold(14), color: UIColor(named: "mainText")!)))
        self.percentInHolding = holding.holdingDetails?.valueToPortfolioValue ?? 0.0
        self.totalPrice = Float(holding.gains?.actualValue ?? 0.0)
        self.quantity = Float(holding.quantity ?? 0.0)
        self.singlePrice = type == .crypto ? accountID : holding.expiryDateString
        let absGains: [ScatterChartView.ChartPeriod : Float] = [
            .d1 : holding.gains?.absoluteGain_1d ?? 0.0,
            .w1 : holding.gains?.absoluteGain_1w ?? 0.0,
            .m1 : holding.gains?.absoluteGain_1m ?? 0.0,
            .m3 : holding.gains?.absoluteGain_3m ?? 0.0,
            .y1 : holding.gains?.absoluteGain_1y ?? 0.0,
            .y5 : holding.gains?.absoluteGain_5y ?? 0.0,
            .all : holding.gains?.absoluteGainTotal ?? 0.0
        ]
        
        let relGains: [ScatterChartView.ChartPeriod : Float]  = [
            .d1 : (holding.gains?.relativeGain_1d ?? 0.0) * 100.0,
            .w1 : (holding.gains?.relativeGain_1w ?? 0.0) * 100.0,
            .m1 : (holding.gains?.relativeGain_1m ?? 0.0) * 100.0,
            .m3 : (holding.gains?.relativeGain_3m ?? 0.0) * 100.0,
            .y1 : (holding.gains?.relativeGain_1y ?? 0.0) * 100.0,
            .y5 : (holding.gains?.relativeGain_5y ?? 0.0) * 100.0,
            .all : (holding.gains?.relativeGainTotal ?? 0.0) * 100.0
        ]
        self.absoluteGains = absGains
        self.relativeGains = relGains
    }
}

extension String {
    var companyMarkRemoved: String {
        let list = ["Inc", "Ltd", "Plc", "Holdings", "(International)", "(Corporation)", "Corporation", "Incorporated", "Limited", "International S.A", "S.A", "International Corporation", "Corp", "Holding Co. Ltd", "Corp. Common Shares", "Common Stock when-issued", "Common stock"," and Company"," & Company", " Company", "Co. Class A", "Co. Class B", "Class A", "Class B", "Warrants", "International", " & Co.", "& Co", "Co", "Co.", "Global Inc"]
        var old = self
        for ltd in list {
            if let dotRange = old.range(of: ltd), !old.hasPrefix(ltd){
                let replace = old[dotRange]
                if old.hasSuffix(replace) {
                    old.removeSubrange(dotRange.lowerBound..<old.endIndex)
                    old = old.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
        }
        return old
    }
    
    var cryptoRemoved: String {
        return self.hasSuffix(".CC") ? self.replacingOccurrences(of: ".CC", with: "") : self
    }
}

extension HoldingSecurityViewModel: Equatable {
    
}

extension HoldingSecurityViewModel: Hashable {
    
}

extension GetPlaidHoldingsQuery.Data.ProfileHoldingGroup.Holding {
    var secType: HoldingSecurityViewModel.SecType {
        let rawType = holdingDetails?.securityType ?? ""
        if rawType == "derivative" {
            return .option
        } else {
            if rawType == "equity" {
                return .share
            } else {
                if rawType == "crypto" {
                    return .crypto
                } else {
                    if rawType == "mutual fund" {
                        return .share
                    } else {
                        return .cash
                    }
                }
            }
        }
    }
}
