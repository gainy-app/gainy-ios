//
//  PickInterestOrCategoryCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/31/21.
//

import UIKit
import Kingfisher

final class PickInterestOrCategoryCell: UICollectionViewCell {
    
    public var selectedColorHexString: String = "#0062FF"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cornerView: CornerView!
    @IBOutlet weak var textLabel: UILabel!
    
    var appInterest: AppInterestsQuery.Data.Interest? {
        didSet {
            self.updateUI()
        }
    }
    
    var appCategory: CategoriesQuery.Data.Category? {
        didSet {
            self.updateUI()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard let textLabel = textLabel else {return}
            guard let cornerView = cornerView else {return}
            cornerView.backgroundColor = UIColor.init(hexString: isSelected ? selectedColorHexString : "#FFFFFF")
            textLabel.textColor = UIColor.init(hexString: isSelected ? "#FFFFFF" : "#09141F")
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            cornerView.backgroundColor = UIColor.init(hexString: self.isSelected ? selectedColorHexString : "#FFFFFF", alpha: isHighlighted ? 0.7 : 1.0)
            textLabel.textColor = UIColor.init(hexString: self.isSelected ? "#FFFFFF" : "#09141F", alpha: isHighlighted ? 0.7 : 1.0)
        }
    }
    
    private func updateUI() {
        
        guard let textLabel = textLabel else {return}
        guard let iconImageView = iconImageView else {return}
        if self.appInterest == nil && self.appCategory == nil {
            return
        }
        
        let sourceIsAppInterest = self.appInterest != nil
        let name = sourceIsAppInterest ? (appInterest?.name ?? "") : (appCategory?.name ?? "")
        let iconUrl = sourceIsAppInterest ? (appInterest?.iconUrl ?? "") : (appCategory?.iconUrl ?? "")
        textLabel.text = name
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.8
        let processor = DownsamplingImageProcessor(size: iconImageView.bounds.size)
        iconImageView.kf.setImage(with: URL(string: iconUrl), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: nil, completionHandler: nil)
        iconImageView.contentMode = .scaleAspectFit
    }
}
