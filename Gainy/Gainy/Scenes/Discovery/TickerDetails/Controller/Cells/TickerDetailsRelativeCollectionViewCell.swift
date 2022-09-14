//
//  TickerDetailsRelativeCollectionViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 05.05.2022.
//

import UIKit
import Kingfisher
import PureLayout
import GainyAPI

final class TickerDetailsRelativeCollectionViewCell: UICollectionViewCell {
        
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(stocksView)
        stocksView.addSubview(stocksAmountLabel)
        contentView.addSubview(todayLabel)
        
        contentView.addSubview(msLabel)
        contentView.addSubview(msCircle)
        
        contentView.addSubview(gainsView)
        gainsView.addSubview(growArrowImgView)
        gainsView.addSubview(gainsLabel)
        
        backImageView.clipsToBounds = true
        backImageView.layer.cornerRadius = 19
        backImageView.layer.cornerCurve = .continuous
        
        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white
        
        stocksView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
        stocksView.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 48.0)
        stocksView.autoSetDimension(.height, toSize: 24)
        
        stocksAmountLabel.autoPinEdge(.trailing, to: .trailing, of: stocksView, withOffset: -8)
        stocksAmountLabel.autoPinEdge(.leading, to: .leading, of: stocksView, withOffset: 8)
        stocksAmountLabel.autoAlignAxis(.horizontal, toSameAxisOf: stocksView)
                
        todayLabel.autoAlignAxis(.horizontal, toSameAxisOf: nameLabel)
        todayLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -24.0)
        
        nameLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 16)
        nameLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16.0)
        nameLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -87.0)
        
        msLabel.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
        msLabel.autoPinEdge(.leading, to: .leading, of: contentView, withOffset: 16.0)
        msLabel.autoSetDimensions(to: .init(width: 24, height: 24))
        
        msCircle.autoSetDimensions(to: .init(width: 22, height: 22))
        msCircle.autoAlignAxis(.horizontal, toSameAxisOf: msLabel, withMultiplier: 1.0)
        msCircle.autoAlignAxis(.vertical, toSameAxisOf: msLabel, withMultiplier: 1.0)
        
        gainsView.autoPinEdge(.bottom, to: .bottom, of: contentView, withOffset: -16)
        gainsView.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16)
        gainsView.autoSetDimension(.height, toSize: 24)
        
        growArrowImgView.autoPinEdge(.leading, to: .leading, of: gainsView, withOffset: 8)
        growArrowImgView.autoAlignAxis(.horizontal, toSameAxisOf: gainsView, withMultiplier: 1.0)
        growArrowImgView.autoSetDimensions(to: .init(width: 8, height: 8))
        
        gainsLabel.autoPinEdge(.leading, to: .leading, of: gainsView, withOffset: 20)
        gainsLabel.autoPinEdge(.trailing, to: .trailing, of: gainsView, withOffset: -8)
        gainsLabel.autoAlignAxis(.horizontal, toSameAxisOf: gainsView, withMultiplier: 1.0)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 16.0
    private var fillColor: UIColor = .blue
    private var imageUrl: String = ""
    private var imageLoaded: Bool = false
    // MARK: Properties
    
    var onDeleteButtonPressed: (() -> Void)?
    var onCellLifted: (() -> Void)?
    var onCellStopDragging: (() -> Void)?
    
    lazy var backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isOpaque = true
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        return imageView
    }()
    
    
    lazy var blackAlphaView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFill
        view.isOpaque = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        backImageView.addSubview(view)
        view.autoPinEdgesToSuperviewEdges()
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = .proDisplayBold(18)
        label.textColor = UIColor.Gainy.white
        
        label.numberOfLines = 1
        label.textAlignment = .left
        label.minimumScaleFactor = 0.1
        
        return label
    }()
    
    lazy var todayLabel: UILabel = {
        let label = UILabel()
        
        label.font = .compactRoundedMedium(12)
        label.textColor = UIColor.Gainy.white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "TODAY"
        label.sizeToFit()
        
        return label
    }()
    
    lazy var stocksView: UIView = {
        let stocksView = UIView()
        stocksView.backgroundColor = UIColor(hexString: "687379")?.withAlphaComponent(0.4)
        stocksView.layer.cornerRadius = 12.0
        stocksView.clipsToBounds = true
        return stocksView
    }()
    
    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 10)
        label.textColor = UIColor.Gainy.white
        
        label.numberOfLines = 1
        label.textAlignment = .right
        label.minimumScaleFactor = 0.1
        
        return label
    }()
    
    //MARK: - MS
    
    lazy var msLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .compactRoundedSemibold(12.0)
        label.layer.cornerRadius = 12.0
        label.clipsToBounds = true
        return label
    }()
    
    lazy var msCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "match_score_col")
        return imageView
    }()
    
    //MARK: - Gains
    
    lazy var gainsView: UIView = {
        let stocksView = UIView()
        stocksView.layer.cornerRadius = 12.0
        stocksView.clipsToBounds = true
        return stocksView
    }()
    
    lazy var gainsLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .compactRoundedSemibold(14.0)
        return label
    }()
    
    lazy var growArrowImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "match_score_col")
        return imageView
    }()
    
    private func loadImage() {
        
        guard self.imageLoaded == false, backImageView.bounds.size.width > 0, backImageView.bounds.size.height > 0 else {
            return
        }
        
        let processor = DownsamplingImageProcessor(size: backImageView.bounds.size)
        backImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) { receivedSize, totalSize in
            //            print("-----\(receivedSize), \(totalSize)")
        } completionHandler: { result in
            //            print("-----\(result)")
        }
        self.imageLoaded = true
    }
    
    override func didMoveToWindow() {
        
        super.didMoveToWindow()
        
        if window != nil {
            self.imageLoaded = false
            loadImage()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.loadImage()
        
        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )
        
        let isTop20 = false //(Constants.CollectionDetails.top20ID == self.tag) ? true : false
        self.nameLabel.textColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0) : UIColor.Gainy.white
        self.stocksAmountLabel.textColor = .white
        self.contentView.layer.borderWidth = isTop20 ? 1.0 : 0.0
        self.contentView.layer.borderColor = isTop20 ? UIColor(hexString: "#FC5058", alpha: 1.0)?.cgColor : UIColor.clear.cgColor
        self.contentView.layer.cornerRadius = 16.0
    }
    
    // MARK: Functions
    
    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {
        switch dragState {
        case .lifting:
            onCellLifted?()
        case .dragging:
            layer.opacity = 0
        case .none:
            layer.opacity = 1
            onCellStopDragging?()
        default:
            return
        }
    }
    
    func configureWith(collection: RemoteCollectionDetails) {
        backImageView.contentMode = .scaleAspectFill
        self.imageLoaded = false
        self.imageUrl = collection.imageUrl ?? ""
        setNeedsLayout()
        
        nameLabel.text = collection.name
        nameLabel.sizeToFit()
        
        stocksAmountLabel.text = "\(collection.size ?? 0) stock\((collection.size ?? 0) > 1 ? "s" : "")"
        
        if collection.metrics?.relativeDailyChange ?? 0.0 > 0.0 {
            gainsView.backgroundColor = UIColor.Gainy.secondaryGreen
            growArrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
            growArrowImgView.tintColor = UIColor.Gainy.mainText
            gainsLabel.textColor = UIColor.Gainy.mainText
            
        } else {
            gainsView.backgroundColor = UIColor.Gainy.mainRed
            growArrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
            growArrowImgView.tintColor = .white
            gainsLabel.textColor = .white
        }
        gainsLabel.text = collection.metrics?.relativeDailyChange?.percentUnsigned ?? ""
        
        let matchScore = Int(collection.matchScore?.matchScore ?? 0.0)
        msLabel.text = "\(matchScore)"
        msLabel.backgroundColor = MatchScoreManager.circleColorFor(matchScore)
        
        layoutIfNeeded()
    }
}
