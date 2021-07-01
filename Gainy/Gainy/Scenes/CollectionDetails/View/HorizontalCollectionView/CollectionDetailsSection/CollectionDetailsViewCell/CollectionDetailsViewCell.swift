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

        contentView.addSubview(collectionHorizontalView)

        internalCollectionView = UICollectionView(
            frame: CGRect(
                x: 0,
                y: 144,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20)
            ),
            collectionViewLayout: customLayout
        )

        internalCollectionView.register(CollectionCardCell.self)

        internalCollectionView.showsVerticalScrollIndicator = false
        internalCollectionView.backgroundColor = UIColor.Gainy.white
        internalCollectionView.dataSource = dataSource

        contentView.addSubview(internalCollectionView)

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

        snapshot.deleteAllItems()

        snapshot.appendSections([.cards])
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
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()

    private func initViewModels() {}
}
