//
//  HistoryCell.swift
//  Gainy
//
//  Created by Евгений Таран on 13.11.22.
//

import UIKit
import GainyCommon

class HistoryCell: UICollectionViewCell {
    
    private var configurators: [ListCellConfigurationWithCallBacks] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var dropDownImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SingleHistoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: SingleHistoryCell.reuseIdentifier)
    }
    
    func configure(with model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool), isSkeletonable: Bool) {
        historyLabel.text = "Transactions history * \(model.count)"
        configurators = model.map { SingleHistoryCellConfigurator(model: $0) }
        if isSkeletonable {
            showAnimatedGradientSkeleton()
        } else {
            hideSkeleton()
        }
        switch position {
        case (true, true):
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (true, false):
            contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (false, true):
            contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            break
        }
    }
    
    @IBAction func isExpandDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        collectionView.isHidden = !sender.isSelected
    }
}

extension HistoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configurators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configurators[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.cellIdentifier, for: indexPath)
        configurator.setupCell(cell, isSkeletonable: false)
        return cell
    }
}
