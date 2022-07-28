//
//  TickerDetailsAboutViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import PureLayout

protocol TickerDetailsAboutViewCellDelegate: AnyObject {
    func aboutExtended(isExtended: Bool)
    func collectionSelected(collection: RemoteCollectionDetails)
}

final class TickerDetailsAboutViewCell: TickerDetailsViewCell {
    
    public weak var delegate: TickerDetailsAboutViewCellDelegate?
    
    //MARK: - Outlets
    @IBOutlet private weak var aboutLbl: UILabel!
    @IBOutlet private weak var tagsStack: UIView!
    
    //MARK: - DI
    var minHeightUpdated: ((CGFloat) -> Void)?
    var isMoreSelected: Bool = false
    
    private var lines: Int = 1
    
    override func updateFromTickerData() {
        aboutLbl.text = tickerInfo?.about
        aboutLbl.numberOfLines = 3
        
        let calculatedHeight: CGFloat = (161.0 + ((tickerInfo?.linkedCollections.isEmpty ?? true) ? 0.0 : 88.0))
        if isMoreSelected {
            aboutLbl.numberOfLines = 0
            minHeightUpdated?(max( (152.0 + 16.0), heightBasedOnString((tickerInfo?.about ?? ""))))
        } else {
            aboutLbl.numberOfLines = 3
            minHeightUpdated?(max((152.0 + 16.0), calculatedHeight))
        }
        innerCollectionView.reloadData()
        innerCollectionView.isHidden = tickerInfo?.linkedCollections.isEmpty ?? true
        innerCollectionView.showsHorizontalScrollIndicator = false
    }
    
    @objc func tagViewTouchUpInside(_ tagView: TagView) {
        guard let collectionID = tagView.collectionID, collectionID > 0 else {
            return
        }
    }
    
    //MARK: - Actions
    @IBAction func showMoreAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        isMoreSelected.toggle()
        delegate?.aboutExtended(isExtended: isMoreSelected)
        if sender.isSelected {
            aboutLbl.numberOfLines = 0
            sender.setTitle("show less", for: .normal)
        } else {
            aboutLbl.numberOfLines = 3
            sender.setTitle("show more", for: .normal)
        }
        cellHeightChanged?(sender.isSelected ? heightBasedOnString(sender.isSelected ? (tickerInfo?.about ?? "") : (tickerInfo?.aboutShort ?? "")) : (161.0 + ((tickerInfo?.linkedCollections.isEmpty ?? true) ? 0.0 : 88.0)))
        if sender.isSelected {
            GainyAnalytics.logEvent("ticker_about_more_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        } else {
            GainyAnalytics.logEvent("ticker_about_less_pressed", params: ["tickerSymbol" : self.tickerInfo?.symbol ?? "none", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
        }
    }
    
    private func heightBasedOnString(_ str: String) -> CGFloat {
        //
        let height = str.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 60.0 * 2.0, font: UIFont.compactRoundedSemibold(12))
        return 60.0 + height + 48.0 + ((tickerInfo?.linkedCollections.isEmpty ?? true) ? 0.0 : 88.0)
    }
    
    private func showExplanationWith(title: String, description: String, height: CGFloat, linkText: String? = nil, link: String? = nil) {
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: title)
        explanationVc.configureWith(description: description, linkString: linkText, link: link)
        FloatingPanelManager.shared.configureWithHeight(height: height)
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
    //weak var delegate: TickerDetailsAlternativeStocksViewCellDelegate?
    private let cellSize: CGSize = .init(width: 240, height: 88)
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.register(TickerDetailsRelativeCollectionViewCell.self)
            innerCollectionView.isScrollEnabled = true
            innerCollectionView.isUserInteractionEnabled = true
        }
    }
}

extension TickerDetailsAboutViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.linkedCollections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TickerDetailsRelativeCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        //cell.overrideDrag = false
        if let collection = tickerInfo?.linkedCollections[indexPath.row] {
            cell.configureWith(collection: collection)
            cell.nameLabel.font = .proDisplayBold(16)
            cell.stocksAmountLabel.font = .proDisplaySemibold(12)
            cell.gainsLabel.font = .compactRoundedSemibold(12.0)
            cell.todayLabel.font = .compactRoundedMedium(12)
        }
        return cell
    }
}

extension TickerDetailsAboutViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension TickerDetailsAboutViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let collection = tickerInfo?.linkedCollections[indexPath.row] {
            delegate?.collectionSelected(collection: collection)
        }
    }
}


import UIKit
import Kingfisher

class TagView: UIButton {
    
    var collectionID: Int?
    
    var tagName: String? {
        didSet {
            tagLabel.text = tagName?.uppercased()
        }
    }
    
    private lazy var tagImageView: UIImageView = {
        let tagImageView = UIImageView()
        tagImageView.contentMode = .scaleAspectFill
        tagImageView.image = UIImage(named: "demoRocket")
        tagImageView.isUserInteractionEnabled = false
        return tagImageView
    }()
    
    private(set) lazy var tagLabel: UILabel = {
        let tagLabel = UILabel()
        tagLabel.textColor = .white
        tagLabel.font = .compactRoundedSemibold(12)
        tagLabel.isUserInteractionEnabled = false
        return tagLabel
    }()
    
    func changeLayoutForRec() {
        tagLabel.textColor = UIColor(named: "mainText")
        backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private var textLeadingConst: NSLayoutConstraint?
    
    private func setupView() {
        layer.cornerRadius = 4.0
        clipsToBounds = true
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(hexString: "#E7EAEE", alpha: 1.0)?.cgColor
        layer.cornerRadius = 12.0
        
        addSubview(tagImageView)
        tagImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 12))
        tagImageView.autoPinEdge(.leading, to: .leading, of: self, withOffset: 4)
        tagImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        addSubview(tagLabel)
        textLeadingConst = tagLabel.autoPinEdge(.leading, to: .leading, of: self, withOffset: 25)
        tagLabel.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: 8)
        tagLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
    }
    
    func loadImage(url: String) {
        guard !url.isEmpty else {
            tagImageView.image = nil
            textLeadingConst?.constant = 8.0
            layoutIfNeeded()
            return
        }
        let processor = DownsamplingImageProcessor(size: CGSize(width: 19, height: 14))
        tagImageView.kf.setImage(with: URL(string: url), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ], progressBlock: nil, completionHandler: nil)
    }
    
    //Highlight
    
    func setBorderForCollection() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.Gainy.blue.withAlphaComponent(0.5).cgColor
    }
    
    func setBorderForTicker() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(hexString: "#E7EAEE", alpha: 1.0)?.cgColor
    }
}
