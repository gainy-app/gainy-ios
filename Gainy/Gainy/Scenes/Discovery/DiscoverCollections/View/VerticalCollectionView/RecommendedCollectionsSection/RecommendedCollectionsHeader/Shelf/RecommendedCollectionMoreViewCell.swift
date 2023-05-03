//
//  RecommendedCollectionMoreViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.04.2023.
//

import UIKit
import SnapKit

final class RecommendedCollectionMoreViewCell: RoundedCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        
        contentView.backgroundColor = UIColor(hexString: "#F6F6F6")
                
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints( {make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplaySemibold(13)
        label.textColor = UIColor(hexString: "1B45FB")
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func configureWith(count: Int) {
        nameLabel.text = "+\(count) TTF\(count > 1 ? "s" : "")"
    }
}
