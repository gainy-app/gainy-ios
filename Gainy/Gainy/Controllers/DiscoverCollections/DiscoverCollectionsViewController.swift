import AppsFlyerLib
import Foundation
import UIKit

typealias CollectionsDataSource = UICollectionViewDiffableDataSource
<DiscoverCollectionsViewController.Section, Collection>
typealias CollectionsDataSourceSnapshot = NSDiffableDataSourceSnapshot
<DiscoverCollectionsViewController.Section, Collection>

final class DiscoverCollectionsViewController: UIViewController, DiscoverCollectionsViewControllerProtocol {
    // MARK: Internal

    // MARK: Types

    enum Section: Int, CaseIterable {
        case yourCollections
        case recommendedCollections
    }

    // MARK: Properties

    // Derives the order of the sections
    lazy var sections: [SectionLayout] = [
        YourCollectionsSectionLayout(),
        RecommendedCollectionsSectionLayout(),
    ]

    lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection
        }
        return layout
    }()

    var viewModel: DiscoverCollectionsViewModelProtocol?

    var onGoToCollectionDetails: (() -> Void)?
    var onRemovingCollectionFromYourCollections: (() -> Void)?

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
        discoverCollectionsCollectionView.reorderingCadence = .fast

        discoverCollectionsCollectionView.dataSource = dataSource
        discoverCollectionsCollectionView.dragDelegate = self
        discoverCollectionsCollectionView.dropDelegate = self

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: discoverCollectionsCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: modelItem,
                position: indexPath.row
            )

            if let cell = cell as? YourCollectionViewCell,
               let modelItem = modelItem as? YourCollectionViewCellModel {
                cell.onDeleteButtonPressed = { [weak self] in
                    self?.removeFromYourCollection(yourCollectionItemToRemove: modelItem)
                }
                cell.onDragSessionStarted = { [weak self] in
                    self?.provideTapticFeedback()
                }
            } else if let cell = cell as? RecommendedCollectionViewCell,
                      let modelItem = modelItem as? RecommendedCollectionViewCellModel {
                self?.viewModel?.recommendedCollections[indexPath.row].isInYourCollections == true
                    ? cell.setButtonChecked()
                    : cell.setButtonUnchecked()

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
            }

            return cell
        }

        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return self?.sections[indexPath.section].header(
                    collectionView: collectionView,
                    indexPath: indexPath
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

    // MARK: Functions

    func goToCollectionDetails() {
        onGoToCollectionDetails?()
    }

    // MARK: Private

    // MARK: Properties

    private var discoverCollectionsCollectionView: UICollectionView!
    private var feedbackGenerator: UIImpactFeedbackGenerator?

    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

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

    private func getLocalData() {
        viewModel?.yourCollections = DummyDataSource
            .yourCollections
            .map { CollectionViewModelMapper.map($0) }
        viewModel?.recommendedCollections = DummyDataSource
            .recommendedCollections
            .map { CollectionViewModelMapper.map($0) }
    }

    private func getRemoteData(completion: @escaping () -> Void) {
        Network.shared.apollo.fetch(query: CollectionsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                DummyDataSource.collectionsRemote = graphQLResult.data!.collections

                let yourCollectionsDto = DummyDataSource.collectionsRemote.filter {
                    !$0.favoriteCollections.isEmpty
                }
                let recommendedDto = DummyDataSource.collectionsRemote.filter {
                    $0.favoriteCollections.isEmpty
                }
                DummyDataSource.yourCollections = yourCollectionsDto.map {
                    CollectionDTOMapper.map($0)
                }
                DummyDataSource.recommendedCollections = recommendedDto.map {
                    CollectionDTOMapper.map($0)
                }

                self?.getLocalData()
                completion()


            case .failure(let error):
                print("Failure when making GraphQL request. Error: \(error)")
                self?.getLocalData()
                completion()
            }
        }
    }
}

extension DiscoverCollectionsViewController: UICollectionViewDragDelegate {
    func collectionView(_: UICollectionView,
                        itemsForBeginning _: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        switch indexPath.section {
        case Section.yourCollections.rawValue:
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
}

extension DiscoverCollectionsViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        performDropWith coordinator: UICollectionViewDropCoordinator) {
        var destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = Section.yourCollections.rawValue
            let row = collectionView.numberOfItems(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
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

        guard destination.section == Section.yourCollections.rawValue else {
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
        dragPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()

        let path = UIBezierPath(
            roundedRect: CGRect(x: 0,
                                y: 0,
                                width: UIScreen.main.bounds.width - (16 + 16),
                                height: 92),
            cornerRadius: 8
        )
        previewParams.visiblePath = path

        return previewParams
    }
}
