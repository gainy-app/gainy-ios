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
    func collectionMoved(collection: RemoteShortCollectionDetails, from fromIndex: Int, to toIndex: Int)
    func collectionDeleted(collection: RemoteShortCollectionDetails, collectionID: Int)
}

final class HomeCollectionsTableViewCell: UITableViewCell {
    
    weak var delegate: HomeCollectionsTableViewCellDelegate?
    private let cellWidth: CGFloat = 88
    private var indexOfCellBeingDragged: Int?
    
    var heightUpdated: ((CGFloat) -> Void)?
    
    @IBOutlet private weak var innerCollectionView: UICollectionView! {
        didSet {
            innerCollectionView.dataSource = self
            innerCollectionView.delegate = self
            innerCollectionView.showsVerticalScrollIndicator = false
            innerCollectionView.dragInteractionEnabled = true
            innerCollectionView.dragDelegate = self
            innerCollectionView.dropDelegate = self
            innerCollectionView.setCollectionViewLayout(customLayout, animated: true)
            innerCollectionView.clipsToBounds = false
            innerCollectionView.layer.masksToBounds = false
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
    
    var collections: [RemoteShortCollectionDetails] = [] {
        didSet {
            innerCollectionView.reloadData()
            innerCollectionView.isScrollEnabled = false
            calcSize(isSelected: true)
        }
    }
    
    func calcSize(isSelected: Bool = false) {
        if isSelected {
            collectionHeight.constant = max(0.0, CGFloat(collections.count) * cellWidth + CGFloat(collections.count) * 8.0)
        } else {
            collectionHeight.constant = CGFloat(4) * cellWidth + CGFloat(4) * 8.0
        }
        let bottomOffset: CGFloat = 0.0
        delay(0.1) {
            self.innerCollectionView.isScrollEnabled = false
            self.heightUpdated?(8.0 + self.collectionHeight.constant + bottomOffset)
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
        cell.clipsToBounds = false
        cell.layer.masksToBounds = false
        cell.collection = collections[indexPath.row]
        cell.onDeleteButtonPressed = { [weak self] in
            let yesAction = UIAlertAction.init(title: "Yes", style: .default) { action in
                GainyAnalytics.logEvent("your_collection_deleted", params: ["collectionID": self?.collections[indexPath.row].id ?? 0,  "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Home"])
                self?.removeFromYourCollection(itemId: self?.collections[indexPath.row].id ?? 0)
            }
            NotificationManager.shared.showMessage(title: "Warning", text: "Are you sure you want to delete this TTF?", cancelTitle: "No", actions: [yesAction])
        }
        
        cell.onCellLifted = { [weak self] in
            self?.indexOfCellBeingDragged = indexPath.row
        }
        
        cell.onCellStopDragging = { [weak self] in
            if let dragCellIndex = self?.indexOfCellBeingDragged, dragCellIndex == indexPath.row {
                self?.indexOfCellBeingDragged = nil
            }
        }
        
        cell.delegate = cell
        return cell
    }
    
    private func removeFromYourCollection(itemId: Int) {
        
        if let delIndex = collections.firstIndex(where: {$0.id == itemId}) {
            
            UserProfileManager.shared.removeFavouriteCollection(itemId) { success in
                
                self.innerCollectionView.deleteItems(at: [IndexPath(row: delIndex, section: 0)])
                let collection = self.collections.remove(at: delIndex)
                UserProfileManager.shared.yourCollections.removeAll { $0.id == itemId }
                self.delegate?.collectionDeleted(collection: collection, collectionID: itemId)
            }
        }
    }
}

extension HomeCollectionsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionSelected(collection: self.collections[indexPath.row])
    }
}

extension HomeCollectionsTableViewCell: UICollectionViewDragDelegate {
    func collectionView(
        _: UICollectionView,
        itemsForBeginning _: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        
        guard !collections.isEmpty else { return[] }
        if CollectionsManager.shared.collections.contains(where: { item in
            (item.id ?? 0) == Constants.CollectionDetails.top20ID
        }), indexPath.row == 0 {
            return []
        }
        
        let item = self.collections[indexPath.row]
        // swiftlint:disable legacy_objc_type
        let itemProvider = NSItemProvider(object: (item.name ?? "") as NSString)
        // swiftlint:enable legacy_objc_type
        let dragItem = UIDragItem(itemProvider: itemProvider)
        
        // TODO: Consider assigning a value to the localObject property of each drag item.
        // This step is optional but makes it faster to drag and drop content within the same app.
        
        return [dragItem]
    }
    
