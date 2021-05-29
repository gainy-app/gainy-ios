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
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            self.sections[sectionIndex].layoutSection
        }
        return layout
    }()

    var viewModel: DiscoverCollectionsViewModelProtocol?

    var onGoToCollectionDetails: (() -> Void)?
    var onRemovingCollectionFromYourCollections: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.discoverCollectionsCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: customLayout
        )
        self.view.addSubview(discoverCollectionsCollectionView)

        self.discoverCollectionsCollectionView.registerSectionHeader(YourCollectionsHeaderView.self)
        self.discoverCollectionsCollectionView.register(YourCollectionViewCell.self)
        self.discoverCollectionsCollectionView.register(RecommendedCollectionViewCell.self)

        self.discoverCollectionsCollectionView.backgroundColor = UIColor.Gainy.white
        self.discoverCollectionsCollectionView.showsVerticalScrollIndicator = false

        self.discoverCollectionsCollectionView.dataSource = dataSource

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: discoverCollectionsCollectionView
        ) { collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: modelItem,
                position: indexPath.row
            )

            if let cell = cell as? YourCollectionViewCell,
               let modelItem = modelItem as? YourCollectionViewCellModel {
                cell.onDeleteButtonPressed = {
                    self.removeFromYourCollection(collectionToRemove: modelItem)
                }
            } else if let cell = cell as? RecommendedCollectionViewCell,
                      let modelItem = modelItem as? RecommendedCollectionViewCellModel {
                self.viewModel?.recommendedCollections[indexPath.row].buttonState == .checked
                    ? cell.setButtonChecked()
                    : cell.setButtonUnchecked()

                cell.onPlusButtonPressed = {
                    self.addToYourCollection(collectionToAdd: modelItem, indexRow: indexPath.row)
                    cell.setButtonChecked()
                }
            }

            return cell
        }

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionHeader:
                return self.sections[indexPath.section].header(
                    collectionView: collectionView,
                    indexPath: indexPath
                )
            default:
                return nil
            }
        }

        getLocalData()

//        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.yourCollections, .recommendedCollections])
        snapshot.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
        snapshot.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Functions

    func goToCollectionDetails() {
        self.onGoToCollectionDetails?()
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

    private func getLocalData() {
        viewModel?.yourCollections = DummyDataSource
            .collections
            .map { CollectionViewModelMapper.map($0) }
        viewModel?.recommendedCollections = DummyDataSource
            .recommendedCollections
            .map { CollectionViewModelMapper.map($0) }
    }

    private func getData() {
        Network.shared.apollo.fetch(query: CollectionsQuery()) { result in
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

                DispatchQueue.main.async {
//                    self.updateSnapshot()
                }

                print("Success! Result: \(graphQLResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}

// TODO: Use UICollectionViewDragDelegate/UICollectionViewDropDelegate
extension DiscoverCollectionsViewController: UICollectionViewDelegate {}
