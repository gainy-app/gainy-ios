import AppsFlyerLib
import Foundation
import UIKit

private enum DiscoverCollectionsSection: Int, CaseIterable {
    case yourCollections
    case recommendedCollections
}

final class DiscoverCollectionsViewController: UIViewController, DiscoverCollectionsViewControllerProtocol {
    // MARK: Internal

    // MARK: Properties

    var viewModel: DiscoverCollectionsViewModelProtocol?

    var onGoToCollectionDetails: ((Int) -> Void)?
    var onRemoveCollectionFromYourCollections: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        discoverCollectionsCollectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: customLayout
        )
        view.addSubview(discoverCollectionsCollectionView)

        discoverCollectionsCollectionView.registerSectionHeader(YourCollectionsHeaderView.self)
        discoverCollectionsCollectionView.registerSectionHeader(RecommendedCollectionsHeaderView.self)

        discoverCollectionsCollectionView.register(YourCollectionViewCell.self)
        discoverCollectionsCollectionView.register(RecommendedCollectionViewCell.self)

        discoverCollectionsCollectionView.backgroundColor = UIColor.Gainy.white
        discoverCollectionsCollectionView.showsVerticalScrollIndicator = false
        discoverCollectionsCollectionView.dragInteractionEnabled = true

        discoverCollectionsCollectionView.dataSource = dataSource
        discoverCollectionsCollectionView.delegate = self

        discoverCollectionsCollectionView.dragDelegate = self
        discoverCollectionsCollectionView.dropDelegate = self

        dataSource = UICollectionViewDiffableDataSource<DiscoverCollectionsSection, AnyHashable>(
            collectionView: discoverCollectionsCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )

            switch (cell, modelItem) {
            case let (cell as YourCollectionViewCell, modelItem as YourCollectionViewCellModel):
                cell.onDeleteButtonPressed = { [weak self] in
                    if let removalForbidden = self?.isDragAndDropInProgress, !removalForbidden {
                        self?.removeFromYourCollection(yourCollectionItemToRemove: modelItem)
                    }
                }

                cell.onCellLifted = { [weak self] in
                    self?.isDragAndDropInProgress = true
                    self?.indexOfCellBeingDragged = indexPath.row
                    self?.provideTapticFeedback()
                }

                cell.onCellStopDragging = { [weak self] in
                    if let dragCellIndex = self?.indexOfCellBeingDragged, dragCellIndex == indexPath.row {
                        self?.isDragAndDropInProgress = false
                        self?.indexOfCellBeingDragged = nil
                    }
                }

            case let (cell as RecommendedCollectionViewCell, modelItem as RecommendedCollectionViewCellModel):
                cell.onPlusButtonPressed = { [weak self] in
                    cell.isUserInteractionEnabled = false

                    cell.setButtonChecked()
                    self?.addToYourCollection(collectionItemToAdd: modelItem, indexRow: indexPath.row)

                    cell.isUserInteractionEnabled = true
                }

                cell.onCheckButtonPressed = { [weak self] in
                    cell.isUserInteractionEnabled = false

                    cell.setButtonUnchecked()
                    // TODO: create a func removeFromYourCollection(collectionToRemove: recommendedCollectionItem)
                    let yourCollectionItem = YourCollectionViewCellModel(
                        id: modelItem.id,
                        image: modelItem.image,
                        name: modelItem.name,
                        description: modelItem.description,
                        stocksAmount: modelItem.stocksAmount,
                        recommendedIdentifier: modelItem
                    )
                    self?.removeFromYourCollection(yourCollectionItemToRemove: yourCollectionItem)

                    cell.isUserInteractionEnabled = true
                }
            default:
                break
            }

            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                let headerViewModel = indexPath.section == DiscoverCollectionsSection.yourCollections.rawValue
                    ? CollectionHeaderViewModel(
                        title: "Your collections",
                        description: "Tap to view, swipe to edit or drag & drop to reorder"
                    )
                    : CollectionHeaderViewModel(
                        title: "Collections you might like",
                        description: "Tap on collection for preview, or tap on plus icon to add to your discovery"
                    )

                return self?.sections[indexPath.section].header(
                    collectionView: collectionView,
                    indexPath: indexPath,
                    viewModel: headerViewModel
                )
            default:
                return nil
            }
        }

        getRemoteData {
            DispatchQueue.main.async { [weak self] in
                self?.initViewModels()
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private lazy var sections: [SectionLayout] = [
        YourCollectionsSectionLayout(),
        RecommendedCollectionsSectionLayout(),
    ]

    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()

    private var discoverCollectionsCollectionView: UICollectionView!
    private var feedbackGenerator: UIImpactFeedbackGenerator?

    private var dataSource: UICollectionViewDiffableDataSource<DiscoverCollectionsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<DiscoverCollectionsSection, AnyHashable>()

    private var isDragAndDropInProgress = false
    private var indexOfCellBeingDragged: Int?

    // MARK: Functions

    private func provideTapticFeedback() {
        feedbackGenerator = UIImpactFeedbackGenerator()
        feedbackGenerator?.impactOccurred()
        feedbackGenerator = nil
    }

    private func addToYourCollection(collectionItemToAdd: RecommendedCollectionViewCellModel, indexRow: Int) {
        let updatedRecommendedItem = RecommendedCollectionViewCellModel(
            id: collectionItemToAdd.id,
            image: collectionItemToAdd.image,
            name: collectionItemToAdd.name,
            description: collectionItemToAdd.description,
            stocksAmount: collectionItemToAdd.stocksAmount,
            isInYourCollections: true
        )

        let yourCollectionItem = YourCollectionViewCellModel(
            id: collectionItemToAdd.id,
            image: collectionItemToAdd.image,
            name: collectionItemToAdd.name,
            description: collectionItemToAdd.description,
            stocksAmount: collectionItemToAdd.stocksAmount,
            recommendedIdentifier: updatedRecommendedItem
        )

        viewModel?.recommendedCollections[indexRow] = updatedRecommendedItem

        snapshot.insertItems([updatedRecommendedItem], afterItem: collectionItemToAdd)
        snapshot.deleteItems([collectionItemToAdd])
        dataSource?.apply(snapshot, animatingDifferences: false)

        viewModel?.yourCollections.append(yourCollectionItem)
        DummyDataSource.yourCollections.append(
            Collection(id: yourCollectionItem.id,
                       image: yourCollectionItem.image,
                       name: yourCollectionItem.name,
                       description: yourCollectionItem.description,
                       stocksAmount: Int(yourCollectionItem.stocksAmount)!,
                       isInYourCollections: true)
        )

        snapshot.appendItems([yourCollectionItem], toSection: .yourCollections)
        dataSource?.apply(snapshot, animatingDifferences: true)

        AppsFlyerLib.shared().logEvent(
            AFEvent.addToYourCollections,
            withValues: [
                AFParameter.collectionName:
                    collectionItemToAdd.name,
                AFParameter.itemsInYourCollectionsAfterAdding:
                    "\(self.viewModel?.yourCollections.count ?? 0)",
                AFParameter.itemsInRecommendedAfterAdding:
                    "\(self.viewModel?.recommendedCollections.count ?? 0)",
            ]
        )
    }

    private func removeFromYourCollection(yourCollectionItemToRemove: YourCollectionViewCellModel) {
        viewModel?.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }

        // TODO: make it more robust
        DummyDataSource.yourCollections.removeAll { $0.id == yourCollectionItemToRemove.id }

        if let recommendedItem = yourCollectionItemToRemove.recommendedIdentifier {
            let updatedRecommendedItem = RecommendedCollectionViewCellModel(
                id: recommendedItem.id,
                image: recommendedItem.image,
                name: recommendedItem.name,
                description: recommendedItem.description,
                stocksAmount: recommendedItem.stocksAmount,
                isInYourCollections: false
            )

            if let indexOfRecommendedItemToDelete = viewModel?
                .recommendedCollections
                .firstIndex(where: { $0.id == yourCollectionItemToRemove.id }) {
                viewModel?.recommendedCollections[indexOfRecommendedItemToDelete] = updatedRecommendedItem
            }

            snapshot.insertItems([updatedRecommendedItem], afterItem: recommendedItem)
            snapshot.deleteItems([recommendedItem])
            dataSource?.apply(snapshot, animatingDifferences: false)

            snapshot.deleteItems([yourCollectionItemToRemove])
            dataSource?.apply(snapshot, animatingDifferences: true)
        } else {
            snapshot.deleteItems([yourCollectionItemToRemove])
            dataSource?.apply(snapshot, animatingDifferences: true)
        }

        AppsFlyerLib.shared().logEvent(
            AFEvent.removeFromYourCollections,
            withValues: [
                AFParameter.collectionName:
                    yourCollectionItemToRemove.name,
                AFParameter.itemsInYourCollectionsAfterRemoval:
                    "\(self.viewModel?.yourCollections.count ?? 0)",
                AFParameter.itemsInRecommendedAfterRemoval:
                    "\(self.viewModel?.recommendedCollections.count ?? 0)",
            ]
        )
    }

    private func reorderItems(
        dropCoordinator: UICollectionViewDropCoordinator,
        destinationIndexPath: IndexPath
    ) {
        let draggedItems = dropCoordinator.items
        guard let item = draggedItems.first, let sourceIndexPath = item.sourceIndexPath else {
            return
        }

        let dragDirectionIsTopBottom = sourceIndexPath.row < destinationIndexPath.row

        // TODO: keeping local order, make it more robust and flexible
        DummyDataSource.yourCollections.move(from: sourceIndexPath.row, to: destinationIndexPath.row)

        if dragDirectionIsTopBottom {
            snapshot.moveItem(dataSource?.itemIdentifier(for: sourceIndexPath)!,
                              afterItem: dataSource?.itemIdentifier(for: destinationIndexPath)!)
        } else {
            snapshot.moveItem(dataSource?.itemIdentifier(for: sourceIndexPath)!,
                              beforeItem: dataSource?.itemIdentifier(for: destinationIndexPath)!)
        }

        dataSource?.apply(snapshot, animatingDifferences: false)
        dropCoordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
    }

    private func initViewModels() {
        snapshot.appendSections([.yourCollections, .recommendedCollections])
        snapshot.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
        snapshot.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func goToCollectionDetails(at collectionPosition: Int) {
        onGoToCollectionDetails?(collectionPosition)
    }

    private func initViewModelsFromData() {
        viewModel?.yourCollections = DummyDataSource
            .yourCollections
            .map { CollectionViewModelMapper.map($0) }
        viewModel?.recommendedCollections = DummyDataSource
            .recommendedCollections
            .map { CollectionViewModelMapper.map($0) }
    }

    private func getRemoteData(completion: @escaping () -> Void) {
        Network.shared.apollo.fetch(query: DiscoverCollectionsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                DummyDataSource.remoteRawCollections = graphQLResult.data!.collections

                let yourCollectionsDto = DummyDataSource.remoteRawCollections.filter {
                    !$0.favoriteCollections.isEmpty
                }
                let recommendedDto = DummyDataSource.remoteRawCollections.filter {
                    $0.favoriteCollections.isEmpty
                }
                DummyDataSource.yourCollections = yourCollectionsDto.map {
                    CollectionDTOMapper.map($0)
                }
                DummyDataSource.recommendedCollections = recommendedDto.map {
                    CollectionDTOMapper.map($0)
                }

                self?.initViewModelsFromData()
                completion()


            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                self?.initViewModels()
                completion()
            }
        }
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        var position = 0
        if indexPath.section == DiscoverCollectionsSection.recommendedCollections.rawValue {
            position = collectionView.numberOfItems(
                inSection: DiscoverCollectionsSection.yourCollections.rawValue
            )
        }
        position += indexPath.row

        self.goToCollectionDetails(at: position)
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDragDelegate {
    func collectionView(
        _: UICollectionView,
        itemsForBeginning _: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        switch indexPath.section {
        case DiscoverCollectionsSection.yourCollections.rawValue:
            let item = viewModel!.yourCollections[indexPath.row]
            // swiftlint:disable legacy_objc_type
            let itemProvider = NSItemProvider(object: item.name as NSString)
            // swiftlint:enable legacy_objc_type
            let dragItem = UIDragItem(itemProvider: itemProvider)

            // TODO: Consider assigning a value to the localObject property of each drag item.
            // This step is optional but makes it faster to drag and drop content within the same app.

            return [dragItem]
        default:
            return []
        }
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
                height: 92
            ),
            cornerRadius: 8
        )
        previewParams.visiblePath = path

        return previewParams
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDropDelegate {
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

    func collectionView(_ collectionView: UICollectionView,
                        dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath _: IndexPath?) -> UICollectionViewDropProposal {
        let dragItemLocation = session.location(in: collectionView)
        var dragItemIndexPath: IndexPath?

        collectionView.performUsingPresentationValues {
            dragItemIndexPath = collectionView.indexPathForItem(at: dragItemLocation)
        }

        guard let destination = dragItemIndexPath else {
            return UICollectionViewDropProposal(
                operation: .cancel,
                intent: .unspecified
            )
        }

        guard destination.section == DiscoverCollectionsSection.yourCollections.rawValue else {
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

extension DiscoverCollectionsViewController: UIGestureRecognizerDelegate {}
