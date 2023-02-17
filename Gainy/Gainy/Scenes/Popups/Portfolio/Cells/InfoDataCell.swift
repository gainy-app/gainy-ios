//
//  InfoDataCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/22/21.
//

import UIKit
import Kingfisher

final class InfoDataCell: UICollectionViewCell {
    
    public var selectedColorHexString: String = "#0062FF"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cornerView: CornerView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var singleTextLabel: UILabel!
    
    private var imageUrl: String = ""
    private var imageLoaded: Bool = false
    
    var infoData: InfoDataSource? {
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
        guard let singleTextLabel = singleTextLabel else {return}
        guard let iconImageView = iconImageView else {return}
        if self.infoData == nil {
            return
        }
        
        let name = self.infoData?.title ?? ""
        let iconUrl = self.infoData?.iconURL ?? ""
        textLabel.text = name
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.8
        
        singleTextLabel.text = name
        singleTextLabel.adjustsFontSizeToFitWidth = true
        singleTextLabel.minimumScaleFactor = 0.8
        
        if iconUrl.isEmpty {
            textLabel.isHidden = true
            singleTextLabel.isHidden = false
        } else {
            textLabel.isHidden = false
            singleTextLabel.isHidden = true
        }
        
        imageUrl = iconUrl
        imageLoaded = false
        iconImageView.contentMode = .scaleAspectFit
        self.setNeedsLayout()
    }
    
    
    private func loadImage() {
        
        guard self.imageLoaded == false, iconImageView.bounds.size.width > 0, iconImageView.bounds.size.height > 0 else {
            return
        }
        
        let processor = DownsamplingImageProcessor(size: iconImageView.bounds.size)
        iconImageView.kf.setImage(with: URL(string: imageUrl), options: [
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
