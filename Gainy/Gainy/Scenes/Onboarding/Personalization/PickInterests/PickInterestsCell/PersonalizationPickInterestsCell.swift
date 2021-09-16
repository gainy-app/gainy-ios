//
//  PersonalizationPickInterestsCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/31/21.
//

import UIKit
import Kingfisher

final class PersonalizationPickInterestsCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cornerView: CornerView!
    @IBOutlet weak var textLabel: UILabel!
    
    var appInterest: AppInterestsQuery.Data.Interest? {
        didSet {
            self.updateUI()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard let textLabel = textLabel else {return}
            guard let cornerView = cornerView else {return}
            cornerView.backgroundColor = UIColor.init(hexString: isSelected ? "#0062FF" : "#FFFFFF")
            textLabel.textColor = UIColor.init(hexString: isSelected ? "#FFFFFF" : "#09141F")
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            cornerView.backgroundColor = UIColor.init(hexString: self.isSelected ? "#0062FF" : "#FFFFFF", alpha: isHighlighted ? 0.7 : 1.0)
            textLabel.textColor = UIColor.init(hexString: self.isSelected ? "#FFFFFF" : "#09141F", alpha: isHighlighted ? 0.7 : 1.0)
        }
    }
    
    private func updateUI() {
        
        guard let appInterest = appInterest else {return}
        guard let textLabel = textLabel else {return}
        guard let iconImageView = iconImageView else {return}
        
        textLabel.text = appInterest.name
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.8
        let processor = DownsamplingImageProcessor(size: iconImageView.bounds.size)
        iconImageView.kf.setImage(with: URL(string: appInterest.iconUrl ?? ""), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: nil, completionHandler: nil)
        iconImageView.contentMode = .scaleAspectFit
    }
}
