//
//  NewsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2021.
//

import UIKit
import Kingfisher



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