    func collectionView(
        _: UICollectionView,
        dragSessionIsRestrictedToDraggingApplication _: UIDragSession
    ) -> Bool {
        true
    }
    
    func collectionView(
        _: UICollectionView,
        dragPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width - (16 + 16),
                height: 88
            ),
            cornerRadius: 18
        )
        previewParams.visiblePath = path
        
        return previewParams
    }
}

extension HomeCollectionsTableViewCell: UICollectionViewDropDelegate {
    func collectionView(_: UICollectionView,
                        performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        if coordinator.proposal.operation == .move {
            reorderItems(dropCoordinator: coordinator,
                         destinationIndexPath: destinationIndexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        let dragItemLocation = session.location(in: collectionView)
        var dragItemIndexPath: IndexPath?
        
        collectionView.performUsingPresentationValues {
            dragItemIndexPath = collectionView.indexPathForItem(at: dragItemLocation)
        }
        
        guard dragItemIndexPath != nil else {
            return UICollectionViewDropProposal(
                operation: .cancel,
                intent: .unspecified
            )
        }
        
        return UICollectionViewDropProposal(
            operation: .move,
            intent: .insertAtDestinationIndexPath
        )
    }
    
    
    
    private func reorderItems(
        dropCoordinator: UICollectionViewDropCoordinator,
        destinationIndexPath: IndexPath
    ) {
        UserProfileManager.shared.collectionsReordered = true
        let draggedItems = dropCoordinator.items
        guard let item = draggedItems.first, let sourceIndexPath = item.sourceIndexPath else {
            return
        }
        
        GainyAnalytics.logEvent("your_collection_reordered", params: ["sourceCollectionID": collections[sourceIndexPath.row].id, "destCollectionID" : collections[destinationIndexPath.row].id ?? 0, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Home"])
        
        
        dropCoordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
        
        let fromIndex = sourceIndexPath.row
        let toIndex = destinationIndexPath.row
        
        collections.move(from: fromIndex, to: toIndex)
        innerCollectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
        
        UserProfileManager.shared.favoriteCollections.move(from: fromIndex, to: toIndex)
        delegate?.collectionMoved(collection: collections[sourceIndexPath.row], from: fromIndex, to: toIndex)
    }
    
    func collectionView(
        _: UICollectionView,
        dropPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width - (16 + 16),
                height: 92
            ),
            cornerRadius: 8
        )
        previewParams.visiblePath = path
        
        return previewParams
    }
}


//Will be used further
final class HomeCollectionsInnerTableViewCell: SwipeCollectionViewCell {
    
    
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
    
    var onDeleteButtonPressed: (() -> Void)?
    var onCellLifted: (() -> Void)?
    var onCellStopDragging: (() -> Void)?
    
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
                if (collection.metrics?.relativeDailyChange ?? 0.0) < 0.0 {
                    growContainer.backgroundColor = UIColor.Gainy.mainRed
                    arrowImgView.image = UIImage(named: "small_down")?.withRenderingMode(.alwaysTemplate)
                    arrowImgView.tintColor = .white
                    growLbl.textColor = .white
                    
                } else {
                    growContainer.backgroundColor = .lightGray
                    arrowImgView.image = UIImage(named: "small_up")?.withRenderingMode(.alwaysTemplate)
                    arrowImgView.tintColor = .darkGray
                    growLbl.textColor = .darkGray
                }
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

extension HomeCollectionsInnerTableViewCell: SwipeCollectionViewCellDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForItemAt _: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        guard self.tag != Constants.CollectionDetails.watchlistCollectionID else { return nil }
        let deleteAction = SwipeAction(style: .default) { [weak self]  _, position in
            self?.onDeleteButtonPressed?()
        }
        deleteAction.image = UIImage(named: "trash")
        
        return [deleteAction]
    }
}

