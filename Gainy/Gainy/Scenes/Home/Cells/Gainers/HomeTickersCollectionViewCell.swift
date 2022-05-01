//
//  HomeTickersCollectionViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 01.05.2022.
//

import UIKit

protocol HomeTickersCollectionViewCellDelegate: AnyObject {
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell)
}

final class HomeTickersCollectionViewCell: UICollectionViewCell {
    
    static let cellHeight: CGFloat = 144.0
    
    private let cellWidth: CGFloat = 144.0
    
    weak var delegate: HomeTickersTableViewCellDelegate?
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.register(UINib.init(nibName: HomeTickerInnerTableViewCell.cellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: HomeTickerInnerTableViewCell.reuseIdentifier)
        }
    }
    
    var gainers: [RemoteTicker] = [] {
        didSet {
            innerCollectionView.reloadData()
        }
    }
}

extension HomeTickersCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gainers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeTickerInnerTableViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.stock = gainers[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension HomeTickersCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension HomeTickersCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeTickersCollectionViewCell: HomeTickerInnerTableViewCellDelegate {
    func wlPressed(stock: AltStockTicker, cell: HomeTickerInnerTableViewCell) {
        delegate?.wlPressed(stock: stock, cell: cell)
    }
}
