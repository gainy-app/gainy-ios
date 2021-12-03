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
}

final class TickerDetailsAlternativeStocksViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 258.0
    
    weak var delegate: TickerDetailsAlternativeStocksViewCellDelegate?
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
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
        let cell: TickerDetailsAlternativeInnerStocksViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.stock = tickerInfo?.altStocks[indexPath.row]
        if let stock = tickerInfo?.altStocks[indexPath.row] {
            cell.isInCompare = delegate?.isStockCompared(stock: stock) ?? false
        }       
        cell.delegate = self
        return cell
    }
}

extension TickerDetailsAlternativeStocksViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 130.0, height: 164.0 + 28.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 28, bottom: 0, right: 0)
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
            matchCircle.tintColor = UIColor(named: "mainGreen")
        }
    }
    @IBOutlet private weak var matchLabel: UILabel!
    
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
            
            let priceChange = stock.realtimeMetrics?.relativeDailyChange ?? 0.0
            priceLbl.text = stock.realtimeMetrics?.actualPrice?.price ?? ""
            priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
            
            highlightLbl.text = stock.tickerHighlights.compactMap(\.highlight).first(where: {!$0.isEmpty}) ?? ""
            
            if let matchScore = TickerLiveStorage.shared.getMatchData(stock.symbol ?? "")?.matchScore {
                matchLabel.text = "\(matchScore)"
                if matchScore > 50 {
                    matchLabel.textColor = UIColor(named: "mainGreen")
                    matchCircle.tintColor = UIColor(named: "mainGreen")
                } else {
                    matchLabel.textColor = UIColor(named: "mainRed")
                    matchCircle.tintColor = UIColor(named: "mainRed")
                }
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

extension TickerDetailsAlternativeStocksViewCell: TickerDetailsAlternativeStocksViewCellDelegate {
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
