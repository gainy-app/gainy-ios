//
//  HintCell.swift
//  Gainy
//
//  Created by r10 on 06.02.2023.
//

import UIKit

class HintCell: UICollectionViewCell {
    
    static let nib = UINib(nibName: "HintCell", bundle: Bundle.main)
    
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var mainImage: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func configure(_ model: HintCellModel) {
        coverImage.image = model.coverImage
        mainImage.image = model.mainImage
        titleLabel.text = model.title
        //subtitleLabel.text = model.subtitle
    }
    
    func configure(_ model: SignUpCellModel) {
        mainImage.image = model.mainImage
        titleLabel.text = model.title
        //subtitleLabel.text = model.subtitle
    }
}
