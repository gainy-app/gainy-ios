//
//  GraphQL+Extensions.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.08.2021.
//

import UIKit
import SwiftDate
import GainyAPI
import GainyCommon

protocol RemoteDateTimeConvertable {
    var datetime: String? {get set}
    var date: Date {get}
    
    func labelForPeriod(_ period: ScatterChartView.ChartPeriod) -> String
}

extension RemoteDateTimeConvertable {
    var date: Date {
        if let zDate = (datetime ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date {
            return zDate
        } else {
            return (datetime ?? "").toDate("yyy-MM-dd'T'HH:mm:ss")?.date ?? Date()
        }
    }
}

extension LivePrice {
    var date: Date {
        if let zDate = (time ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date {
            return zDate
        } else {
            return (time ?? "").toDate("yyy-MM-dd'T'HH:mm:ss")?.date ?? Date()
        }
    }
}

extension RealtimePrice {
    var date: Date {
        if let zDate = (time ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date {
            return zDate
        } else {
            return (time ?? "").toDate("yyy-MM-dd'T'HH:mm:ss")?.date ?? Date()
        }
    }
}

extension DiscoverNewsQuery.Data.FetchNewsDatum: RemoteDateTimeConvertable {
    
    var timeAgoSince: String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self.date, to: now, options: [])
        
        if let year = components.year, year >= 2 {
            return "\(year)y"
        }
        
        if let year = components.year, year >= 1 {
            return "1y"
        }
        
        if let month = components.month, month >= 2 {
            return "\(month)M"
        }
        
        if let month = components.month, month >= 1 {
            return "1M"
        }
        
        if let week = components.weekOfYear, week >= 2 {
            return "\(week)w"
        }
        
        if let week = components.weekOfYear, week >= 1 {
            return "1w"
        }
        
        if let day = components.day, day >= 2 {
            return "\(day)d"
        }
        
        if let day = components.day, day >= 1 {
            return "1d"
        }
        
        if let hour = components.hour, hour >= 2 {
            return "\(hour)h"
        }
        
        if let hour = components.hour, hour >= 1 {
            return "1h"
        }
        
        if let minute = components.minute, minute >= 2 {
            return "\(minute)m"
        }
        
        if let minute = components.minute, minute >= 1 {
            return "1m"
        }
        
        if let second = components.second, second >= 3 {
            return "\(second)s"
        }
        
        return "Now"
    }
    func labelForPeriod(_ period: ScatterChartView.ChartPeriod) -> String  {
        ""
    }
}

typealias RemoteChartData = DiscoverChartsQuery.Data.Chart

extension RemoteChartData: RemoteDateTimeConvertable {
    func labelForPeriod(_ period: ScatterChartView.ChartPeriod) -> String {
        switch period {
        case .d1:
            return AppDateFormatter.shared.string(from: date, dateFormat: .HHmm)
        case .w1:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMddHHmm, timezone: TimeZone.utc)
        case .y5:
            if date.year == Date().year {
                return AppDateFormatter.shared.string(from: date, dateFormat: .MMdd, timezone: TimeZone.utc)
            } else {
                return AppDateFormatter.shared.string(from: date, dateFormat: .MMddyy, timezone: TimeZone.utc)
            }
        case .all:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMyy, timezone: TimeZone.utc)
        default:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMdd, timezone: TimeZone.utc)
        }
    }
}

extension GetPortfolioChartsQuery.Data.GetPortfolioChart : RemoteDateTimeConvertable {
        
    func labelForPeriod(_ period: ScatterChartView.ChartPeriod) -> String {
        switch period {
        case .d1:
            return AppDateFormatter.shared.string(from: date, dateFormat: .HHmm)
        case .w1:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMddHHmm, timezone: TimeZone.utc)
        case .y5,.all:
            if date.year == Date().year {
                return AppDateFormatter.shared.string(from: date, dateFormat: .MMdd, timezone: TimeZone.utc)
            } else {
                return AppDateFormatter.shared.string(from: date, dateFormat: .MMddyy, timezone: TimeZone.utc)
            }
        default:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMdd, timezone: TimeZone.utc)
        }
    }
}

extension GetTtfChartQuery.Data.CollectionChart: RemoteDateTimeConvertable {
    
    func labelForPeriod(_ period: ScatterChartView.ChartPeriod) -> String {
        switch period {
        case .d1:
            return AppDateFormatter.shared.string(from: date, dateFormat: .HHmm)
        case .w1:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMddHHmm, timezone: TimeZone.utc)
        case .y5,.all:
            if date.year == Date().year {
                return AppDateFormatter.shared.string(from: date, dateFormat: .MMdd, timezone: TimeZone.utc)
            } else {
                return AppDateFormatter.shared.string(from: date, dateFormat: .MMddyy, timezone: TimeZone.utc)
            }
        default:
            return AppDateFormatter.shared.string(from: date, dateFormat: .MMdd, timezone: TimeZone.utc)
        }
    }
}

protocol RemoteCreatedAtConvertable {
    var createdAt: String? {get set}
    var date: Date {get}
    
}

extension RemoteCreatedAtConvertable {
    var date: Date {
        return (createdAt ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()
    }
}


extension RemoteTickerDetails {
    var isGrowing: Bool {
        realtimeMetrics?.relativeDailyChange ?? 0.0 >= 0.0
    }
    
    var priceColor: UIColor {
        isGrowing ? UIColor(named: "mainGreen")! : UIColor(named: "mainRed")!
    }
}
