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
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
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
        
        contentView.addSubview(tagsContainer)
        
        titleLbl.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        titleLbl.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        titleLbl.autoSetDimension(.height, toSize: 24.0)
                
        tick1.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        tick1.autoPinEdge(.top, to: .bottom, of: titleLbl, withOffset: 16)
        tick1.autoSetDimensions(to: .init(width: 16, height: 16))
        
        tick2.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        tick2.autoPinEdge(.top, to: .bottom, of: tick1, withOffset: 16)
        tick2.autoSetDimensions(to: .init(width: 16, height: 16))
        
        tick3.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
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
        
        matchCircle.autoPinEdge(toSuperviewEdge: .right, withInset: 40)
        matchCircle.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        matchCircle.autoSetDimensions(to: .init(width: 88, height: 88))
        
        msLbl.autoAlignAxis(.horizontal, toSameAxisOf: matchCircle)
        msLbl.autoAlignAxis(.vertical, toSameAxisOf: matchCircle)
                
        //tagsContainer.translatesAutoresizingMaskIntoConstraints = false
        tagsContainer.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        tagsContainer.autoPinEdge(toSuperviewEdge: .right, withInset: 32)
        tagsContainer.autoPinEdge(.top, to: .bottom, of: tick3, withOffset: 24)
        self.tagsContainerHeight = tagsContainer.autoSetDimension(.height, toSize: 16)
        
        largeBack.layer.cornerRadius = 16
        largeBack.clipsToBounds = true
        
        largeBack.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        largeBack.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        largeBack.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        largeBack.autoPinEdge(toSuperviewEdge: .left, withInset: 16)
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
    
    lazy var largeBack: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var tagsContainer: UIView = {
        let view = UIView()
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
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
    
    private var lines: Int = 1
    private var tagsContainerHeight: NSLayoutConstraint?
    
    func configureWith(matchData: RemoteCollectionDetails.MatchScore, tags: [TickerTag]) {
        let matchScore = Int(matchData.matchScore ?? 0)
        msLbl.text = "\(matchScore)"
        tick1.image = UIImage(named: "fits_risk\(matchData.riskLevel ?? 0)")
        tick2.image = UIImage(named: "fits_risk\(matchData.categoryLevel ?? 0)")
        tick3.image = UIImage(named: "fits_risk\(matchData.interestLevel ?? 0)")
        
        risk1Lbl.attributedText = "Fits your risk profile: ".attr(font: .proDisplayRegular(14), color: UIColor(named: "mainText")!) + "\(Int((matchData.riskSimilarity ?? 0.0) * 100.0))%".attr(font: .proDisplayBold(14), color: UIColor(named: "mainText")!)
        largeBack.backgroundColor = MatchScoreManager.backColorFor(matchScore)
        
        
        //Tags
        let tagHeight: CGFloat = 24.0
        let margin: CGFloat = 8.0
        
        for sub in tagsContainer.subviews {
            sub.removeFromSuperview()
        }
        
        if tagsContainer.subviews.count == 0 {
            let totalWidth: CGFloat = UIScreen.main.bounds.width - 34 * 2.0
            var xPos: CGFloat = 0.0
            var yPos: CGFloat = 0.0
            for tag in tags {
                let tagView = TagView()
                
                tagView.backgroundColor = UIColor.white
                tagView.tagLabel.textColor = UIColor.Gainy.mainText
                tagView.loadImage(url: tag.url)
                
                tagView.addTarget(self, action: #selector(tagViewTouchUpInside(_:)),
                                 for: .touchUpInside)
                tagsContainer.addSubview(tagView)
                tagView.tagName = tag.name
                tagView.loadImage(url: tag.url)
                let width = (tag.url.isEmpty ? 8.0 : 26.0) + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(12)) + margin
                tagView.autoSetDimensions(to: CGSize.init(width: width, height: tagHeight))
                if xPos + width + margin > totalWidth && tagsContainer.subviews.count > 1 {
                    xPos = 0.0
                    yPos = yPos + tagHeight + margin
                    lines += 1
                }
                tagView.autoPinEdge(.leading, to: .leading, of: tagsContainer, withOffset: xPos)
                tagView.autoPinEdge(.top, to: .top, of: tagsContainer, withOffset: yPos)
                xPos += width + margin
            }
        }
            
        self.tagsContainerHeight?.constant = tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
        self.tagsContainer.layoutIfNeeded()
        
        let calculatedHeight: CGFloat = (176.0 - 32.0) + tagHeight * CGFloat(max(1, lines)) + margin * CGFloat(max(1, lines) - 1) + 8.0
    }
    
    func setTransform(_ transform: CGAffineTransform) {
        matchCircle.transform = transform
    }
    
    //MARK: - Tags tap
    @objc func tagViewTouchUpInside(_ tagView: TagView) {
        guard let name = tagView.tagName, name.count > 0 else {
            return
        }
        let panelInfo = CategoriesTipsGenerator.getInfoForPanel(name)
        if !panelInfo.title.isEmpty {
            self.showExplanationWith(title: panelInfo.title, description: panelInfo.description, height: panelInfo.height)
        }
    }
    
    private func showExplanationWith(title: String, description: String, height: CGFloat, linkText: String? = nil, link: String? = nil) {
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: title)
        explanationVc.configureWith(description: description, linkString: linkText, link: link)
        FloatingPanelManager.shared.configureWithHeight(height: height)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
}
