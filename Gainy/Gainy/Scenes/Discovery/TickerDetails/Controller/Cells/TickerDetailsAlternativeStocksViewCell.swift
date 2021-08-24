//
//  TickerDetailsAlternativeStocksViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsAlternativeStocksViewCell: TickerDetailsViewCell {
    
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
        cell.highlightLbl.text = tickerInfo?.news[indexPath.row].title
        return cell
    }
}

extension TickerDetailsAlternativeStocksViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 130.0, height: 164.0 + 28.0)
    }
}

//Wil lbe used further
final class TickerDetailsAlternativeInnerStocksViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var highlightLbl: UILabel!
    
    var stock: CollectionCardViewCellModel? {
        didSet {
            guard let stock = stock else {return}
            
            
        }
    }
}
