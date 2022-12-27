//
//  HistoryView.swift
//  Gainy
//
//  Created by Евгений Таран on 19.12.22.
//

import UIKit
import GainyCommon

@IBDesignable
class HistoryView: UIView {
    private var configurators: [ListCellConfigurationWithCallBacks] = [] {
        didSet {
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func configure(with model: [CollectionDetailHistoryCellInfoModel], isSkeletonable: Bool, isToggled: Bool = false) {
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
        collectionView.isHidden = !isToggled
        dropDownButton.isSelected = isToggled
        collectionView.reloadData()
    }
    
    @IBAction func isExpandDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            let height: CGFloat = CGFloat((configurators.count * 24) + ((configurators.count - 1) * 16) + 56 + 30 + 16)
            cellHeightChanged?(height)
        } else {
            cellHeightChanged?(56)
        }
    }
}

private extension HistoryView {
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SingleHistoryCell", bundle: Bundle.main), forCellWithReuseIdentifier: SingleHistoryCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(genereateLayout(), animated: true)
        collectionView.reloadData()
    }
    
    func genereateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(24))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 30, leading: 16, bottom: 0, trailing: 16)
            section.interGroupSpacing = 16
            return section
        }
    }
}

extension HistoryView: UICollectionViewDataSource {
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

