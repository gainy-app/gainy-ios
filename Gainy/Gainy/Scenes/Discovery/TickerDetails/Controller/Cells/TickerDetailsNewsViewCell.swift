//
//  TickerDetailsNewsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.08.2021.
//

import UIKit

final class TickerDetailsNewsViewCell: TickerDetailsViewCell {
    
    @IBOutlet weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellWithReuseIdentifier: NewsViewCell.cellIdentifier)
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
        }
    }
    
    override func updateFromTickerData() {
        innerCollectionView.reloadData()
    }
}

extension TickerDetailsNewsViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tickerInfo?.news.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.news = tickerInfo?.news[indexPath.row]
        return cell
    }
}

extension TickerDetailsNewsViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 240, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 28, bottom: 0, right: 0)
    }
}
