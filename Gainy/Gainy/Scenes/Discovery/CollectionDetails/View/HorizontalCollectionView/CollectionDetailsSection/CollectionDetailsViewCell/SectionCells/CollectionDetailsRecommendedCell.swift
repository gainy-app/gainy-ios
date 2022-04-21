//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionDetailsRecommendedCell: UICollectionViewCell {
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
                
        //contentView.addSubview(largeBack)
        contentView.addSubview(titleLbl)
        contentView.addSubview(tick1)
        contentView.addSubview(tick2)
        contentView.addSubview(tick3)
        
        contentView.addSubview(risk1Lbl)
        contentView.addSubview(risk2Lbl)
        contentView.addSubview(risk3Lbl)
        
        contentView.addSubview(matchCircle)
        contentView.addSubview(msLbl)
        
        contentView.addSubview(tagsTitle)
        
        titleLbl.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        titleLbl.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        titleLbl.autoSetDimension(.height, toSize: 24.0)
                
        tick1.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        tick1.autoPinEdge(.top, to: .bottom, of: titleLbl, withOffset: 16)
        tick1.autoSetDimensions(to: .init(width: 16, height: 16))
        
        tick2.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        tick2.autoPinEdge(.top, to: .bottom, of: tick1, withOffset: 16)
        tick2.autoSetDimensions(to: .init(width: 16, height: 16))
        
        tick3.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
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
        
        matchCircle.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        matchCircle.autoPinEdge(toSuperviewEdge: .top, withInset: 40)
        matchCircle.autoSetDimensions(to: .init(width: 88, height: 88))
        
        msLbl.autoAlignAxis(.horizontal, toSameAxisOf: matchCircle)
        msLbl.autoAlignAxis(.vertical, toSameAxisOf: matchCircle)
        
        tagsTitle.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        tagsTitle.autoPinEdge(.top, to: .bottom, of: tick3, withOffset: 24)
        tagsTitle.autoSetDimension(.height, toSize: 16)
        
//        largeBack.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
//        largeBack.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
//        largeBack.autoPinEdge(toSuperviewEdge: .right, withInset: -16.0)
//        largeBack.autoPinEdge(toSuperviewEdge: .left, withInset: -16)
//        clipsToBounds = false
    }
    
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.text = "Recommended for you"
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
    
    lazy var tick1: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var tick2: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var tick3: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var risk1Lbl: UILabel = {
        let label = UILabel()
        label.text = "Recommended for you"
        label.font = .proDisplayRegular(14)
        label.textColor = UIColor.Gainy.mainText
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
        label.text = "Fit your investments categories"
        label.font = .proDisplayRegular(14)
        label.textColor = UIColor.Gainy.mainText
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
        label.text = "Fit your interests"
        label.font = .proDisplayRegular(14)
        label.textColor = UIColor.Gainy.mainText
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
        view.image = UIImage(named: "ticker_pfr")
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var msLbl: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .compactRoundedSemibold(32)
        label.textColor = UIColor.Gainy.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var tagsTitle: UILabel = {
        let label = UILabel()
        label.text = "Tags for this company"
        label.font = .compactRoundedMedium(12)
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
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func configureWith(matchData: RemoteCollectionDetails.MatchScore, tags: [TickerTag]) {
        let matchScore = Int(matchData.matchScore ?? 0)
        msLbl.text = "\(matchScore)"
        tick1.image = UIImage(named: "fits_risk\(matchData.riskLevel ?? 0)")
        tick2.image = UIImage(named: "fits_risk\(matchData.interestLevel ?? 0)")
        tick3.image = UIImage(named: "fits_risk\(matchData.categoryLevel ?? 0)")
        
        risk1Lbl.attributedText = "Fits your risk profile: ".attr(font: .proDisplayRegular(14), color: UIColor(named: "mainText")!) + "\(Int((matchData.riskSimilarity ?? 0.0) * 100.0))%".attr(font: .proDisplayBold(14), color: UIColor(named: "mainText")!)
        switch matchScore {
        case 0..<35:
            contentView.backgroundColor = UIColor.Gainy.mainRed
            tagsTitle.textColor = UIColor.Gainy.mainText
            break
        case 35..<65:
            contentView.backgroundColor = UIColor.Gainy.mainYellow
            tagsTitle.textColor = UIColor.Gainy.mainText
            break
        case 65...:
            contentView.backgroundColor = UIColor.Gainy.mainGreen
            tagsTitle.textColor = .white
            break
        default:
            break
        }
        largeBack.backgroundColor = contentView.backgroundColor
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        matchCircle.transform = transform
    }
}
