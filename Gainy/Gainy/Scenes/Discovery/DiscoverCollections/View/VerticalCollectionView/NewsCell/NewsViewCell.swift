//
//  NewsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.08.2021.
//

import UIKit
import Kingfisher
import GainyAPI

final class NewsViewCell: UICollectionViewCell {
    @IBOutlet private weak var timeLbl: UILabel!
    @IBOutlet private weak var sourceLbl: UILabel!
    @IBOutlet private weak var infoLbl: UILabel!
    @IBOutlet private weak var newsBackImageView: UIImageView!
    
    private var imageUrl: String = ""
    private var imageLoaded: Bool = false
    
    var news: DiscoverNewsQuery.Data.FetchNewsDatum? {
        didSet {
            guard let news = news else {return}
            timeLbl.text = news.timeAgoSince
            sourceLbl.text = news.sourceName
            infoLbl.text = news.title
            
            newsBackImageView.contentMode = .scaleAspectFill
            self.imageLoaded = false
            self.imageUrl = news.imageUrl ?? ""
            setNeedsLayout()
        }
    }
    
    private func loadImage() {
        
        guard self.imageLoaded == false, newsBackImageView.bounds.size.width > 0, newsBackImageView.bounds.size.height > 0 else {
            return
        }
        
        let processor = DownsamplingImageProcessor(size: newsBackImageView.bounds.size)
        newsBackImageView.kf.setImage(with: URL(string: imageUrl), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: nil, completionHandler: nil)
        self.imageLoaded = true
    }
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        if window != nil {
            self.imageLoaded = false
            loadImage()
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        loadImage()
    }
}
