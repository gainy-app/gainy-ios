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
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollection()
    }
    
    func configure(with model: [CollectionDetailHistoryCellInfoModel], position: (Bool, Bool), isSkeletonable: Bool, isToggled: Bool = false) {
        let firstPart = NSMutableAttributedString(string: "Transactions history ")
        let secondPart = NSAttributedString(string: "x \(model.count)", attributes: [.foregroundColor: UIColor(red: 0.42, green: 0.36, blue: 0.83, alpha: 1.0)])
        firstPart.append(secondPart)
        historyLabel.attributedText = firstPart
        configurators = model.map { SingleHistoryCellConfigurator(model: $0) }
        if isSkeletonable {
            showAnimatedGradientSkeleton()
        } else {
            hideSkeleton()
        }
//        collectionView.setCollectionViewLayout(genereateLayout(), animated: true)
        collectionView.isHidden = !isToggled
        dropDownButton.isSelected = isToggled
        cellView.layer.cornerRadius = 16
        
//        collectionView.reloadData()
        switch position {
        case (true, true):
            cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (true, false):
            cellView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case (false, true):
            cellView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        default:
            cellView.layer.cornerRadius = 0
        }
        layoutSubviews()
    }
    
    @IBAction func isExpandDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        collectionView.isHidden = !sender.isSelected
        if sender.isSelected {
            let height = collectionView.contentSize.height + 56
            cellHeightChanged?(184)
        } else {
            cellHeightChanged?(56)
        }
    }
}

private extension HistoryCell {
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SingleHistoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: SingleHistoryCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(genereateLayout(), animated: true)
        collectionView.reloadData()
    }
    
    func genereateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .init(top: 8, leading: 0, bottom: 8, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
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
