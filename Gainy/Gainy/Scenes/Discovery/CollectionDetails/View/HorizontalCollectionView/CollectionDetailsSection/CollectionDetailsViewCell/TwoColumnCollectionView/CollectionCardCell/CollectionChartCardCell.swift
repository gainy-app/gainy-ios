//
//  CollectionListCardCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 26.08.2021.
//

import UIKit
import SkeletonView
import PureLayout

final class CollectionChartCardCell: RoundedDashedCollectionViewCell {
    
    var progressView: PieChartView? = nil
    var overlayView: UIView? = nil
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func removeContentView() {
        
        let subviews = self.contentView.subviews
        for view in subviews {
            view.removeFromSuperview()
        }
    }
    
    private func setupLayout(data: GetTtfPieChartQuery.Data.CollectionPiechart, index: Int) {
        
        self.removeContentView()
        self.isSkeletonable = true
        
        if data.entityType == "ticker" {
            
            contentView.addSubview(percentBackView)
            percentBackView.addSubview(percentLabel)
            percentBackView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
            percentBackView.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16)
            percentLabel.autoPinEdge(.top, to: .top, of: percentBackView, withOffset: 6)
            percentLabel.autoPinEdge(.left, to: .left, of: percentBackView, withOffset: 22)
            percentLabel.autoPinEdge(.right, to: .right, of: percentBackView, withOffset: -6)
            percentLabel.autoPinEdge(.bottom, to: .bottom, of: percentBackView, withOffset: -6)
            
            contentView.addSubview(nameLabel)
            nameLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16.0)
            nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16.0)
            nameLabel.autoSetDimension(.height, toSize: 24.0)

