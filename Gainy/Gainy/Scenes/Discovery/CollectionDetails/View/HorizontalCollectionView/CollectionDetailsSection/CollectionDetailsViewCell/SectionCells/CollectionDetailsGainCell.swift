//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionDetailsGainCell: UICollectionViewCell {
    

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(tickersCountLabelView)
        tickersCountLabelView.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        tickersCountLabelView.autoPinEdge(toSuperviewEdge: .top, withInset: 16.0)
        tickersCountLabelView.autoSetDimension(.height, toSize: 24.0)
        
        tickersCountLabelView.addSubview(tickersCountLabel)
        tickersCountLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        tickersCountLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        tickersCountLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        contentView.addSubview(todaysGainLabel)
        todaysGainLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
        todaysGainLabel.autoPinEdge(toSuperviewEdge: .top)
        todaysGainLabel.autoSetDimension(.height, toSize: 16.0)
        
        contentView.addSubview(tickerPercentChangeLabel)

        tickerPercentChangeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        tickerPercentChangeLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16)
        tickerPercentChangeLabel.autoSetDimension(.height, toSize: 24)
        
        contentView.addSubview(percentArrowImgView)
        percentArrowImgView.autoAlignAxis(.horizontal, toSameAxisOf: tickerPercentChangeLabel)
        percentArrowImgView.autoPinEdge(.right, to: .left, of: tickerPercentChangeLabel, withOffset: -4)
        percentArrowImgView.autoSetDimensions(to: CGSize.init(width: 12, height: 12))
        
        contentView.backgroundColor = .white
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isSkeletonable = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.isSkeletonable = false
    }
    
    func configureWith(tickersCount: Int, dailyGrow: Float) {
        
        tickersCountLabel.text = "\(tickersCount) " + (tickersCount == 1 ? "stock" : "stocks")
        tickersCountLabel.sizeToFit()
        
        if dailyGrow > 0.0 {
            tickerPercentChangeLabel.textColor = UIColor.Gainy.mainGreen
            percentArrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
            percentArrowImgView.tintColor = UIColor.Gainy.mainGreen
            tickerPercentChangeLabel.textColor = UIColor.Gainy.mainGreen
            
        } else {
            tickerPercentChangeLabel.textColor = UIColor.Gainy.mainRed
            percentArrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
            percentArrowImgView.tintColor = UIColor.Gainy.mainRed
            tickerPercentChangeLabel.textColor = UIColor.Gainy.mainRed
        }
        tickerPercentChangeLabel.text = dailyGrow.percent
        tickerPercentChangeLabel.sizeToFit()
        
        todaysGainLabel.text = "Today Gain"
    }
    
    func configureAsWatchlist(tickersCount: Int) {
        tickersCountLabel.text = "\(tickersCount) " + (tickersCount == 1 ? "stock" : "stocks")
        tickersCountLabel.sizeToFit()
        
        percentArrowImgView.image = nil
        tickerPercentChangeLabel.text = ""
        todaysGainLabel.text = ""
    }
    
    lazy var tickersCountLabelView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var tickersCountLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#6C5DD3")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var todaysGainLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.compactRoundedSemibold(14.0)
        label.textColor = UIColor.init(hexString: "#B1BDC8")
        label.numberOfLines = 1
        label.textAlignment = .center
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var percentArrowImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow-up-green")
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var tickerPercentChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedSemibold(24)
        label.textColor = UIColor.Gainy.mainGreen
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
}
