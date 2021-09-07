//
//  RoundedTextCollectionViewCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/31/21.
//

import UIKit
import Kingfisher

final class RoundedTextCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cornerView: CornerView!
    @IBOutlet weak var textLabel: UILabel!
    
    var title: String? {
        didSet {
            self.updateUI()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            guard let textLabel = textLabel else {return}
            guard let cornerView = cornerView else {return}
            cornerView.backgroundColor = UIColor.init(hexString: isSelected ? "#000000" : "#FFFFFF")
            textLabel.textColor = UIColor.init(hexString: isSelected ? "#FFFFFF" : "#09141F")
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            cornerView.backgroundColor = UIColor.init(hexString: self.isSelected ? "#000000" : "#FFFFFF", alpha: isHighlighted ? 0.7 : 1.0)
            textLabel.textColor = UIColor.init(hexString: self.isSelected ? "#FFFFFF" : "#09141F", alpha: isHighlighted ? 0.7 : 1.0)
        }
    }
    
    private func updateUI() {
        
        guard let title = title else {return}
        guard let textLabel = textLabel else {return}
        
        textLabel.text = title
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.minimumScaleFactor = 0.8
    }
}
