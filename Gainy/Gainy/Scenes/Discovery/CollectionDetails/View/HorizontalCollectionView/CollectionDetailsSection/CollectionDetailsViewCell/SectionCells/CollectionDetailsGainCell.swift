//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

protocol CollectionDetailsGainCellDelegate: AnyObject {
    func medianToggled(cell: CollectionDetailsGainCell, showMedian: Bool)
}

final class CollectionDetailsGainCell: UICollectionViewCell {
    
    weak var delegate: CollectionDetailsGainCellDelegate?

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(tickersCountLabelView)
        tickersCountLabelView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        tickersCountLabelView.autoPinEdge(toSuperviewEdge: .top, withInset: 0.0)
        tickersCountLabelView.autoSetDimension(.height, toSize: 24.0)
        
        tickersCountLabelView.addSubview(tickersCountLabel)
        tickersCountLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
        tickersCountLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        tickersCountLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        contentView.addSubview(todaysGainLabel)
        todaysGainLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
        todaysGainLabel.autoPinEdge(toSuperviewEdge: .top)
        todaysGainLabel.autoSetDimension(.height, toSize: 16.0)
        
        contentView.addSubview(tickerPercentChangeLabel)
        tickerPercentChangeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 24)
        tickerPercentChangeLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 24)
        tickerPercentChangeLabel.autoSetDimension(.height, toSize: 24)
        
        contentView.addSubview(percentArrowImgView)
        percentArrowImgView.autoAlignAxis(.horizontal, toSameAxisOf: tickerPercentChangeLabel)
        percentArrowImgView.autoPinEdge(.right, to: .left, of: tickerPercentChangeLabel, withOffset: -4)
        percentArrowImgView.autoSetDimensions(to: CGSize.init(width: 12, height: 12))
        
        contentView.addSubview(medianView)
        medianView.autoPinEdge(toSuperviewEdge: .left, withInset: 24)
        medianView.autoPinEdge(toSuperviewEdge: .top, withInset: 32.0)
        medianView.autoSetDimension(.height, toSize: 24.0)
        
        medianView.addSubview(medianTitleLbl)
        medianView.addSubview(medianArrowImgView)
        medianView.addSubview(medianPercentChangeLabel)
        
        medianPercentChangeLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 8)
        medianPercentChangeLabel.autoPinEdge(.leading, to: .trailing, of: medianArrowImgView, withOffset: 4)
        medianPercentChangeLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        medianArrowImgView.autoSetDimensions(to: .init(width: 8, height: 8))
        medianArrowImgView.autoAlignAxis(toSuperviewAxis: .horizontal)
        medianArrowImgView.autoPinEdge(toSuperviewEdge: .left, withInset: 77)
        
        medianTitleLbl.autoPinEdge(toSuperviewEdge: .leading, withInset: 36)
        medianTitleLbl.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        medianView.addSubview(toggleImgView)
        toggleImgView.autoPinEdge(.left, to: .left, of: medianView, withOffset: 8)
        toggleImgView.autoAlignAxis(toSuperviewAxis: .horizontal)
        toggleImgView.autoSetDimensions(to: .init(width: 20, height: 20))
        
        contentView.addSubview(medianBtn)
        medianBtn.autoPinEdge(.left, to: .left, of: medianView)
        medianBtn.autoPinEdge(.right, to: .right, of: medianView)
        medianBtn.autoPinEdge(.top, to: .top, of: medianView)
        medianBtn.autoPinEdge(.bottom, to: .bottom, of: medianView)
        medianView.isHidden = true
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
    
    func configureWith(tickersCount: Int, viewModel: CollectionDetailViewCellModel) {
        
        tickersCountLabel.text = "\(tickersCount) " + (tickersCount == 1 ? "stock" : "stocks")
        tickersCountLabel.sizeToFit()
        
        if viewModel.dailyGrow > 0.0 {
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
        tickerPercentChangeLabel.text = viewModel.statsDayValue
        tickerPercentChangeLabel.sizeToFit()
        
        todaysGainLabel.text = viewModel.statsDayName
        
        //SP500
        
        if viewModel.topChart.sypChartData.points.count > 0 {
            medianView.isHidden = false
            medianPercentChangeLabel.text = viewModel.topChart.spGrow.percentUnsigned
            
            if viewModel.topChart.spGrow > 0.0 {
                medianPercentChangeLabel.textColor = UIColor.Gainy.mainGreen
                medianArrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                medianArrowImgView.tintColor = UIColor.Gainy.mainGreen
                
            } else {
                medianPercentChangeLabel.textColor = UIColor.Gainy.mainRed
                medianArrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                medianArrowImgView.tintColor = UIColor.Gainy.mainRed
            }            
        } else {
            medianView.isHidden = true
        }
    }
    
    func configureAsWatchlist(tickersCount: Int) {
        tickersCountLabel.text = "\(tickersCount) " + (tickersCount == 1 ? "stock" : "stocks")
        tickersCountLabel.sizeToFit()
        
        percentArrowImgView.image = nil
        tickerPercentChangeLabel.text = ""
        todaysGainLabel.text = ""
        medianView.isHidden = true
    }
    
    lazy var tickersCountLabelView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
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
        label.text = "1.13%"
        label.font = .compactRoundedSemibold(24)
        label.textColor = UIColor.Gainy.mainGreen
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        label.isHiddenWhenSkeletonIsActive = true
        return label
    }()
    
    lazy var toggleImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "toggle_off")
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    //
    
    //MEDIAN
    lazy var medianView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        view.layer.cornerRadius = 8.0
        view.layer.masksToBounds = true
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
        return view
    }()
    
    lazy var medianTitleLbl: UILabel = {
        let label = UILabel()
        label.text = "SP500"
        label.font = UIFont.compactRoundedSemibold(12.0)
        label.textColor = UIColor.init(hexString: "#B1BDC8")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var medianArrowImgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrow-up-green")
        view.contentMode = .scaleAspectFit
        view.isSkeletonable = true
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var medianPercentChangeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedSemibold(12)
        label.textColor = UIColor.Gainy.mainGreen
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        label.isHiddenWhenSkeletonIsActive = true
        return label
    }()
    
    lazy var medianBtn: UIButton = {
        let label = UIButton()
        label.addTarget(self, action: #selector(medianAction), for: .touchUpInside)
        return label
    }()
    
    var isMedianVisible: Bool = false {
        didSet {
            medianView.backgroundColor = isMedianVisible ? UIColor.init(hexString: "0062FF")! : UIColor(hexString: "F7F8F9", alpha: 1.0)!
            toggleImgView.image = UIImage(named: isMedianVisible ? "toggle_on" : "toggle_off")
            medianTitleLbl.textColor = isMedianVisible ? .white : UIColor(hexString: "B1BDC8", alpha: 1.0)
        }
    }
    
    @objc func medianAction() {
        isMedianVisible.toggle()
        
        delegate?.medianToggled(cell: self, showMedian: isMedianVisible)
    }
}
