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
    private let cellWidth: CGFloat = 88
    
    var heightUpdated: ((CGFloat) -> Void)?
    
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
    
    private let homeLayout: HomeWatchlistFlowLayout = HomeWatchlistFlowLayout()
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.homeLayout.layoutSection(within: env)
        }
        return layout
    }()
    
    @IBOutlet private weak var watchlistHeight: NSLayoutConstraint!
    @IBOutlet private weak var expandBtn: UIButton!
    @IBOutlet private weak var dotsView: UIImageView!
    
    var watchlist: [RemoteTickerDetails] = [] {
        didSet {
            innerCollectionView.reloadData()
            expandBtn.isHidden = watchlist.count < 5
            dotsView.isHidden = watchlist.isEmpty
            calcSize(isSelected: watchlist.count < 5)
        }
    }
    
    private func calcSize(isSelected: Bool = false) {
        guard !watchlist.isEmpty else {
            heightUpdated?(0.0)
            return
        }
        if isSelected {
            watchlistHeight.constant = max(0.0, CGFloat(watchlist.count) * cellWidth + CGFloat(watchlist.count) * 8.0) + 8.0
        } else {
            watchlistHeight.constant = CGFloat(4) * cellWidth + CGFloat(4) * 8.0 + 8.0
        }
        let bottomOffset: CGFloat = watchlist.count > 4 ? 24.0 : 24.0
        delay(0.1) {
            self.innerCollectionView.isScrollEnabled = false
            self.heightUpdated?(8.0 + self.watchlistHeight.constant + bottomOffset)
        }
        layoutIfNeeded()
    }
    
    
    //MARK: - Actions
    @IBAction func expandToggleAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        calcSize(isSelected: sender.isSelected)
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
                
                arrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                arrowImgView.tintColor = UIColor.Gainy.mainRed
                self.relativeChangeLbl.textColor = UIColor.Gainy.mainRed
                self.absoluteChangeLbl.textColor = UIColor.Gainy.mainRed
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
