//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionDetailsTitleCell: UICollectionViewCell {
    
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(companyNameLabel)
        companyNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        companyNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 72)
        companyNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 32.0)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = RemoteConfigManager.shared.mainBackColor
        self.isSkeletonable = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isSkeletonable = false
    }
    
    func configureWith(companyName: String) {
        companyNameLabel.minimumScaleFactor = 1.0
        companyNameLabel.text = companyName
        companyNameLabel.sizeToFit()
    }
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 32)
        label.textColor = UIColor.init(hexString: "#09141F")
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.numberOfLines = 0
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
}
