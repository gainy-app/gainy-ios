import UIKit

final class CollectionDetailsViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        layer.isOpaque = true

//        let view = RoundedCornerView(
//            frame: CGRect(
//                x: 4,
//                y: 0,
//                width: 414 - (16 + 16),
//                height: 144
//            )
//        )
//
//        view.backgroundColor = .red
//        addSubview(view)

        collectionHorizontalView.frame = CGRect(
            x: 4,
            y: 0,
            width: 414 - (16 + 16),
            height: 144
        )

        addSubview(collectionHorizontalView)

        internalCollectionView = UICollectionView(
            frame: CGRect(
                x: 4,
                y: 144,
                width: 414 - (16 + 16),
                height: 736 - 80
            ),
            collectionViewLayout: customLayout
        )

        internalCollectionView.register(CollectionCardCell.self)

        internalCollectionView.showsVerticalScrollIndicator = false

        internalCollectionView.backgroundColor = UIColor.Gainy.white // .brown
        internalCollectionView.dataSource = dataSource

        addSubview(internalCollectionView)

        backgroundColor = UIColor.Gainy.white

        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(
            collectionView: internalCollectionView
        ) { [weak self] collectionView, indexPath, _ -> UICollectionViewCell? in
            let cell: CollectionCardCell = collectionView.dequeueReusableCell(for: indexPath)

            cell.configureWith(
                companyName: "Microsoft",
                tickerSymbol: "MSFT",
                tickerPercentChange: 2.58,
                tickerTotalPrice: "$283.61",
                highlight: "150x Revenue growth and 4x evaluation compare to industry median"
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

    enum Section: Int, CaseIterable {
        case cards
    }

    lazy var collectionHorizontalView: CollectionHorizontalView = {
        let view = CollectionHorizontalView()

        // TODO: replace
        view.configureWith(name: "Global Dividend",
                           description: "Global top rated dividended companies",
                           stocksAmount: "20",
                           imageName: "1 dollar stocks")

        return view
    }()

    func configureWith(
        name _: String,
        cards: [String]
    ) {
        snapshot.appendItems(cards, toSection: .cards)

        dataSource?.apply(snapshot, animatingDifferences: false)

        layoutIfNeeded()
    }

    // MARK: Private

    // Derives the order of the sections
    private lazy var sections: [SectionLayout] = [
        CardsTwoColumnGridFlowSectionLayout(),
    ]

    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

    private var internalCollectionView: UICollectionView!

    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] _, _ -> NSCollectionLayoutSection? in
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

//            group.contentInsets = NSDirectionalEdgeInsets(
//                top: 0, leading: 0, bottom: 0, trailing: 0
//            )

            group.interItemSpacing = .fixed(15)

            return NSCollectionLayoutSection(
                group: group
            )
        }

        return layout
    }()

    private func initViewModels() {
        snapshot.appendSections([.cards])
//        snapshot.appendItems(DummyDataSource.collectionDetails, toSection: .cards)
//
//        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}
