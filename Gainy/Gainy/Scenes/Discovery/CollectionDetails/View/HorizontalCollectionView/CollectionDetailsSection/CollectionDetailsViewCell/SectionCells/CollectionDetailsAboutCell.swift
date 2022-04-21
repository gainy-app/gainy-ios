//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionDetailsAboutCell: UICollectionViewCell {
    

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(aboutLabel)
        contentView.addSubview(detailsLbl)
        //contentView.addSubview(moreBtn)
        
        aboutLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        aboutLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 6)
        aboutLabel.autoSetDimension(.height, toSize: 24.0)
        
        detailsLbl.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        detailsLbl.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
        detailsLbl.autoPinEdge(toSuperviewEdge: .bottom, withInset: 24)
        
//        moreBtn.autoPinEdge(.top, to: .bottom, of: detailsLbl, withOffset: 8.0)
//        moreBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
//        moreBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 24)
        
        contentView.backgroundColor = .white
    }
    
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "About"
        label.font = .proDisplaySemibold(20)
        label.textColor = UIColor.Gainy.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var detailsLbl: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.proDisplayRegular(14.0)
        label.textColor = UIColor.Gainy.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var moreBtn: UIButton = {
        let view = UIButton()
        view.titleLabel?.font = .proDisplayRegular(14.0)
        view.setTitle("show more", for: .normal)
        view.setTitleColor(UIColor(hexString: "#0062FF"), for: .normal)
        return view
    }()
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func configureWith(detail: String) {
        detailsLbl.text = detail
    }
}
