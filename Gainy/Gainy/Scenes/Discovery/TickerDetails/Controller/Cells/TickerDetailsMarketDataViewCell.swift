//
//  TickerDetailsMarketDataViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
final class TickerDetailsMarketDataViewCell: TickerDetailsViewCell {
    
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

extension TickerDetailsMarketDataViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.marketData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TickerDetailsMarketInnerViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.marketData = tickerInfo?.marketData[indexPath.row]
        return cell
    }
}

extension TickerDetailsMarketDataViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: (UIScreen.main.bounds.width - 18.0 * 2.0) / 3.0 - 16.0, height: 96.0)
    }
}

final class TickerDetailsMarketInnerViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var periodLbl: UILabel!
    @IBOutlet private weak var valueLbl: UILabel!
    
    var marketData: TickerInfo.MarketData? {
        didSet {
            nameLbl.text = marketData?.name
            periodLbl.text = marketData?.period.uppercased()
            valueLbl.text = "\((marketData?.value ?? 0.0))"
        }
    }
}
