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
                    self?.removeFromYourCollection(collectionToRemove: modelItem)

                    AppsFlyerLib.shared().logEvent(
                        AFEvent.removeFromYourCollections,
                        withValues: [
                            AFParameter.collectionName:
                                modelItem.name,
                            AFParameter.itemsInYourCollectionsAfterRemoval:
                                "\(self?.viewModel?.yourCollections.count ?? 0)",
                            AFParameter.itemsInRecommendedAfterRemoval:
                                "\(self?.viewModel?.recommendedCollections.count ?? 0)",
                        ]
                    )
                }
            } else if let cell = cell as? RecommendedCollectionViewCell,
                      let modelItem = modelItem as? RecommendedCollectionViewCellModel {
                self?.viewModel?.recommendedCollections[indexPath.row].buttonState == .checked
                    ? cell.setButtonChecked()
                    : cell.setButtonUnchecked()

                cell.onPlusButtonPressed = { [weak self] in
                    cell.setButtonChecked()
                    self?.addToYourCollection(collectionToAdd: modelItem, indexRow: indexPath.row)

                    AppsFlyerLib.shared().logEvent(
                        AFEvent.addToYourCollections,
                        withValues: [
                            AFParameter.collectionName:
                                modelItem.name,
                            AFParameter.itemsInYourCollectionsAfterAdding:
                                "\(self?.viewModel?.yourCollections.count ?? 0)",
                            AFParameter.itemsInRecommendedAfterAdding:
                                "\(self?.viewModel?.recommendedCollections.count ?? 0)",
                        ]
                    )
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

    private func addToYourCollection(collectionToAdd: RecommendedCollectionViewCellModel, indexRow: Int) {
        let updatedRecommendedIdentifier = RecommendedCollectionViewCellModel(
            id: collectionToAdd.id,
            image: collectionToAdd.image,
            name: collectionToAdd.name,
            description: collectionToAdd.description,
            stocksAmount: collectionToAdd.stocksAmount,
            buttonState: .checked
        )

        let yourCollectionModel = YourCollectionViewCellModel(
            id: collectionToAdd.id,
            image: collectionToAdd.image,
            name: collectionToAdd.name,
            description: collectionToAdd.description,
            stocksAmount: collectionToAdd.stocksAmount,
            recommendedIdentifier: updatedRecommendedIdentifier
        )

        viewModel?.recommendedCollections[indexRow] = updatedRecommendedIdentifier

        snapshot.insertItems([updatedRecommendedIdentifier], afterItem: collectionToAdd)
        snapshot.deleteItems([collectionToAdd])
        dataSource?.apply(snapshot, animatingDifferences: false)

        viewModel?.yourCollections.append(yourCollectionModel)

        snapshot.appendItems([yourCollectionModel], toSection: .yourCollections)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    private func removeFromYourCollection(collectionToRemove: YourCollectionViewCellModel) {
        viewModel?.yourCollections.removeAll { $0.id == collectionToRemove.id }

        if let recommendedIdentifier = collectionToRemove.recommendedIdentifier {
            let updatedRecommendedIdentifier = RecommendedCollectionViewCellModel(
                id: recommendedIdentifier.id,
                image: recommendedIdentifier.image,
                name: recommendedIdentifier.name,
                description: recommendedIdentifier.description,
                stocksAmount: recommendedIdentifier.stocksAmount,
                buttonState: .unchecked
            )

            if let indexToDelete = viewModel?
                .recommendedCollections
                .firstIndex(where: { $0.id == collectionToRemove.id }) {
                viewModel?.recommendedCollections[indexToDelete] = updatedRecommendedIdentifier
            }

            snapshot.insertItems([updatedRecommendedIdentifier], afterItem: recommendedIdentifier)
            snapshot.deleteItems([recommendedIdentifier])
            dataSource?.apply(snapshot, animatingDifferences: false)

            snapshot.deleteItems([collectionToRemove])
            dataSource?.apply(snapshot, animatingDifferences: true)
        } else {
            snapshot.deleteItems([collectionToRemove])
            dataSource?.apply(snapshot, animatingDifferences: true)
        }
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
            feedbackGenerator = UIImpactFeedbackGenerator()
            feedbackGenerator?.impactOccurred()
            feedbackGenerator = nil

            let item = viewModel!.yourCollections[indexPath.row]
            // swiftlint:disable legacy_objc_type
            let itemProvider = NSItemProvider(object: item.name as NSString)
            // swiftlint:enable legacy_objc_type
            let dragItem = UIDragItem(itemProvider: itemProvider)
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

    func collectionView(_: UICollectionView,
                        dropSessionDidUpdate _: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard destinationIndexPath?.section == Section.yourCollections.rawValue else {
            return UICollectionViewDropProposal(operation: .cancel)
        }

        return UICollectionViewDropProposal(operation: .move,
                                            intent: .insertAtDestinationIndexPath)
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
