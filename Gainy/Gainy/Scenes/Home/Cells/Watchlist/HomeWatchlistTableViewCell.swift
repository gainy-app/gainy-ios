//
//  HomeCollectionsTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import Kingfisher
import Apollo

protocol HomeWatchlistTableViewCellDelegate: AnyObject {
    func tickerSelected(ticker: RemoteTicker)
}

final class HomeWatchlistTableViewCell: UITableViewCell {
    
    weak var delegate: HomeWatchlistTableViewCellDelegate?
    private let cellHeight: CGFloat = 88
    let expandBtn = ResponsiveButton()
    var heightUpdated: ((CGFloat) -> Void)?
    var sortingPressed: (() -> Void)?
    var expandPressed: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let buttonWithLabel: (ResponsiveButton, UILabel) = self.newSortByButton()
        let button = buttonWithLabel.0
        let sortLabel = buttonWithLabel.1
        button.addTarget(self, action: #selector(sortWatchlistTapped), for: .touchUpInside)
        let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(Constants.CollectionDetails.watchlistCollectionID)
        sortLabel.text = settings.sortingText()
        sortLabel.sizeToFit()
        
        self.contentView.addSubview(button)
        button.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        button.autoPinEdge(toSuperviewEdge: .top, withInset: 72.0)
        button.autoSetDimension(.height, toSize: 24.0)
        button.sizeToFit()
        
        let titleLabel = UILabel.newAutoLayout()
        titleLabel.font = UIFont.proDisplaySemibold(20)
        titleLabel.textColor = UIColor.Gainy.textDark
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.text = "Watchlist"
        
        self.contentView.addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 16.0)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 28.0)
        titleLabel.autoSetDimension(.height, toSize: 20.0)
        titleLabel.sizeToFit()
        
        self.contentView.addSubview(expandBtn)
        expandBtn.addTarget(self, action: #selector(expandToggleAction), for: .touchUpInside)
        expandBtn.translatesAutoresizingMaskIntoConstraints = false
        expandBtn.backgroundColor = UIColor.clear
        expandBtn.setTitle("show all".uppercased(), for: .selected)
        expandBtn.setTitle("show less".uppercased(), for: .normal)
        expandBtn.setTitleColor(UIColor.Gainy.textDark, for: .normal)
        expandBtn.setTitleColor(UIColor.Gainy.textDark, for: .selected)
        expandBtn.titleLabel?.font = UIFont.compactRoundedSemibold(12)
        expandBtn.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        expandBtn.autoPinEdge(toSuperviewEdge: .top, withInset: 24.0)
        expandBtn.autoSetDimension(.height, toSize: 24.0)
        expandBtn.sizeToFit()
    }
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.setCollectionViewLayout(customLayout, animated: true)
            innerCollectionView.isScrollEnabled = false
            innerCollectionView.clipsToBounds = true
            innerCollectionView.contentInset = .init(top: 8, left: 0, bottom: 0, right: 0)
        }
    }
    
    @IBOutlet private weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.contentMode = .scaleToFill
            backgroundImageView.image = UIImage.init(named: "homeWLBackground")
            backgroundImageView.layer.cornerRadius = 24.0
            backgroundImageView.layer.masksToBounds = true
        }
    }
    
    private let homeLayout: HomeWatchlistFlowLayout = HomeWatchlistFlowLayout()
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.homeLayout.layoutSection(within: env)
        }
        return layout
    }()
    
    var watchlist: [RemoteTickerDetails] = [] {
        didSet {
            innerCollectionView.reloadData()
            expandBtn.isHidden = watchlist.count < 5
            calcSize(isSelected: expandBtn.isSelected)
        }
    }
    
    private func calcSize(isSelected: Bool = false) {
        guard !watchlist.isEmpty else {
            heightUpdated?(0.0)
            return
        }
        let topOffset: CGFloat = 120.0
        let bottomOffset: CGFloat = 8.0
        var height = topOffset + max(0.0, CGFloat(watchlist.count) * cellHeight + CGFloat(watchlist.count) * 8.0) - 8.0 + bottomOffset
        if isSelected {
            let count = (watchlist.count < 5) ? CGFloat(watchlist.count) : CGFloat(4)
            height = topOffset + max(0.0,count * cellHeight + count * 8.0) - 8.0 + bottomOffset
        }
        
        delay(0.1) {
            self.innerCollectionView.isScrollEnabled = false
            self.heightUpdated?(height)
        }
        layoutIfNeeded()
    }
    
    func newSortByButton() -> (ResponsiveButton, UILabel) {
        let button = ResponsiveButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.layer.cornerCurve = .continuous
        button.fillRemoteButtonBack()
        
        let reorderIconImageView = UIImageView(
            frame: CGRect(x: 0, y: 0, width: 16, height: 16)
        )
        reorderIconImageView.image = UIImage(named: "reorder")
        button.addSubview(reorderIconImageView)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        reorderIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        
        let sortByLabel = UILabel(
            frame: CGRect(x: 0, y: 0, width: 36, height: 16)
        )
        
        sortByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        sortByLabel.textColor = UIColor.Gainy.grayNotDark
        sortByLabel.numberOfLines = 1
        sortByLabel.textAlignment = .center
        sortByLabel.text = "Sort by"
        
        button.addSubview(sortByLabel)
        sortByLabel.autoSetDimensions(to: CGSize.init(width: 36, height: 16))
        sortByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        sortByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        
        let textLabel = UILabel(
            frame: CGRect(x: 0, y: 0, width: 77, height: 16)
        )
        
        textLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        textLabel.textColor = UIColor.Gainy.grayNotDark
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = "Watchlist"
        textLabel.minimumScaleFactor = 0.1
        button.addSubview(textLabel)
        textLabel.autoSetDimension(.height, toSize: 16)
        textLabel.autoPinEdge(.left, to: .right, of: sortByLabel, withOffset: 2.0)
        textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        textLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        textLabel.sizeToFit()
        
        return (button, textLabel)
    }
    
    //MARK: - Actions
    @objc private func expandToggleAction() {
        
        expandBtn.isSelected.toggle()
        calcSize(isSelected: expandBtn.isSelected)
        self.expandPressed?()
    }
    
    @objc private func sortWatchlistTapped() {
        
        self.sortingPressed?()
    }
}

