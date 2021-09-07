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
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var captionLabelHeightConstraint: NSLayoutConstraint!
    
    var captionText: String = "" {
        didSet {
            self.updateUI()
        }
    }
    
    var captionHeight: Float = Float(20) {
        willSet {
            self.captionLabelHeightConstraint.constant = CGFloat(newValue)
        }
    }
    
    private func updateUI() {
    
        guard let textLabel = captionLabel else {return}
        
        textLabel.layer.masksToBounds = false
        textLabel.clipsToBounds = false
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.proDisplaySemibold(56)
        textLabel.setLineHeight(lineHeight: 48, textAlignment: NSTextAlignment.left)
        textLabel.text = captionText
    }
}
