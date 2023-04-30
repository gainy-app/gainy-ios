//
//  RecommendedShelfViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 30.04.2023.
//

import UIKit
import SnapKit

final class RecommendedShelfViewCell: RoundedCollectionViewCell {
    
    weak var delegate: DiscoveryCategoryViewControllerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    fileprivate let colHeight: CGFloat = (UIScreen.main.bounds.width - 16.0 * 3.0) / 2.0
    
    private func setupView() {
        
        backgroundColor = UIColor(hexString: "#F6F6F6")
        contentView.backgroundColor = UIColor(hexString: "#F6F6F6")
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints( {make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        })
        
        contentView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints( {make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
        })
        
        contentView.addSubview(recCollectionView)
        recCollectionView.snp.makeConstraints( {make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(colHeight)
        })
        recCollectionView.dataSource = self
        recCollectionView.delegate = self
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .proDisplaySemibold(20)
        label.textColor = UIColor.Gainy.mainText
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.75
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var moreBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = .proDisplayMedium(13)
        btn.setTitleColor(UIColor(hexString: "1B45FB"), for: .normal)
        btn.setTitle("Show All", for: .normal)
        return btn
    }()
    
    private let recCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RecommendedCollectionViewCell.self)
        collectionView.register(RecommendedCollectionMoreViewCell.self)
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 20, right: 0)

        return collectionView
    }()
    
    private var recommendedCollections: [RecommendedCollectionViewCellModel] = []
    
    func configureWith(name: String, collections: [RecommendedCollectionViewCellModel]) {
        nameLabel.text = name
        
        recommendedCollections = collections
        moreBtn.isHidden = collections.count > 8
        
    }
}


extension RecommendedShelfViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collection = self.recommendedCollections
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommendedCollectionViewCell else { return UICollectionViewCell() }
        
        let collection = self.recommendedCollections
        let modelItem = collection[indexPath.row]
        let buttonState: RecommendedCellButtonState = UserProfileManager.shared.favoriteCollections.contains(modelItem.id)
        ? .checked
        : .unchecked
        
        
        var grow: Float = modelItem.dailyGrow
        
        if let userID = UserProfileManager.shared.profileID {
            let settings = RecommendedCollectionsSortingSettingsManager.shared.getSettingByID(userID)
            switch settings.performancePeriod {
            case .day:
                grow = modelItem.dailyGrow
            case .week:
                grow = modelItem.value_change_1w
            case .month:
                grow = modelItem.value_change_1m
            case .threeMonth:
                grow = modelItem.value_change_3m
            case .year:
                grow = modelItem.value_change_1y
            case .fiveYears:
                grow = modelItem.value_change_5y
            }
        }
        
        cell.configureWith(
            name: modelItem.name,
            imageUrl: modelItem.imageUrl,
            description: modelItem.description,
            stocksAmount: modelItem.stocksAmount,
            matchScore: modelItem.matchScore,
            dailyGrow: grow,
            imageName: modelItem.image,
            plusButtonState: buttonState
        )
        
        
        
        cell.tag = modelItem.id
        cell.onPlusButtonPressed = { [weak self] in
            guard let self else {return}
            //delegate?.collectionToggled(vc: self, isAdded: true, collectionID: modelItem.id)
        }
        
        cell.onCheckButtonPressed = { [weak self] in
            guard let self else {return}
            //delegate?.collectionToggled(vc: self, isAdded: false, collectionID: modelItem.id)
        }
        return cell
    }

}

extension RecommendedShelfViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: colHeight, height: colHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
}
