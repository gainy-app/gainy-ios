//
//  CollectionDetailsNoRecommendationsCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 07.12.2022.
//

import UIKit
import SkeletonView
import PureLayout
import GainyAPI

final class CollectionDetailsNoRecommendationsCell: UICollectionViewCell {
    
    static let cellHeight: CGFloat = 248.0 + 32.0
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    var checkInAction: (() -> Void)?
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
                
        contentView.addSubview(largeBack)
        contentView.addSubview(titleLbl)
        contentView.addSubview(tick1)
        contentView.addSubview(tick2)
        contentView.addSubview(tick3)
        
        contentView.addSubview(risk1Lbl)
        contentView.addSubview(risk2Lbl)
        contentView.addSubview(risk3Lbl)
        
        contentView.addSubview(matchCircle)
        contentView.addSubview(msLbl)
        
        let topInset: CGFloat = 16.0
        
        titleLbl.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        titleLbl.autoPinEdge(toSuperviewEdge: .top, withInset: 32 + topInset)
                
        tick1.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        tick1.autoPinEdge(.top, to: .bottom, of: titleLbl, withOffset: 16)
        tick1.autoSetDimensions(to: .init(width: 16, height: 16))
        
        tick2.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        tick2.autoPinEdge(.top, to: .bottom, of: tick1, withOffset: 16)
        tick2.autoSetDimensions(to: .init(width: 16, height: 16))
        
        tick3.autoPinEdge(toSuperviewEdge: .left, withInset: 40)
        tick3.autoPinEdge(.top, to: .bottom, of: tick2, withOffset: 16)
        tick3.autoSetDimensions(to: .init(width: 16, height: 16))
        
        risk1Lbl.autoPinEdge(.left, to: .right, of: tick1, withOffset: 12)
        risk1Lbl.autoAlignAxis(.horizontal, toSameAxisOf: tick1)
        risk1Lbl.autoSetDimension(.height, toSize: 16)
        
        risk2Lbl.autoPinEdge(.left, to: .right, of: tick2, withOffset: 12)
        risk2Lbl.autoAlignAxis(.horizontal, toSameAxisOf: tick2)
        risk2Lbl.autoSetDimension(.height, toSize: 16)
        
        risk3Lbl.autoPinEdge(.left, to: .right, of: tick3, withOffset: 12)
        risk3Lbl.autoAlignAxis(.horizontal, toSameAxisOf: tick3)
        risk3Lbl.autoSetDimension(.height, toSize: 16)
        
        matchCircle.autoPinEdge(toSuperviewEdge: .right, withInset: 40.0)
        matchCircle.autoPinEdge(toSuperviewEdge: .top, withInset: 24 + topInset)
        matchCircle.autoSetDimensions(to: .init(width: 80, height: 80))
        
        msLbl.autoAlignAxis(.horizontal, toSameAxisOf: matchCircle)
        msLbl.autoAlignAxis(.vertical, toSameAxisOf: matchCircle)
                
        
        largeBack.layer.cornerRadius = 16
        largeBack.clipsToBounds = true
        
        largeBack.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
        largeBack.autoPinEdge(toSuperviewEdge: .bottom, withInset: 16)
        largeBack.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        largeBack.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
//        clipsToBounds = false
        largeBack.addSubview(largeGradientBack)
        largeGradientBack.autoPinEdgesToSuperviewEdges()
        
        largeBack.addSubview(chekcInBtn)
        chekcInBtn.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        chekcInBtn.autoPinEdge(toSuperviewEdge: .bottom, withInset: 24)
        chekcInBtn.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        chekcInBtn.addTarget(self, action: #selector(onboardAction), for: .touchUpInside)
        
        contentView.fillRemoteBack()
    }
    
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Learn how this TTF\nfits you personality!"
        label.font = .proDisplaySemibold(20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var tick1: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        view.image = UIImage(named: "tick_blue")
        return view
    }()
    
    lazy var tick2: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        view.image = UIImage(named: "tick_blue")
        return view
    }()
    
    lazy var tick3: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        view.image = UIImage(named: "tick_blue")
        return view
    }()
    
    lazy var risk1Lbl: UILabel = {
        let label = UILabel()
        label.text = "How it fits you"
        label.font = .proDisplayRegular(14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var risk2Lbl: UILabel = {
        let label = UILabel()
        label.text = "Fits your investments categories"
        label.font = .proDisplayRegular(14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var risk3Lbl: UILabel = {
        let label = UILabel()
        label.text = "Fits your interests"
        label.font = .proDisplayRegular(14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var matchCircle: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "ticker_pfr_white")
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var msLbl: UILabel = {
        let label = UILabel()
        label.text = "0-0"
        label.font = .compactRoundedSemibold(24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var largeBack: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var largeGradientBack: UIImageView = {
        let view = UIImageView()
        view.isSkeletonable = false
        view.isHiddenWhenSkeletonIsActive = false
        view.image = UIImage(named: "no_ms_back")
        view.contentMode = .redraw
        return view
    }()
    
    lazy var chekcInBtn: BorderButton = {
        let view = BorderButton()
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        view.backgroundColor = UIColor(hexString: "EFFF8E")
        view.setTitle("Check-in for the flight", for: .normal)
        view.setTitleColor(UIColor.Gainy.mainText!, for: .normal)
        view.borderColor = .clear
        view.cornerRadius = 8.0
        view.titleLabel?.font = .proDisplayMedium(16)
        return view
    }()
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.fillRemoteBack()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.fillRemoteBack()
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        matchCircle.transform = transform
    }
    
    @objc private func onboardAction() {
        checkInAction?()
    }
}

