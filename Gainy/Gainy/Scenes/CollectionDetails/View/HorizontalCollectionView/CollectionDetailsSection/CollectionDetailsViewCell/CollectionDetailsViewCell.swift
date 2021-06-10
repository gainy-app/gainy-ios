import UIKit

private enum CollectionDetailsSection: Int, CaseIterable {
    case cards
}

final class CollectionDetailsViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        layer.isOpaque = true
        backgroundColor = UIColor.Gainy.white

        collectionHorizontalView.frame = CGRect(
            x: 4,
            y: 0,
            width: UIScreen.main.bounds.width - (16 + 16),
            height: 144
        )

        collectionHorizontalView.backgroundColor = .clear

        addSubview(collectionHorizontalView)

        internalCollectionView = UICollectionView(
            frame: CGRect(
                x: 4,
                y: 144,
                width: UIScreen.main.bounds.width - (16 + 16),
                height: UIScreen.main.bounds.height - (80 + 144 + 20)
            ),
            collectionViewLayout: customLayout
        )

        internalCollectionView.register(CollectionCardCell.self)

        internalCollectionView.showsVerticalScrollIndicator = false
        internalCollectionView.backgroundColor = UIColor.Gainy.white
        internalCollectionView.dataSource = dataSource

        addSubview(internalCollectionView)

        dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>(
            collectionView: internalCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )

            return cell
        }

        initViewModels()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    // MARK: Properties

    var viewModel: CollectionCardViewCellModel?

    lazy var collectionHorizontalView: CollectionHorizontalView = {
        let view = CollectionHorizontalView()

        return view
    }()

    func configureWith(
        name collectionName: String,
        image collectionImage: String,
        description collectionDescription: String,
        stocksAmount: String,
        cards: [CollectionCardViewCellModel]
    ) {
        // TODO: 1: refactor logic below, think when appendItems/apply/layoutIfNeeded should be called
        collectionHorizontalView.configureWith(
            name: collectionName,
            description: collectionDescription,
            stocksAmount: stocksAmount,
            imageName: collectionImage
        )

//        snapshot.appendSections([.cards])
        snapshot.appendItems(cards, toSection: .cards)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }

    // MARK: Private

    private lazy var sections: [SectionLayout] = [
        CardsTwoColumnGridFlowSectionLayout(),
    ]

    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, AnyHashable>()

    private var internalCollectionView: UICollectionView!

    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .fractionalHeight(1)
                )
            )

            item.contentInsets = NSDirectionalEdgeInsets(
                top: 16, leading: 0, bottom: 0, trailing: 0
            )

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(216 + 16)
                ),
                subitem: item,
                count: 2
            )
            group.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 6, bottom: 0, trailing: 6
            )

            group.interItemSpacing = .fixed(15)

            let section = NSCollectionLayoutSection(
                group: group
            )
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 0, leading: 0, bottom: 13, trailing: 0
            )

            return section
        }

        return layout
    }()

    private func initViewModels() {
        snapshot.appendSections([.cards])
        snapshot.appendItems([], toSection: .cards)
//        snapshot.appendItems(DummyDataSource.collectionDetails, toSection: .cards)
//
//        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
