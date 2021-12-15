//
//  IntroductionCaptionCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/31/21.
//

import UIKit
import Kingfisher
import PureLayout

final class IntroductionCaptionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    var captionText: String = "" {
        didSet {
            self.updateLabel()
        }
    }
    
    var imageName: String = "" {
        didSet {
            self.updateImage()
        }
    }
    
    private func updateImage() {
        guard let imageView = imageView else {return}
        guard imageName.count > 0 else {return}
        guard let image = UIImage(named: imageName) else {return}
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
    }
    
    private func updateLabel() {
    
        guard let textLabel = captionLabel else {return}
        textLabel.layer.masksToBounds = false
        textLabel.clipsToBounds = false
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.proDisplaySemibold(32)
        textLabel.setLineHeight(lineHeight: 32, textAlignment: NSTextAlignment.left)
        textLabel.text = captionText
    }
}
