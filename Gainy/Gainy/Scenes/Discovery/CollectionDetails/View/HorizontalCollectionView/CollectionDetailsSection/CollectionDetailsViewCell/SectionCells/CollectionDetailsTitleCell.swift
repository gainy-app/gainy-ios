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
        
        contentView.addSubview(companyContainer)
        
        companyContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        companyContainer.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        companyContainer.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        companyContainer.autoSetDimension(.height, toSize: 94.0)
        
        contentView.addSubview(companyNameLabel)
        companyNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        companyNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 48)
        companyNameLabel.autoPinEdge(.top, to: .top, of: companyContainer, withOffset: 0, relation: .greaterThanOrEqual)
        companyNameLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0, relation: .greaterThanOrEqual)
        companyNameLabel.autoAlignAxis(.horizontal, toSameAxisOf: companyContainer)
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
    
    func configureWith(companyName: String, id: Int) {
        companyNameLabel.minimumScaleFactor = 0.1
        companyNameLabel.text = companyName
        if Configuration().environment == .staging {
            companyNameLabel.text = "\(companyName) ID:\(id)"
        }
        companyNameLabel.sizeToFit()
    }
    
    lazy var companyContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isSkeletonable = false
        return view
    }()
    
    lazy var companyNameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
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
