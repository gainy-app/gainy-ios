//
//  TickerDetailsHighlightsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsHighlightsViewCell: TickerDetailsViewCell {
    
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

extension TickerDetailsHighlightsViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.highlights.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TickerDetailsHighlightsInnerViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.highlightLbl.text = tickerInfo?.highlights[indexPath.row]
        return cell
    }    
}

extension TickerDetailsHighlightsViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize.init(width: 240, height: collectionView.bounds.height)
    }
}

final class TickerDetailsHighlightsInnerViewCell: UICollectionViewCell {
    
    @IBOutlet weak var highlightLbl: UILabel!
}
