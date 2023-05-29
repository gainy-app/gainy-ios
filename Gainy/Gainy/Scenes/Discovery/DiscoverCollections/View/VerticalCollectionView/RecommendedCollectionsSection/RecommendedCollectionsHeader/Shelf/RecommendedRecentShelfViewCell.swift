//
//  RecommendedRecentShelfViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.05.2023.
//

import UIKit
import SnapKit
import GainyCommon

final class RecommendedRecentShelfViewCell: UICollectionViewCell {
    
    weak var delegate: DiscoveryGridItemActionable?
    
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
    
        contentView.fillRemoteBack()
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints( {make in
            make.top.equalToSuperview().offset(8.0)
            make.leading.equalToSuperview().offset(24.0)
        })
        
        contentView.addSubview(infoBtn)
        infoBtn.snp.makeConstraints( {make in
            make.centerY.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(8.0)
        })
        
        contentView.addSubview(moreBtn)
        moreBtn.snp.makeConstraints( {make in
            make.centerY.equalTo(nameLabel)
            make.trailing.equalToSuperview().offset(-16.0)
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
        btn.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var infoBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "info"), for: .normal)
        btn.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
        return btn
    }()
    
    
    private let recCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(RecommendedCollectionViewCell.self)
        collectionView.register(UINib.init(nibName: HomeTickerInnerTableViewCell.cellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: HomeTickerInnerTableViewCell.reuseIdentifier)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    private var recommendedCollections: [RecentViewedData] = []
    private var moreToShowCount = 0
    private var type: DiscoverySectionInfo = .banner
    
    func configureWith(type: DiscoverySectionInfo, collections: [RecentViewedData]) {
        self.type = type
        nameLabel.text = type.title
        recommendedCollections = collections
        infoBtn.isHidden = type.explanationTitle.isEmpty
        moreBtn.isHidden = true
        recCollectionView.delegate = self
        recCollectionView.dataSource = self
        recCollectionView.isHidden = false
        recCollectionView.setContentOffset(.init(x: -16, y: 0), animated: false)
        recCollectionView.reloadData()
    }
    
    
    //MARK: - Actions
    
    @objc func infoAction() {
    }
    
    @objc func showMoreAction() {
    }
}


extension RecommendedRecentShelfViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collection = self.recommendedCollections
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let data = recommendedCollections[indexPath.row]
        
        switch data {
        case .ttf(model: let modelItem):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedCollectionViewCell.reuseIdentifier, for: indexPath) as? RecommendedCollectionViewCell else {
                return UICollectionViewCell()
                
            }
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
                guard !UserProfileManager.shared.yourCollections.contains(where: {$0.id == modelItem.id}) else {return}
                cell.isUserInteractionEnabled = false
                
                cell.setButtonChecked()
                self.delegate?.addToYourCollection(collectionItemToAdd: modelItem, category: self.type)
                
                cell.isUserInteractionEnabled = true
                GainyAnalytics.logEvent("add_to_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
                
                GainyAnalytics.logEvent("ttf_added_to_wl", params: ["af_content_id" : modelItem.id, "af_content_type" : "ttf"])
                GainyAnalytics.logEventAMP("ttf_added_to_wl", params: ["collectionID" : modelItem.id, "action" : "plus", "isFirstSaved" : UserProfileManager.shared.favoriteCollections.isEmpty ? "true" : "false", "isFromSearch" : false, "category" : type.titleForAMP])
                
                if UserProfileManager.shared.favoriteCollections.isEmpty && AnalyticsKeysHelper.shared.initialTTFFlag {
                    GainyAnalytics.logEventAMP("first_ttf_added", params: ["collectionID" : modelItem.id, "action" : "plus"])
                    AnalyticsKeysHelper.shared.initialTTFFlag = false
                }
            }
            
            cell.onCheckButtonPressed = { [weak self] in
                guard let self else {return}
                guard UserProfileManager.shared.yourCollections.contains(where: {$0.id == modelItem.id}) else {return}
                cell.isUserInteractionEnabled = false
                
                cell.setButtonUnchecked()
                let yourCollectionItem = YourCollectionViewCellModel(
                    id: modelItem.id,
                    image: modelItem.image,
                    imageUrl: modelItem.imageUrl,
                    name: modelItem.name,
                    description: modelItem.description,
                    stocksAmount: modelItem.stocksAmount,
                    matchScore: modelItem.matchScore,
                    dailyGrow: modelItem.dailyGrow,
                    value_change_1w: modelItem.value_change_1w,
                    value_change_1m: modelItem.value_change_1m,
                    value_change_3m: modelItem.value_change_3m,
                    value_change_1y: modelItem.value_change_1y,
                    value_change_5y: modelItem.value_change_5y,
                    performance: modelItem.performance,
                    recommendedIdentifier: modelItem
                )
                self.delegate?.removeFromYourCollection(itemId: modelItem.id, yourCollectionItemToRemove: yourCollectionItem, category: type)
                
                cell.isUserInteractionEnabled = true
                GainyAnalytics.logEvent("remove_from_your_collection_action", params: ["collectionID": modelItem.id, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "DiscoverCollections"])
                GainyAnalytics.logEventAMP("ttf_removed_from_wl", params: ["collectionID" : modelItem.id, "action" : "unplus", "isFirstSaved" : UserProfileManager.shared.favoriteCollections.isEmpty ? "true" : "false", "isFromSearch" : false])
            }
            return cell
        case .stock(model: let stock):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTickerInnerTableViewCell.reuseIdentifier, for: indexPath) as? HomeTickerInnerTableViewCell else { return UICollectionViewCell() }
            cell.stock = stock            
            cell.setBottomViewWidth(48)
            return cell
        }
    }

}

extension RecommendedRecentShelfViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: colHeight, height: colHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 0, left: section == 0 ? 0 : 8.0, bottom: 0, right: section == 0 ? 0 : 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}


extension RecommendedRecentShelfViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collection = self.recommendedCollections
        let modelItem = collection[indexPath.row]
        
        switch modelItem {
        case .ttf(model: let model):
            delegate?.openCollection(collection: model, category: type)
            break
        case .stock(model: let model):
            delegate?.openStock(stock: model, category: type)
            break
        }
        
    }
}
