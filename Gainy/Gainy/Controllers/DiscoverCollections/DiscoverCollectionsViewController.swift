import Foundation
import UIKit

typealias CollectionsDataSource = UICollectionViewDiffableDataSource
<DiscoverCollectionsViewController.Section, Collection>
typealias CollectionsDataSourceSnapshot = NSDiffableDataSourceSnapshot
<DiscoverCollectionsViewController.Section, Collection>


// A models

enum DiscoverCollections {}

// A view model

class DiscoveredCollectionItemViewModel {}
class RecommendedCollectionItemViewModel {}

class DiscoverCollectionsViewModel: NSObject, DiscoverCollectionsViewModelProtocol {
    var yourCollections: [YourCollectionViewCellModel]
    var recommendedCollections: [RecommendedCollectionViewCellModel]

    // MARK: - Init

    override init() {
        yourCollections = DummyDataSource.collections.map { CollectionViewModelMapper.map($0) }
        recommendedCollections = DummyDataSource.recommendedCollections.map { CollectionViewModelMapper.map($0) }
        super.init()
    }
}

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
    var onAddingCollectionToYourCollections: (() -> Void)?
    var onRemovingCollectionFromYourCollections: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.discoverCollectionsCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: customLayout
        )
        self.view.addSubview(discoverCollectionsCollectionView)

        self.discoverCollectionsCollectionView.registerSectionHeader(DiscoveredCollectionsHeaderView.self)
        self.discoverCollectionsCollectionView.register(DiscoveredCollectionViewCell.self)
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

            if let cell = cell as? DiscoveredCollectionViewCell,
               let modelItem = modelItem as? YourCollectionViewCellModel {
                cell.onDeleteButtonPressed = {
                    self.viewModel?.yourCollections.removeAll { $0.id == modelItem.id }
                    if let recModelIdx = self.viewModel?
                        .recommendedCollections
                        .firstIndex(where: { $0.id == modelItem.id }
                    ) {
                        let recModel = RecommendedCollectionViewCellModel(
                            id: modelItem.id,
                            image: modelItem.image,
                            name: modelItem.name,
                            description: modelItem.description,
                            stocksAmount: modelItem.stocksAmount,
                            buttonState: .unchecked
                        )
                        self.viewModel?.recommendedCollections[recModelIdx] = recModel
                    }
                    DispatchQueue.main.async {
                        self.snapshot.deleteItems([modelItem])
                        self.snapshot.reloadSections([.recommendedCollections])
//                        self.snapshot.replace??
                        // TODO: find recommendedModel and update it?
                        self.dataSource.apply(self.snapshot, animatingDifferences: true)
                    }
                }
            }

            if let cell = cell as? RecommendedCollectionViewCell,
               let modelItem = modelItem as? RecommendedCollectionViewCellModel {
                // TODO: fix (add field to recommended?)
                let checkedItem = YourCollectionViewCellModel(
                    id: modelItem.id,
                    image: modelItem.image,
                    name: modelItem.name,
                    description: modelItem.description,
                    stocksAmount: modelItem.stocksAmount
                )

                self.viewModel?.yourCollections.contains(checkedItem) ?? false
                    ? cell.setButtonChecked()
                    : cell.setButtonUnchecked()


                cell.onPlusButtonPressed = {
                    let newCollection = YourCollectionViewCellModel(
                        id: modelItem.id,
                        image: modelItem.image,
                        name: modelItem.name,
                        description: modelItem.description,
                        stocksAmount: modelItem.stocksAmount
                    )

                    self.viewModel?.yourCollections.append(newCollection)
                    DispatchQueue.main.async {
                        cell.setButtonChecked()
                        self.snapshot.appendItems([newCollection], toSection: .yourCollections)
                        self.dataSource.apply(self.snapshot, animatingDifferences: true)
                    }
                }
            }

            return cell
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
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

        snapshot.appendSections([.yourCollections, .recommendedCollections])
        snapshot.appendItems(viewModel?.yourCollections ?? [], toSection: .yourCollections)
        snapshot.appendItems(viewModel?.recommendedCollections ?? [], toSection: .recommendedCollections)
        dataSource.apply(snapshot, animatingDifferences: false)

//        getData() // TODO: use the network call

    }

    // MARK: Functions

    func addCollectionToYourCollections() {
        self.onAddingCollectionToYourCollections?()
    }

    func goToCollectionDetails() {
        self.onGoToCollectionDetails?()
    }

    // MARK: Private

    // MARK: Properties

    private var discoverCollectionsCollectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>!
    private var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

    // MARK: Fucntions

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
