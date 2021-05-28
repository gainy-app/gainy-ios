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

protocol DiscoverCollectionsViewModelProtocol {
//    var discoveredCollections: [DiscoveredCollectionItemViewModel] { get }
//    var recommendedCollections: [RecommendedCollectionItemViewModel] { get }
}

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
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        updateSnapshot()
    }

    // MARK: Internal

    // MARK: Properties

    var viewModel: DiscoverCollectionsViewModelProtocol?

    var onGoToCollectionDetails: (() -> Void)?

    // MARK: Functions

//    @IBAction
    func goToCollectionDetails() {
        self.onGoToCollectionDetails?()
    }

    // MARK: Types

    enum Section: Int, CaseIterable {
        case discovered
        case recommended

        // MARK: Internal

        var columns: Int {
            switch self {
            case .discovered: return 1
            case .recommended: return 3
            }
        }
    }

    // MARK: Private

    // MARK: Properties

    private var discoverCollectionsCollectionView: UICollectionView!

    private lazy var dataSource = configureDataSource()
    private var snapshot = CollectionsDataSourceSnapshot()

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
                    self.updateSnapshot()
                }

                print("Success! Result: \(graphQLResult)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }

    // MARK: Functions

    private func setUpCollectionView() {
        self.discoverCollectionsCollectionView = UICollectionView(frame: self.view.frame,
                                                                  collectionViewLayout: appleLayout())
        self.discoverCollectionsCollectionView.backgroundColor = UIColor.Gainy.white
        self.discoverCollectionsCollectionView.showsVerticalScrollIndicator = false
        self.discoverCollectionsCollectionView.dataSource = dataSource

        self.view.addSubview(discoverCollectionsCollectionView)

        self.discoverCollectionsCollectionView.register(
            DiscoveredCollectionsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: DiscoveredCollectionsHeaderView.reuseIdentifier
        )

        self.discoverCollectionsCollectionView.register(
            DiscoveredCollectionViewCell.self,
            forCellWithReuseIdentifier: DiscoveredCollectionViewCell.reuseIdentifier
        )

        self.discoverCollectionsCollectionView.register(
            RecommendedCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendedCollectionViewCell.reuseIdentifier
        )
    }

    private func configureDataSource() -> CollectionsDataSource {
        let dataSource = CollectionsDataSource(
            collectionView: discoverCollectionsCollectionView
        ) { collectionView, indexPath, collection -> UICollectionViewCell? in
            switch indexPath.section {
            case Section.discovered.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: DiscoveredCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? DiscoveredCollectionViewCell else {
                    assertionFailure("FAILURE")
                    return UICollectionViewCell()
                }

                cell.configureWith(name: collection.name,
                                   description: collection.description,
                                   stocksAmount: collection.stocksAmount,
                                   imageName: collection.image)
                return cell
            case Section.recommended.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecommendedCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? RecommendedCollectionViewCell else {
                    assertionFailure("FAILURE")
                    return UICollectionViewCell()
                }

                // TODO: fix
                let collectionToCheck = Collection(
                    id: collection.id,
                    image: collection.image,
                    name: collection.name,
                    description: collection.description,
                    stocksAmount: collection.stocksAmount,
                    discovered: true
                )

                DummyDataSource.collections.contains(collectionToCheck)
                    ? cell.setButtonChecked()
                    : cell.setButtonUnchecked()

                cell.configureWith(name: collection.name,
                                   description: collection.description,
                                   stocksAmount: collection.stocksAmount,
                                   imageName: collection.image)
                cell.plusButtonPressed = {
                    let newCollection = Collection(
                        id: collection.id,
                        image: collection.image,
                        name: collection.name,
                        description: collection.description,
                        stocksAmount: collection.stocksAmount,
                        discovered: true
                    )

                    if !DummyDataSource.collections.contains(newCollection) {
                        print(DummyDataSource.collections.count)
                        DummyDataSource.collections.append(newCollection)
                        DispatchQueue.main.async {
                            cell.setButtonChecked()
                            self.snapshot.appendItems([newCollection], toSection: .discovered)
                            self.dataSource.apply(self.snapshot, animatingDifferences: true)
                        }
                    }
                }
                return cell
            default:
                return UICollectionViewCell()
            }
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
            case Section.discovered.rawValue:
                headerView?.configureWith(
                    title: "Your collections",
                    description: "Tap to view, swipe to edit or drag & drop to reorder"
                )
            case Section.recommended.rawValue:
                headerView?.configureWith(
                    title: "Collections you might like",
                    description: "Tap on collection for preview, or tap on plus icon to add to your discovery"
                )
            default:
                assertionFailure("FAILURE")
            }
            return headerView
        }

        return dataSource
    }

    private func updateSnapshot(animatingChange _: Bool = false) {
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(DummyDataSource.collections,
                             toSection: .discovered)
        snapshot.appendItems(DummyDataSource.recommendedCollections,
                             toSection: .recommended)

        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func appleLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { (_ sectionIndex: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else {
                return nil
            }

            let columns = sectionKind.columns

            // Items
            let discoveryItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let discoveryItem = NSCollectionLayoutItem(layoutSize: discoveryItemSize)

            let recommendedItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / CGFloat(columns)),
                heightDimension: .fractionalHeight(1.0)
            )
            let recommendedItem = NSCollectionLayoutItem(layoutSize: recommendedItemSize)
            recommendedItem.contentInsets = NSDirectionalEdgeInsets(
                top: 0.0,
                leading: 4.0,
                bottom: 0.0,
                trailing: 4.0
            )

            // Group
            let discoveredGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(88)
            )
            let discoveredGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: discoveredGroupSize,
                subitems: [discoveryItem]
            )
            discoveredGroup.contentInsets = NSDirectionalEdgeInsets(
                top: 0.0,
                leading: 16.0,
                bottom: 8.0,
                trailing: 16.0
            )

            let recommendedGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(144)
            )
            let recommendedGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: recommendedGroupSize,
                subitem: recommendedItem,
                count: columns
            )
            recommendedGroup.contentInsets = NSDirectionalEdgeInsets(
                top: 8.0,
                leading: 14.0,
                bottom: 0.0,
                trailing: 14.0
            )

            let group = columns == 1 ? discoveredGroup : recommendedGroup
            let section = NSCollectionLayoutSection(group: group)

            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(70)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0.0,
                leading: 0.0,
                bottom: 12.0,
                trailing: 0.0
            )

            return section
        }
    }
}

// TODO: Use UICollectionViewDragDelegate/UICollectionViewDropDelegate
extension DiscoverCollectionsViewController: UICollectionViewDelegate {}
