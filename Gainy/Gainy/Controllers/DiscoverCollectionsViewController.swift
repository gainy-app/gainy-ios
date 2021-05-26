import UIKit

typealias CollectionsDataSource = UICollectionViewDiffableDataSource
<DiscoverCollectionsViewController.Section, Collection>
typealias CollectionsDataSourceSnapshot = NSDiffableDataSourceSnapshot
<DiscoverCollectionsViewController.Section, Collection>

class DiscoverCollectionsViewController: UIViewController {
    // MARK: Internal

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        updateSnapshot()
    }

    // MARK: Private

    // MARK: IBOutlets

    private var discoverCollectionsCollectionView: UICollectionView!

    // MARK: Properties

    private lazy var dataSource = configureDataSource()

    // MARK: Functions

    private func setUpCollectionView() {
        self.discoverCollectionsCollectionView = UICollectionView(frame: self.view.frame,
                                                                  collectionViewLayout: appleLayout())
        self.discoverCollectionsCollectionView.backgroundColor = .white // UIColor(hexRgb: 0xE5E5E5)
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
                                   stocksAmount: collection.stocksAmount)
                return cell
            case Section.recommended.rawValue:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: RecommendedCollectionViewCell.reuseIdentifier,
                    for: indexPath
                ) as? RecommendedCollectionViewCell else {
                    assertionFailure("FAILURE")
                    return UICollectionViewCell()
                }

                cell.configureWith(name: collection.name,
                                   description: collection.description,
                                   stocksAmount: collection.stocksAmount)
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
        var snapshot = CollectionsDataSourceSnapshot()
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

            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(90)
            )
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section.boundarySupplementaryItems = [sectionHeader]

            return section
        }
    }
}

// TODO: Use UICollectionViewDragDelegate/UICollectionViewDropDelegate
extension DiscoverCollectionsViewController: UICollectionViewDelegate {}