extension HomeWatchlistTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        watchlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeWatchlistInnerTableViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.ticker = watchlist[indexPath.row]
        return cell
    }
}

extension HomeWatchlistTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tickerSelected(ticker: self.watchlist[indexPath.row])
    }
}


//Will be used further
final class HomeWatchlistInnerTableViewCell: UICollectionViewCell {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var absoluteValueLbl: UILabel!
    @IBOutlet weak var tickerSymbolLbl: UILabel!
    @IBOutlet weak var growContainer: UIView!
    @IBOutlet weak var relativeChangeLbl: UILabel!
    @IBOutlet weak var dotView: UIView! {
        didSet {
            dotView.layer.cornerRadius = 1.0
            dotView.layer.masksToBounds = false
            dotView.backgroundColor = UIColor.init(hexString: "#B1BDC8")
        }
    }
    @IBOutlet weak var absoluteChangeLbl: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var todayLbl: UILabel!
    
    @IBOutlet weak var msLbl: UILabel! {
        didSet {
            msLbl.clipsToBounds = true
            msLbl.layer.cornerRadius = 12.0
            msLbl.textColor = UIColor.Gainy.mainText
        }
    }
    
    var ticker: RemoteTickerDetails? {
        didSet {
            self.clipsToBounds = false
            self.layer.masksToBounds = false
            self.relativeChangeLbl.text = (ticker?.realtimeMetrics?.relativeDailyChange ?? 0.0).percentUnsigned
            self.relativeChangeLbl.sizeToFit()
            
            self.absoluteChangeLbl.text = ((ticker?.currentPrice ?? 0.0) *  (ticker?.realtimeMetrics?.relativeDailyChange ?? 0.0)).priceRaw
            self.absoluteChangeLbl.sizeToFit()
            
            self.todayLbl.sizeToFit()
            self.growContainer.sizeToFit()
            if (ticker?.realtimeMetrics?.relativeDailyChange ?? 0.0) > 0.0 {
                arrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                arrowImgView.tintColor = UIColor.Gainy.mainGreen
                self.relativeChangeLbl.textColor = UIColor.Gainy.mainGreen
                self.absoluteChangeLbl.textColor = UIColor.Gainy.mainGreen
            } else {
                if (ticker?.realtimeMetrics?.relativeDailyChange ?? 0.0) == 0.0 {
                    arrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                    arrowImgView.tintColor = .lightGray
                    self.relativeChangeLbl.textColor = .lightGray
                    self.absoluteChangeLbl.textColor = .lightGray
                } else {
                    arrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                    arrowImgView.tintColor = UIColor.Gainy.mainRed
                    self.relativeChangeLbl.textColor = UIColor.Gainy.mainRed
                    self.absoluteChangeLbl.textColor = UIColor.Gainy.mainRed
                }
            }
            
            self.nameLbl.text = ticker?.name?.companyMarkRemoved ?? ""
            self.absoluteValueLbl.text = (ticker?.currentPrice ?? 0.0).priceRaw
            self.tickerSymbolLbl.text = "\(ticker?.symbol ?? "")"
            self.tickerSymbolLbl.sizeToFit()
            if let matchScore = ticker?.matchScore?.matchScore {
                msLbl.text = "\(Int(matchScore))"
                msLbl.backgroundColor = MatchScoreManager.circleColorFor(Int(matchScore))
            } else {
                msLbl.text = "-"
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 16.0
        layer.cornerCurve = .continuous
        layer.masksToBounds = true

        contentView.layer.cornerRadius = 16.0
        contentView.layer.cornerCurve = .continuous
        contentView.layer.masksToBounds = true
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.cornerRadius = 16.0

        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
    }
}
