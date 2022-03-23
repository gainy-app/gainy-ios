//
//  HomeArticlesTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import Kingfisher

final class HomeArticlesTableViewCell: UITableViewCell {
    
    @IBOutlet private var cornerView: CornerView! {
        didSet {
            cornerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            cornerView.layer.shadowOpacity = 1
            cornerView.layer.shadowOffset = CGSize.init(width: 0, height: 4)
            cornerView.layer.shadowRadius = 10
            cornerView?.clipsToBounds = false
        }
    }
    @IBOutlet private weak var tagLbl: UILabel!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var subTitleLbl: UILabel!
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet var tagCornerView: CornerView!
    
    var article: WebArticle? {
        didSet {
            guard let article = article else {return}
            
            tagLbl.text = article.categoryName?.uppercased()
            tagCornerView.isHidden = tagLbl.text?.isEmpty ?? true
            titleLbl.text = article.title
            subTitleLbl.text = article.postSummary
            
            let processor = DownsamplingImageProcessor(size: coverImgView.bounds.size)
            coverImgView.kf.setImage(with: URL(string: article.mainImage ?? ""), options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ], progressBlock: nil, completionHandler: nil)
            
        }
    }
    
}
