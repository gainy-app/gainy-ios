//
//  NewsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2021.
//

import UIKit
import Kingfisher

extension DiscoverNewsQuery.Data.FetchNewsDatum {
    
    var date: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: self.datetime ?? "") ?? Date()
    }
    
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

final class NewsViewCell: UICollectionViewCell {
    @IBOutlet private weak var timeLbl: UILabel!
    @IBOutlet private weak var sourceLbl: UILabel!
    @IBOutlet private weak var infoLbl: UILabel!
    @IBOutlet private weak var newsBackImageView: UIImageView!
    
    var news: DiscoverNewsQuery.Data.FetchNewsDatum? {
        didSet {
            guard let news = news else {return}
            timeLbl.text = news.timeAgoSince
            sourceLbl.text = news.sourceName
            infoLbl.text = news.title
            let processor = DownsamplingImageProcessor(size: newsBackImageView.bounds.size)
            newsBackImageView.kf.setImage(with: URL(string: news.imageUrl ?? ""), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], progressBlock: nil, completionHandler: nil)
            newsBackImageView.contentMode = .scaleAspectFill
        }
    }
}
