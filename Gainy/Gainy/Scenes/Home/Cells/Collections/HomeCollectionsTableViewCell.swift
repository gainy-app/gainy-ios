//
//  HomeCollectionsTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit

final class HomeCollectionsTableViewCell: UITableViewCell {
    
    private let cellWidth: CGFloat = 88
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
        }
    }
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var expandBtn: UIButton!
    
    var collections: [RemoteShortCollectionDetails] = [] {
        didSet {
            innerCollectionView.reloadData()
            expandBtn.isHidden = collections.count < 5
            if collections.count < 5 {
                collectionHeight.constant = CGFloat(collections.count) * cellWidth + CGFloat(collections.count - 1) * 8.0
            } else {
                collectionHeight.constant = CGFloat(4) * cellWidth + CGFloat(4 - 1) * 8.0
            }
            layoutIfNeeded()
        }
    }
    
    //MARK: - Actions
    @IBAction func expandToggleAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            collectionHeight.constant = CGFloat(collections.count) * cellWidth + CGFloat(collections.count - 1) * 8.0
        } else {
            collectionHeight.constant = CGFloat(4) * cellWidth + CGFloat(4 - 1) * 8.0
        }
        layoutIfNeeded()
    }
}

extension HomeCollectionsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionsInnerTableViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.collection = collections[indexPath.row]
        return cell
    }
}

extension HomeCollectionsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
}

extension HomeCollectionsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


//Will be used further
final class HomeCollectionsInnerTableViewCell: UICollectionViewCell {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var stockAmountLbl: UILabel!
    @IBOutlet weak var growContainer: CornerView!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var growLbl: UILabel!
    @IBOutlet weak var backImgView: UIImageView!
    
    //MARK: - Properties
    
    var collection: RemoteShortCollectionDetails? {
        didSet {
            guard let collection = collection else {return}
            nameLbl.text = collection.name
            stockAmountLbl.text = "\(collection.size ?? 0) stock\((collection.size ?? 0) > 1 ? "s" : "")"
            
            if (collection.metrics?.relativeDailyChange ?? 0.0) > 0.0 {
                growContainer.backgroundColor = UIColor.Gainy.mainGreen
                backImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                backImgView.tintColor = UIColor.Gainy.mainText
                growLbl.textColor = UIColor.Gainy.mainText
                
            } else {
                growContainer.backgroundColor = UIColor.Gainy.mainRed
                backImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                backImgView.tintColor = .white
                growLbl.textColor = .white
            }
            growLbl.text = (collection.metrics?.relativeDailyChange ?? 0.0).percent
        }
    }
}
