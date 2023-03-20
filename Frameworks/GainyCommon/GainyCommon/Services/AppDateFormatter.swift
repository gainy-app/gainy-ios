//
//  AppDateFormatter.swift
//  GainyCommon
//
//  Created by Евгений Таран on 21.12.22.
//

import Foundation

public enum DateFormat: String {
    case yyyyMMddHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case ddMM = "dd.MM"
    case ddMMyyyy = "dd.MM.yyyy"
    case yyyyMMdd = "yyyy-MM-dd"
    case MMddyyyy = "MM/dd/yyyy"
    case HHmmss = "HH:mm:ss"
    case MMMdyyyy = "MMM d, yyyy"
    case MMMddyyyy = "MMM dd, yyyy"
    case yyyMMddHHmmssZ = "yyy-MM-dd'T'HH:mm:ssZ"
    case yyyyMMddHHmmssSSSSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    case MMMMddyyyy = "MMMM dd, yyyy"
    case hhmmMMMddyyyy = "hh:mm, MMM dd, yyyy"
    case hhmmMMMddyyyyUS = "h:mm a, MMM dd, yyyy"
    case MMddyyyyDot = "MM.dd.yyyy"
    case yyyyMMddHHmmssZZZZZ = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    case MMyy = "MM-yy"
    case HHmm = "HH:mm"
    case MMddHHmm = "MM-dd HH:mm"
    case MMdd = "MM-dd"
    case MMddyy = "MM-dd-yy"
}

public final class AppDateFormatter {
    public static let shared = AppDateFormatter()
    
    private init() {}
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.yyyyMMddHHmmss.rawValue
        formatter.locale = .current
        return formatter
    }()
    
    public func date(from string: String, dateFormat: DateFormat = .yyyyMMddHHmmss, locale: Locale = .current) -> Date? {
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.locale = locale
        return dateFormatter.date(from: string)
    }
    
    public func string(from date: Date, dateFormat: DateFormat = .yyyyMMddHHmmss, locale: Locale = .current) -> String {
        dateFormatter.dateFormat = dateFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    public func convert(_ stringDate: String, locale: Locale = .current, from dateFormat: DateFormat, to resultDateFormat: DateFormat) -> String? {
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat.rawValue
        guard let date = dateFormatter.date(from: stringDate) else { return nil }
        dateFormatter.dateFormat = resultDateFormat.rawValue
        return dateFormatter.string(from: date)
    }
    
    public func convert(_ date: Date, locale: Locale = .current, from dateFormat: DateFormat, to resultDateFormat: DateFormat) -> Date? {
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat.rawValue
        let string = dateFormatter.string(from: date)
        dateFormatter.dateFormat = resultDateFormat.rawValue
        return dateFormatter.date(from: string)
    }
}
