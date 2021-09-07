//
//  TickerDetailsAlternativeStocksViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

protocol TickerDetailsAlternativeStocksViewCellDelegate: AnyObject {
    func comparePressed(stock: SearchTickersQuery.Data.Ticker)
}

final class TickerDetailsAlternativeStocksViewCell: TickerDetailsViewCell {
    
    weak var delegate: TickerDetailsAlternativeStocksViewCellDelegate?
    
    @IBOutlet weak var innerCollectionView: UICollectionView! {
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
        cell.isInCompare = tickerInfo?.tickersToCompare.contains(where: {$0.symbol == cell.stock?.symbol}) ?? false
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
    
    var stock: SearchTickersQuery.Data.Ticker? {
        didSet {
            guard let stock = stock else {return}
            nameLbl.text = stock.name
            symbolLbl.text = stock.symbol
            
            let priceChange = stock.tickerFinancials.last?.priceChangeToday ?? 0.0
            priceLbl.text = stock.tickerFinancials.last?.currentPrice?.price ?? ""
            priceLbl.textColor = priceChange >= 0.0 ? UIColor(named: "mainGreen") : UIColor(named: "mainRed")
            
            highlightLbl.text = stock.tickerFinancials.last?.highlight ?? "Demo text here"
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
    func comparePressed(stock: SearchTickersQuery.Data.Ticker) {
        delegate?.comparePressed(stock: stock)
    }
}
