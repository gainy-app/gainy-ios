//
//  TickerDetailsAlternativeStocksViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

protocol TickerDetailsAlternativeStocksViewCellDelegate: AnyObject {
    func altStockPressed(stock: AltStockTicker)
    func comparePressed(stock: AltStockTicker)
    func isStockCompared(stock: AltStockTicker) -> Bool
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell)
}

final class TickerDetailsAlternativeStocksViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 144.0 + 18.0 + 20 + 42 + 6.0
    
    private let cellWidth: CGFloat = 144.0
    
    weak var delegate: TickerDetailsAlternativeStocksViewCellDelegate?
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.register(UINib.init(nibName: HomeTickerInnerTableViewCell.cellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: HomeTickerInnerTableViewCell.reuseIdentifier)
            innerCollectionView.clipsToBounds = false
            innerCollectionView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: -5.0, right: 0.0)
            innerCollectionView.showsHorizontalScrollIndicator = false
        }
    }
    
    
    override func updateFromTickerData() {
        innerCollectionView.reloadData()
    }
}

extension TickerDetailsAlternativeStocksViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.altStocks.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeTickerInnerTableViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.clipsToBounds = false
        cell.stock = tickerInfo?.altStocks[indexPath.row]
        return cell
    }
}

extension TickerDetailsAlternativeStocksViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension TickerDetailsAlternativeStocksViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let stock = tickerInfo?.altStocks[indexPath.row] {
            delegate?.altStockPressed(stock: stock)
        }
    }
}

//Will be used further
final class TickerDetailsAlternativeInnerStocksViewCell: UICollectionViewCell {
    
    
    weak var delegate: TickerDetailsAlternativeStocksViewCellDelegate?
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var highlightLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var compareBtn: UIButton! {
        didSet {
            compareBtn.setImage(UIImage(named: "ticker_added_icon"), for: .selected)
            compareBtn.setTitle("added", for: .selected)
            
            compareBtn.setImage(UIImage(named: "tiny_plus"), for: .normal)
            compareBtn.setTitle("add to compare", for: .normal)
            
            compareBtn.addTarget(self, action: #selector(compareAction), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var matchCircle: UIImageView! {
        didSet {
            matchCircle.image = UIImage(named: "match_circle")!.withRenderingMode(.alwaysTemplate)
            matchCircle.tintColor = .white
        }
    }
    @IBOutlet private weak var matchLabel: UILabel! {
        didSet {
            matchLabel.layer.cornerRadius = 12.0
            matchLabel.clipsToBounds = true
        }
    }
    
    //MARK: - Properties
    var isInCompare: Bool = false {
        didSet {
            if isInCompare {
                bottomView.backgroundColor = UIColor(named: "mainGreen")
                compareBtn.isSelected = true
            } else {
                bottomView.backgroundColor = UIColor(hexString: "3A4448")
                compareBtn.isSelected = false
            }
        }
    }
    
    var stock: AltStockTicker? {
        didSet {
            guard let stock = stock else {return}
            nameLbl.text = stock.name
            symbolLbl.text = stock.symbol
            
            let storedData = TickerLiveStorage.shared.getSymbolData(stock.symbol ?? "")
            let priceChange = storedData?.priceChangeToday ?? 0.0
            priceLbl.text = storedData?.currentPrice.price ?? ""
            priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
            
            highlightLbl.text = stock.tickerHighlights.compactMap(\.highlight).first(where: {!$0.isEmpty}) ?? ""
            
            if let matchScore = TickerLiveStorage.shared.getMatchData(stock.symbol ?? "")?.matchScore {
                matchLabel.text = "\(matchScore)"
                matchLabel.backgroundColor = MatchScoreManager.circleColorFor(matchScore)                
            } else {
                matchLabel.text = "-"
            }
        }
    }
    
    //MARK: - Actions
    
    @objc func compareAction() {
        if let stock = stock {
            delegate?.comparePressed(stock: stock)
        }
        isInCompare.toggle()
    }
}

extension TickerDetailsAlternativeStocksViewCell: HomeTickerInnerTableViewCellDelegate {
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        delegate?.wlPressed(stock: stock, cell: cell)
    }
}

extension TickerDetailsAlternativeStocksViewCell: TickerDetailsAlternativeStocksViewCellDelegate {
    func wlPressed(stock: AltStockTicker, cell: TickerDetailsAlternativeStocksViewCell) {
        
    }
    
    func isStockCompared(stock: AltStockTicker) -> Bool {
        delegate?.isStockCompared(stock: stock) ?? false
    }
    
    func altStockPressed(stock: AltStockTicker) {
        delegate?.altStockPressed(stock: stock)
    }
    
    func comparePressed(stock: AltStockTicker) {
        delegate?.comparePressed(stock: stock)
    }
}
