import UIKit
import Kingfisher
import PureLayout



final class YourCollectionViewCell: SwipeCollectionViewCell {
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(stocksLabel)
        contentView.addSubview(stocksAmountLabel)
        
        backImageView.clipsToBounds = true
        backImageView.layer.cornerRadius = 8
        backImageView.layer.cornerCurve = .continuous
        
        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white
                
        stocksLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 20)
        stocksLabel.autoPinEdge(.trailing, to: .trailing, of: contentView, withOffset: -16.0)
        
        stocksAmountLabel.autoPinEdge(.top, to: .top, of: contentView, withOffset: 36)
        stocksAmountLabel.autoAlignAxis(.vertical, toSameAxisOf: stocksLabel)
        
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 8.0
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
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        label.textColor = UIColor.Gainy.white
        
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var descriptionLabel: UITextView = {
        let label = UITextView()
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor.Gainy.white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.automaticallyAdjustsScrollIndicatorInsets = false
        label.contentInsetAdjustmentBehavior = .never
        label.contentInset = UIEdgeInsets(top: -8, left: -4,
                                          bottom: 0, right: 0)
        
        return label
    }()
    
    lazy var stocksLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Medium", size: 9)
        label.textColor = UIColor.Gainy.white
        label.numberOfLines = 1
        label.textAlignment = .right
        label.text = "STOCKS"
        label.sizeToFit()
        
        return label
    }()
    
    lazy var stocksAmountLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont(name: "SFCompactRounded-Semibold", size: 32)
        label.textColor = UIColor.Gainy.yellow
        
        label.numberOfLines = 1
        label.textAlignment = .right
        
        return label
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.loadImage()
        
        let hMargin: CGFloat = 16
        
        let availableWidth = bounds.width - (hMargin + 71)
        let descLabelFont = UIFont(name: "SFProDisplay-Regular", size: 14)
        let neededSize = descriptionLabel.text.size(
            withAttributes: [
                NSAttributedString.Key.font: descLabelFont as Any,
            ]
        )
        
        let nameHeight: CGFloat = 24
        let minDescHeight: CGFloat = neededSize.width > availableWidth ? 32 : 16
        let pairedHeight = nameHeight + 4 + minDescHeight
        
        
        let topMarginRightSide: CGFloat = 20
        let topMarginLeftSide = (bounds.height - pairedHeight) / 2
        
        backImageView.frame = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height
        )
        
        nameLabel.frame = CGRect(
            x: hMargin,
            y: topMarginLeftSide,
            width: bounds.width - (hMargin + 71),
            height: nameHeight
        )
        
        descriptionLabel.frame = CGRect(
            x: hMargin,
            y: topMarginLeftSide + nameLabel.bounds.height + 4,
            width: bounds.width - (hMargin + 71),
            height: minDescHeight
        )
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
    
    func configureWith(
        name: String,
        imageUrl: String,
        description: String,
        stocksAmount: String,
        imageName: String
    ) {
        backImageView.contentMode = .scaleAspectFill
        self.imageLoaded = false
        self.imageUrl = imageUrl
        setNeedsLayout()
        
        nameLabel.text = name
        nameLabel.sizeToFit()
        
        descriptionLabel.text = description
        descriptionLabel.sizeToFit()
        
        stocksAmountLabel.text = stocksAmount
        stocksAmountLabel.sizeToFit()
        
        layoutIfNeeded()
    }
    
    // MARK: Private
    
    // MARK: Types
    
    private enum Constant {
        static let swipeAnimationDurations: TimeInterval = 0.15
        static let swipeHorizontalShift: CGFloat = 40.0
    }
}

extension YourCollectionViewCell: SwipeCollectionViewCellDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForItemAt _: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default) { [weak self]  _, position in
            self?.onDeleteButtonPressed?()
        }
        deleteAction.image = UIImage(named: "trash")
        
        return [deleteAction]
    }
}
