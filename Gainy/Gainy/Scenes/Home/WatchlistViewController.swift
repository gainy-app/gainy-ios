//
//  WatchlistViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/5/22.
//

import UIKit
import Kingfisher
import Apollo
import GainyAPI

protocol WatchlistViewControllerDelegate: AnyObject {
    func tickerSelectedFromWL(ticker: RemoteTicker)
    func sortingPressedFromWL()
}

class WatchlistViewController: BaseViewController {

    weak var delegate: WatchlistViewControllerDelegate?
    private let cellHeight: CGFloat = 88
    var sortingButton: ResponsiveButton? = nil
    var sortingLabel: UILabel? = nil
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = RemoteConfigManager.shared.mainBackColor
        
        let buttonWithLabel: (ResponsiveButton, UILabel) = self.newSortByButton()
        let button = buttonWithLabel.0
        let sortLabel = buttonWithLabel.1
        button.addTarget(self, action: #selector(sortWatchlistTapped), for: .touchUpInside)
        let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(Constants.CollectionDetails.watchlistCollectionID)
        sortLabel.text = settings.sortingText()
        sortLabel.sizeToFit()
        self.sortingLabel = sortLabel
        self.sortingButton = button
        
        self.view.addSubview(button)
        button.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        button.autoPinEdge(.top, to: .bottom, of: self.titleLabel, withOffset: 24.0)
        button.autoSetDimension(.height, toSize: 24.0)
        button.sizeToFit()
        
        self.reloadData()
    }

    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.setCollectionViewLayout(customLayout, animated: true)
            innerCollectionView.isScrollEnabled = true
            innerCollectionView.clipsToBounds = true
            innerCollectionView.contentInset = .init(top: 8, left: 0, bottom: 0, right: 0)
        }
    }
    

    
    private let homeLayout: WatchlistCollectionViewFlowLayout = WatchlistCollectionViewFlowLayout()
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.homeLayout.layoutSection(within: env)
        }
        return layout
    }()
    
    var watchlist: [RemoteTickerDetails] = [] {
        didSet {
            if self.isViewLoaded {
                self.reloadData()
            }
        }
    }
    
    func reloadData() {
        
        let settings: CollectionSettings = CollectionsDetailsSettingsManager.shared.getSettingByID(Constants.CollectionDetails.watchlistCollectionID)
        self.sortingLabel?.text = settings.sortingText()
        self.sortingLabel?.sizeToFit()
        self.sortingButton?.sizeToFit()
        innerCollectionView.reloadData()
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
    
    @IBAction func closeButonTap(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @objc private func sortWatchlistTapped() {
        
        self.delegate?.sortingPressedFromWL()
    }

}

extension WatchlistViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        watchlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: WatchlistCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.ticker = watchlist[indexPath.row]
        return cell
    }
}

extension WatchlistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tickerSelectedFromWL(ticker: self.watchlist[indexPath.row])
    }
}

final class WatchlistCollectionViewCell: UICollectionViewCell {
    
    
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
