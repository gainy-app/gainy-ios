import AppsFlyerLib
import Foundation
import UIKit

typealias CollectionsDataSource = UICollectionViewDiffableDataSource
<DiscoverCollectionsViewController.Section, Collection>
typealias CollectionsDataSourceSnapshot = NSDiffableDataSourceSnapshot
<DiscoverCollectionsViewController.Section, Collection>

class DiscoverCollectionsViewController: UIViewController, DiscoverCollectionsViewControllerProtocol {
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
                cell.onDeleteButtonPressed = {
                    self.removeFromYourCollection(collectionToRemove: modelItem)

                    AppsFlyerLib.shared().logEvent(
                        AFEvent.removeFromYourCollections,
                        withValues: [
                            AFParameter.collectionName:
                                modelItem.name,
                            AFParameter.itemsInYourCollectionsAfterRemoval:
                                "\(self.viewModel?.yourCollections.count ?? 0)",
                            AFParameter.itemsInRecommendedAfterRemoval:
                                "\(self.viewModel?.recommendedCollections.count ?? 0)",
                        ]
                    )
                }
            } else if let cell = cell as? RecommendedCollectionViewCell,
                      let modelItem = modelItem as? RecommendedCollectionViewCellModel {
                self.viewModel?.recommendedCollections[indexPath.row].buttonState == .checked
                    ? cell.setButtonChecked()
                    : cell.setButtonUnchecked()

                cell.onPlusButtonPressed = {
                    self.addToYourCollection(collectionToAdd: modelItem, indexRow: indexPath.row)
                    cell.setButtonChecked()

                    AppsFlyerLib.shared().logEvent(
                        AFEvent.addToYourCollections,
                        withValues: [
                            AFParameter.collectionName:
                                modelItem.name,
                            AFParameter.itemsInYourCollectionsAfterAdding:
                                "\(self.viewModel?.yourCollections.count ?? 0)",
                            AFParameter.itemsInRecommendedAfterAdding:
                                "\(self.viewModel?.recommendedCollections.count ?? 0)",
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

        getData()
    }

    // MARK: Functions

    func goToCollectionDetails() {
        onGoToCollectionDetails?()
    }

    // MARK: Private

    // MARK: Properties

    private var discoverCollectionsCollectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

    // MARK: Functions

    private func addToYourCollection(collectionToAdd: RecommendedCollectionViewCellModel, indexRow: Int) {
        let yourCollectionModel = YourCollectionViewCellModel(
            id: collectionToAdd.id,
            image: collectionToAdd.image,
            name: collectionToAdd.name,
            description: collectionToAdd.description,
            stocksAmount: collectionToAdd.stocksAmount,
            indexInRecommended: indexRow
        )
        viewModel?.yourCollections.append(yourCollectionModel)
        self.snapshot.appendItems([yourCollectionModel], toSection: .yourCollections)
        defer { self.dataSource?.apply(self.snapshot, animatingDifferences: true) }

        let updatedRecommendedCollectionModel = RecommendedCollectionViewCellModel(
            id: collectionToAdd.id,
            image: collectionToAdd.image,
            name: collectionToAdd.name,
            description: collectionToAdd.description,
            stocksAmount: collectionToAdd.stocksAmount,
            buttonState: .checked
        )

        guard let indexInRecommendedList = viewModel?
            .recommendedCollections
            .firstIndex(where: { $0.id == collectionToAdd.id }) else {
            assertionFailure("Expect to have a collection in the recommended list")
            return
        }
        viewModel?.recommendedCollections[indexInRecommendedList] = updatedRecommendedCollectionModel
        self.snapshot.reloadSections([.recommendedCollections])
    }

    private func removeFromYourCollection(collectionToRemove: YourCollectionViewCellModel) {
        viewModel?.yourCollections.removeAll { $0.id == collectionToRemove.id }
        self.snapshot.deleteItems([collectionToRemove])
        defer { self.dataSource?.apply(self.snapshot, animatingDifferences: true) }

        guard let indexInRecommendedList = collectionToRemove.indexInRecommended else {
            return
        }

        let updatedRecommendedCollectionModel = RecommendedCollectionViewCellModel(
            id: collectionToRemove.id,
            image: collectionToRemove.image,
            name: collectionToRemove.name,
            description: collectionToRemove.description,
            stocksAmount: collectionToRemove.stocksAmount,
            buttonState: .unchecked
        )

        // TODO: remove '!'
        viewModel!.recommendedCollections[indexInRecommendedList] = updatedRecommendedCollectionModel
        self.snapshot.reloadItems([updatedRecommendedCollectionModel])
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


        dataSource?.apply(snapshot, animatingDifferences: true)
        coordinator.drop(item.dragItem, toItemAt: destinationPath)
    }

    private func initViewModels() {
        snapshot.appendSections([.yourCollections, .recommendedCollections])
        snapshot.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
        snapshot.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    private func getLocalData() {
        viewModel?.yourCollections = DummyDataSource
            .collections
            .map { CollectionViewModelMapper.map($0) }
        viewModel?.recommendedCollections = DummyDataSource
            .recommendedCollections
            .map { CollectionViewModelMapper.map($0) }
    }

    private func getData() {
        Network.shared.apollo.fetch(query: CollectionsQuery()) { [weak self] result in
            switch result {
            case .success(let graphQLResult):
                DummyDataSource.collectionsRemote = graphQLResult.data!.collections

                let discoveredDto = DummyDataSource.collectionsRemote.filter {
                    !$0.favoriteCollections.isEmpty
                }
                let recommendedDto = DummyDataSource.collectionsRemote.filter {
                    $0.favoriteCollections.isEmpty
                }
                DummyDataSource.collections = discoveredDto.map {
                    CollectionDTOMapper.map($0)
                }
                DummyDataSource.recommendedCollections = recommendedDto.map {
                    CollectionDTOMapper.map($0)
                }

                self?.getLocalData()

                DispatchQueue.main.async {
                    self.initViewModels()
                }

                print("Success! Result: \(graphQLResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
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
            return [dragItem]
        default:
            return []
        }
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
            return UICollectionViewDropProposal(operation: .forbidden)
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
                                height: 88),
            cornerRadius: 8
        )
        previewParams.visiblePath = path

        return previewParams
    }
}
