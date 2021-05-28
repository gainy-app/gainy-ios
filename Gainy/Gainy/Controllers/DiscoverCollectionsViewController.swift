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
//    var discoveredCollections: [DiscoveredCollectionItemViewModel] = []
//    var recommendedCollections: [RecommendedCollectionItemViewModel] = []

    // MARK: - Init

    override init() {
        super.init()
    }
}

protocol DiscoverCollectionsViewControllerProtocol: BaseViewControllerProtocol {
    var onGoToCollectionDetails: (() -> Void)? { get set }
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
    lazy var sections: [LayoutSection] = [
        YourCollectionsSection(),
        RecommendedCollectionsSection(),
    ]

    lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            self.sections[sectionIndex].layoutSection
        }
        return layout
    }()

    var viewModel: DiscoverCollectionsViewModelProtocol?

    var onGoToCollectionDetails: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.discoverCollectionsCollectionView = UICollectionView(
            frame: self.view.frame,
            collectionViewLayout: customLayout
        )
        self.view.addSubview(discoverCollectionsCollectionView)

        self.discoverCollectionsCollectionView.register(
            DiscoveredCollectionsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DiscoveredCollectionsHeaderView.reuseIdentifier
        )

        self.discoverCollectionsCollectionView.register(DiscoveredCollectionViewCell.self)
        self.discoverCollectionsCollectionView.register(RecommendedCollectionViewCell.self)

        self.discoverCollectionsCollectionView.backgroundColor = UIColor.Gainy.white
        self.discoverCollectionsCollectionView.showsVerticalScrollIndicator = false

        self.discoverCollectionsCollectionView.dataSource = dataSource

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: discoverCollectionsCollectionView
        ) { collectionView, indexPath, modelItem -> UICollectionViewCell? in
            self.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: modelItem,
                position: indexPath.row
            )
        }

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else {
                return nil
            }

            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: DiscoveredCollectionsHeaderView.reuseIdentifier,
                for: indexPath
            ) as? DiscoveredCollectionsHeaderView

//            let section = self
//                .dataSource
//                .snapshot()
//                .sectionIdentifiers[indexPath.section]
//            headerView?.titleLabel.text = section.title
            switch indexPath.section {
            case Section.yourCollections.rawValue:
                headerView?.configureWith(
                    title: "Your collections",
                    description: "Tap to view, swipe to edit or drag & drop to reorder"
                )
            case Section.recommendedCollections.rawValue:
                headerView?.configureWith(
                    title: "Collections you might like",
                    description: "Tap on collection for preview, or tap on plus icon to add to your discovery"
                )
            default:
                assertionFailure("FAILURE")
            }
            return headerView
        }

        snapshot.appendSections([.yourCollections, .recommendedCollections])
        snapshot.appendItems(DummyDataSource.collections, toSection: .yourCollections)
        snapshot.appendItems(DummyDataSource.recommendedCollections, toSection: .recommendedCollections)
        dataSource.apply(snapshot, animatingDifferences: false)

//        getData() // TODO: use the network call

    }

    // MARK: Functions

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