//            contentView.addSubview(totalPriceLabel)
//            totalPriceLabel.autoPinEdge(.right, to: .right, of: contentView, withOffset: -16.0)
//            totalPriceLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16.0)
//            totalPriceLabel.autoSetDimension(.height, toSize: 24.0)
//            totalPriceLabel.autoPinEdge(.left, to: .right, of: nameLabel, withOffset: 12.0)
            
            contentView.addSubview(totalChangeRelativeLabel)
            totalChangeRelativeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 53.0)
            totalChangeRelativeLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 16.0)
            totalChangeRelativeLabel.autoSetDimension(.height, toSize: 14.0)
            
            let dotView: UIView = UIView.newAutoLayout()
            dotView.backgroundColor = UIColor.init(hexString: "#B1BDC8")
            dotView.layer.cornerRadius = 1.0
            dotView.layer.masksToBounds = true
            contentView.addSubview(dotView)
            dotView.autoPinEdge(toSuperviewEdge: .top, withInset: 59.0)
            dotView.autoSetDimensions(to: CGSize.init(width: 2, height: 2))
            dotView.autoPinEdge(.right, to: .left, of: totalChangeRelativeLabel, withOffset: -4.0)
            
            contentView.addSubview(totalChangeAbsoluteValue)
            totalChangeAbsoluteValue.autoPinEdge(toSuperviewEdge: .top, withInset: 53.0)
            totalChangeAbsoluteValue.autoSetDimension(.height, toSize: 14.0)
            totalChangeAbsoluteValue.autoPinEdge(.right, to: .left, of: dotView, withOffset: -4.0)
            

            contentView.addSubview(arrowView)
            arrowView.autoSetDimensions(to: CGSize.init(width: 8, height: 8))
            arrowView.autoPinEdge(toSuperviewEdge: .top, withInset: 56.0)
            arrowView.autoPinEdge(.right, to: .left, of: totalChangeAbsoluteValue, withOffset: -4.0)
           
            let todayLabel = UILabel()
            todayLabel.font = UIFont.compactRoundedMedium(14)
            todayLabel.textColor = UIColor.init(hexString: "#B1BDC8")
            todayLabel.numberOfLines = 1
            todayLabel.textAlignment = .left
            contentView.addSubview(todayLabel)
            todayLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 53.0)
            todayLabel.autoPinEdge(.right, to: .left, of: arrowView, withOffset: -4.0)
            todayLabel.autoSetDimension(.height, toSize: 14.0)
            todayLabel.autoSetDimension(.width, toSize: 37.0)
            todayLabel.isSkeletonable = true
            todayLabel.isHiddenWhenSkeletonIsActive = true
            todayLabel.text = "Today"
            todayLabel.sizeToFit()
        }
        else {
            contentView.addSubview(percentBackView)
            percentBackView.addSubview(percentLabel)
            percentBackView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
            percentBackView.autoPinEdge(.right, to: .right, of: contentView, withOffset: -16)
            percentLabel.autoPinEdge(.top, to: .top, of: percentBackView, withOffset: 6)
            percentLabel.autoPinEdge(.left, to: .left, of: percentBackView, withOffset: 22)
            percentLabel.autoPinEdge(.right, to: .right, of: percentBackView, withOffset: -6)
            percentLabel.autoPinEdge(.bottom, to: .bottom, of: percentBackView, withOffset: -6)
            
            let dummyView = UIView.newAutoLayout()
            contentView.addSubview(dummyView)
            dummyView.backgroundColor = UIColor.clear
            dummyView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
            dummyView.autoSetDimension(.width, toSize: 16.0)
            percentBackView.autoPinEdge(.left, to: .right, of: dummyView)
            
            contentView.addSubview(nameLabel)
            nameLabel.autoPinEdge(.left, to: .left, of: contentView, withOffset: 16.0)
            nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16.0)
            nameLabel.autoSetDimension(.height, toSize: 24.0)
            nameLabel.autoPinEdge(.right, to: .left, of: dummyView, withOffset: 0.0, relation: .lessThanOrEqual)
        }
        
        
        addIndicatorView()
        
        layer.isOpaque = true
        contentView.fillRemoteButtonBack()
        contentView.layer.cornerRadius = 16.0
    }
    
    func configureWithChartData(data: GetTtfPieChartQuery.Data.CollectionPiechart, index: Int) {
        
        self.setupLayout(data: data, index: index)
        
        nameLabel.text = data.entityName?.companyMarkRemoved
        nameLabel.adjustsFontSizeToFitWidth = true
//        nameLabel.sizeToFit()
        
//        totalPriceLabel.text = (data.absoluteValue ?? 0.0).price
//        totalPriceLabel.sizeToFit()
        
        let colors = UIColor.Gainy.pieChartColors
        let color = (index <= 8 ? colors[index] : colors[9]) ?? UIColor.white
        percentBackView.backgroundColor = color
        
        percentLabel.text = ((data.weight ?? 0.0) * 100.0).percentRaw
        
        let valueString = abs(((data.relativeDailyChange ?? 0.0) * 100.0)).percentRaw
        totalChangeRelativeLabel.text = valueString
        totalChangeRelativeLabel.sizeToFit()
    
        totalChangeAbsoluteValue.text = (abs(data.absoluteDailyChange ?? 0.0)).price
        totalChangeAbsoluteValue.sizeToFit()
        
        let image = (data.absoluteDailyChange ?? 0.0) >= 0.0 ? UIImage(named: "arrow-up-green") : UIImage(named: "arrow-down-red")
        arrowView.image = image?.withRenderingMode(.alwaysTemplate)
       
        let weight = (data.weight ?? 0.0) * 100.0
        let segments: [PieChartSegment] = [
            PieChartSegment.init(color: UIColor.white, value: CGFloat(weight)),
            PieChartSegment.init(color: UIColor.init(white: 1.0, alpha: 0.15), value: 100.0 - CGFloat(weight))
        ]
        self.progressView?.segments = segments
        self.overlayView?.backgroundColor = color
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
//        totalPriceLabel.text = ""
        totalChangeRelativeLabel.text = ""
        percentLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
    }
    
    public func addIndicatorView() {
        
        
        let segments: [PieChartSegment] = []
    
        let pieChartView = PieChartView()
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.frame = CGRect(x: 0, y: 0, width: 12, height: 12)
        pieChartView.segments = segments
        percentBackView.addSubview(pieChartView)
        pieChartView.autoPinEdge(toSuperviewEdge: .left, withInset: 6.0)
        pieChartView.autoAlignAxis(toSuperviewAxis: .horizontal)
        pieChartView.autoSetDimension(.height, toSize: 12.0)
        pieChartView.autoSetDimension(.width, toSize: 12.0)
        
        let overlayView = UIView.newAutoLayout()
        overlayView.backgroundColor = UIColor.clear
        pieChartView.addSubview(overlayView)
        overlayView.layer.masksToBounds = true
        overlayView.layer.cornerRadius = 4.0
        overlayView.autoCenterInSuperview()
        overlayView.autoSetDimensions(to: CGSize.init(width: 8.0, height: 8.0))
        self.overlayView = overlayView
        
        
//        let circularProgress = CircularProgress(frame: CGRect(x: 6.0, y: 6.0, width: 12.0, height: 12.0))
//        circularProgress.progressColor = UIColor.white
//        circularProgress.trackColor = UIColor.init(white: 1.0, alpha: 0.3)
//        percentBackView.addSubview(circularProgress)
//
//

        self.progressView = pieChartView
    }
    
    // MARK: Internal
    
    // MARK: Properties
    
    lazy var arrowView: UIImageView = {
        let arrowView = UIImageView()
        arrowView.isSkeletonable = true
        arrowView.isHiddenWhenSkeletonIsActive = true
        arrowView.tintColor = UIColor.init(hexString: "#09141F")
        return arrowView
    }()
    
    lazy var totalChangeAbsoluteValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedSemibold(14)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        label.textColor = UIColor.init(hexString: "#09141F")
        return label
    }()
    
    lazy var totalChangeRelativeLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.compactRoundedSemibold(14)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        label.textColor = UIColor.init(hexString: "#09141F")
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        // smth like: UIFont.Gainy.SFProDisplay
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor.init(hexString: "#131313")
        
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        label.adjustsFontSizeToFitWidth = true
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        label.linesCornerRadius = 6
        return label
    }()
    
    lazy var percentBackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hexString: "#1B45FB")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.skeletonCornerRadius = 6
        view.isHiddenWhenSkeletonIsActive = true
        return view
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedSemibold(12.0) // 14?
        label.textColor = UIColor.white
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.isSkeletonable = true
        label.linesCornerRadius = 6
        
        return label
    }()
    
//    lazy var totalPriceLabel: UILabel = {
//        let label = UILabel()
//
//        label.font = .proDisplayBold(16.0)
//        label.textColor = UIColor.init(hexString: "#09141F")
//        label.numberOfLines = 1
//        label.lineBreakMode = .byTruncatingTail
//        label.textAlignment = .right
//        label.isSkeletonable = true
//        label.linesCornerRadius = 6
//
//        return label
//    }()
}
