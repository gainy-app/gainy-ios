//
//  GraphQL+Extensions.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.08.2021.
//

import UIKit
import SwiftDate

protocol RemoteDateTimeConvertable {
    var datetime: String? {get set}
    var date: Date {get}
    
}

extension RemoteDateTimeConvertable {
    var date: Date {
        return (datetime ?? "").toDate("yyy-MM-dd'T'HH:mm:ssZ")?.date ?? Date()
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
}


typealias RemoteChartData = DiscoverChartsQuery.Data.FetchChartDatum

extension RemoteChartData: RemoteDateTimeConvertable {
        
    func labelForPeriod(_ period: ScatterChartView.ChartPeriod) -> String {
        let formatter = DateFormatter()
        
        switch period {
        case .d1:
            formatter.dateFormat = "HH:mm"
            break
        case .m1:
            formatter.dateFormat = "MM-dd"
            break
        case .y5, .all:
            formatter.dateFormat = "yyyy"
            break
        default:
            formatter.dateFormat = "MM-dd"
            break
        }
        return formatter.string(from: date)
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


extension DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker.TickerFinancial : RemoteCreatedAtConvertable {
}


extension DiscoverCollectionDetailsQuery.Data.AppCollection.CollectionSymbol.Ticker {
    var isGrowing: Bool {
        tickerFinancials.last?.priceChangeToday ?? 0.0 >= 0.0
    }
    
    var priceColor: UIColor {
        isGrowing ? UIColor(named: "mainGreen")! : UIColor(named: "mainRed")!
    }
}
