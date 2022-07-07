//
//  HomeCollectionsTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit
import Kingfisher

protocol HomeCollectionsTableViewCellDelegate: AnyObject {
    func collectionSelected(collection: RemoteShortCollectionDetails)
}

final class HomeCollectionsTableViewCell: UITableViewCell {
    
    weak var delegate: HomeCollectionsTableViewCellDelegate?
    private let cellWidth: CGFloat = 88
    
    var heightUpdated: ((CGFloat) -> Void)?
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.setCollectionViewLayout(customLayout, animated: true)
        }
    }
    
    private let homeLayout: HomeCollectionsFlowLayout = HomeCollectionsFlowLayout()
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.homeLayout.layoutSection(within: env)
        }
        return layout
    }()
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    @IBOutlet weak var expandBtn: UIButton!
    
    var collections: [RemoteShortCollectionDetails] = [] {
        didSet {
            innerCollectionView.reloadData()
            innerCollectionView.isScrollEnabled = false
            expandBtn.isSelected = false
            expandBtn.isHidden = collections.count < 5
            calcSize(isSelected: collections.count < 5)
        }
    }
    
    func calcSize(isSelected: Bool = false) {
        if isSelected {
            collectionHeight.constant = max(0.0, CGFloat(collections.count) * cellWidth + CGFloat(collections.count) * 8.0)
        } else {
            collectionHeight.constant = CGFloat(4) * cellWidth + CGFloat(4) * 8.0
        }
        let bottomOffset: CGFloat = collections.count > 4 ? 32.0 : 32.0
        delay(0.1) {
            self.innerCollectionView.isScrollEnabled = false
            self.heightUpdated?(8.0 + self.collectionHeight.constant + bottomOffset)
        }
        layoutIfNeeded()
    }
    
    //MARK: - Actions
    @IBAction func expandToggleAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        calcSize(isSelected: sender.isSelected)
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

extension HomeCollectionsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionSelected(collection: self.collections[indexPath.row])
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
    @IBOutlet weak var backImgView: UIImageView! {
        didSet {
            backImgView.isOpaque = true
            backImgView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        }
    }
    @IBOutlet weak var msLbl: UILabel! {
        didSet {
            msLbl.clipsToBounds = true
            msLbl.layer.cornerRadius = 12.0
            msLbl.textColor = UIColor.Gainy.mainText
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cleanupImage()
    }
    
    //MARK: - Properties
    private var imageUrl: String = ""
    private var imageLoaded: Bool = false
    
    var collection: RemoteShortCollectionDetails? {
        didSet {
            guard let collection = collection else {return}
            imageUrl = collection.imageUrl ?? ""
            nameLbl.text = collection.name
            stockAmountLbl.text = "\(collection.size ?? 0) stock\((collection.size ?? 0) > 1 ? "s" : "")"
            
            if (collection.metrics?.relativeDailyChange ?? 0.0) > 0.0 {
                growContainer.backgroundColor = UIColor.Gainy.secondaryGreen
                arrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                arrowImgView.tintColor = UIColor.Gainy.mainText
                growLbl.textColor = UIColor.Gainy.mainText
                
            } else {
                growContainer.backgroundColor = UIColor.Gainy.mainRed
                arrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                arrowImgView.tintColor = .white
                growLbl.textColor = .white
            }
            growLbl.text = (collection.metrics?.relativeDailyChange ?? 0.0).percentUnsigned
            
            if let matchScore = collection.matchScore?.matchScore {
                msLbl.text = "\(Int(matchScore))"
                msLbl.backgroundColor = MatchScoreManager.circleColorFor(Int(matchScore))
            } else {
                msLbl.text = "-"
            }
        }
    }
    
    
    //MARK: - Image
    
    private func loadImage() {
        
        guard self.imageLoaded == false, backImgView.bounds.size.width > 0, backImgView.bounds.size.height > 0 else {
            return
        }
        
        let lastCollectionID = self.collection?.id
        let processor = DownsamplingImageProcessor(size: backImgView.bounds.size)
        backImgView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(), options: [
            .processor(processor),
            .scaleFactor(UIScreen.main.scale),
            .transition(.fade(1)),
            .cacheOriginalImage
        ]) { receivedSize, totalSize in
            //            print("-----\(receivedSize), \(totalSize)")
        } completionHandler: { result in
            //            print("-----\(result)")
            let currentCollectionID = self.collection?.id
            if let last = lastCollectionID, let current = currentCollectionID, last == current {
                self.imageLoaded = true
            } else {
                self.cleanupImage()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.loadImage()
    }
    
    private func cleanupImage() {
        self.imageUrl = ""
        self.imageLoaded = false
        self.backImgView.image = nil
    }
}
