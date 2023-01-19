//
//  HistoryView.swift
//  Gainy
//
//  Created by Евгений Таран on 19.12.22.
//

import UIKit
import GainyCommon
import GainyAPI

@IBDesignable
class HistoryView: UIView {
    private var configurators: [[HistoryInnerCellConfigurators]] = [[]] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    var didTapShowMore: VoidHandler?
    var tapOrderHandler: ((TradingHistoryFrag) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollection()
    }
    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func configure(with model: [CollectionDetailHistoryCellInfoModel], isSkeletonable: Bool, isToggled: Bool = false) {
        let firstPart = NSMutableAttributedString(string: "Transactions history ")
        let secondPart = NSAttributedString(string: "× \(model.count)", attributes: [.foregroundColor: UIColor(red: 0.42, green: 0.36, blue: 0.83, alpha: 1.0)])
        firstPart.append(secondPart)
        historyLabel.attributedText = firstPart
        let configurators = model.map { SingleHistoryCellConfigurator(model: $0) }
        if !(self.configurators.first?.isEmpty ?? true) && (self.configurators.first?.count ?? 0) != configurators.prefix(3).count {
            let height: CGFloat = CGFloat((configurators.count * 24) + ((configurators.count - 1) * 16) + 56 + 30 + 16)
            cellHeightChanged?(height)
        }
        if configurators.count > 3 {
            let showMoreConfigurator = SingleHistoryShowMoreCellConfigurator()
            self.configurators = [Array(configurators.prefix(3)), [showMoreConfigurator]]
        } else {
            self.configurators = [configurators, []]
        }
        if isSkeletonable {
            showAnimatedGradientSkeleton()
        } else {
            hideSkeleton()
        }
        dropDownButton.isSelected = isToggled
        collectionView.reloadData()
    }
    
    @IBAction func isExpandDidTap(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            var totalHeight: CGFloat = 0
            if (configurators.last?.count ?? 0) > 0 {
                let height = ((configurators.first?.count ?? 0) * 24)
                let innerSpace = ((configurators.first?.count ?? 0) - 1)
                totalHeight = CGFloat(height + (innerSpace * 14) + 56 + 24 + 16 + 64)
            } else {
                let height = ((configurators.first?.count ?? 0) * 24)
                let innerSpace = ((configurators.first?.count ?? 0) - 1)
                totalHeight = CGFloat(height + (innerSpace * 14) + 56 + 24 + 16)
            }
            cellHeightChanged?(totalHeight)
        } else {
            cellHeightChanged?(56)
        }
    }
}

private extension HistoryView {
    func configureCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ShowHistoryCell.nib, forCellWithReuseIdentifier: ShowHistoryCell.reuseIdentifier)
        collectionView.register(SingleHistoryCell.nib, forCellWithReuseIdentifier: SingleHistoryCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(genereateLayout(), animated: true)
        collectionView.reloadData()
    }
    
    func genereateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            guard let type = self.configurators[section].first?.sectionType else { return nil }
            switch type {
            case .history:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(26))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 24, leading: 16, bottom: 0, trailing: 16)
                section.interGroupSpacing = 14
                return section
            case .showMore:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 24, leading: 16, bottom: 0, trailing: 16)
                return section
            }
        }
    }
}

extension HistoryView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return configurators.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configurators[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let configurator = configurators[indexPath.section][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: configurator.cellIdentifier, for: indexPath)
        configurator.setupCell(cell, isSkeletonable: false)
        return cell
    }
}

extension HistoryView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let conf = configurators[indexPath.section][indexPath.row] as? SingleHistoryCellConfigurator {
            tapOrderHandler?(conf.model.historyData)
        } else {
            didTapShowMore?()
        }
    }
}
