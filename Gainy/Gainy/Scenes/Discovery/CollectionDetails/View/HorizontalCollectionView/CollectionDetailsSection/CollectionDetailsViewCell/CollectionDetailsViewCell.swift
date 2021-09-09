import UIKit

private enum CollectionDetailsSection: Int, CaseIterable {
    case cards
}

final class CollectionDetailsViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)

        layer.isOpaque = true
        backgroundColor = .clear

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
        internalCollectionView.register(UINib(nibName: "CollectionListCardCell", bundle: nil), forCellWithReuseIdentifier: CollectionListCardCell.cellIdentifier)
        
        internalCollectionView.showsVerticalScrollIndicator = false
        internalCollectionView.backgroundColor = .clear
        internalCollectionView.dataSource = dataSource
        internalCollectionView.delegate = self
        internalCollectionView.contentInset = .init(top: 0, left: 0, bottom: 144, right: 0)
        internalCollectionView.contentInsetAdjustmentBehavior = .never
        internalCollectionView.clipsToBounds = false
        
        contentView.addSubview(internalCollectionView)
        contentView.bringSubviewToFront(collectionHorizontalView)
        contentView.addSubview(collectionListHeader)
        collectionListHeader.frame = CGRect.init(x: 4, y: 144, width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8 + 8), height: 36.0)
        collectionListHeader.isHidden = true
        
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

    var onCardPressed: ((DiscoverCollectionDetailsQuery.Data.Collection.TickerCollection.Ticker) -> Void)?
    var onSortingPressed: (() -> Void)?

    lazy var collectionHorizontalView: CollectionHorizontalView = {
        let view = CollectionHorizontalView()
        view.backgroundColor = .clear
        view.delegate = self
        return view
    }()
    
    lazy var collectionListHeader: CollictionsListHeaderView = {
        let view = CollictionsListHeaderView()
        view.frame = CGRect.init(x: 0, y: 0, width: contentView.bounds.width, height: 36.0)
        return view
    }()

    private var collectionID: Int = 0
    func configureWith(
        name collectionName: String,
        image collectionImage: String,
        imageUrl: String,
        description collectionDescription: String,
        stocksAmount: String,
        cards: [CollectionCardViewCellModel],
        collectionId: Int
    ) {
        self.collectionID = collectionId
        // TODO: 1: refactor logic below, think when appendItems/apply/layoutIfNeeded should be called
        collectionHorizontalView.configureWith(
            name: collectionName,
            description: collectionDescription,
            stocksAmount: stocksAmount,
            imageName: collectionImage,
            imageUrl: imageUrl,
            collectionId: collectionId
        )
        
        //Gettings settings
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(collectionId)
        if settings.viewMode == .list {
            collectionListHeader.isHidden = false
            internalCollectionView.frame = CGRect(
                x: 0,
                y: 144 + 36,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20) - 36
            )
            sections = [
                CardsOneColumnListFlowSectionLayout(),
                CardsTwoColumnGridFlowSectionLayout()
            ]
        } else {
            collectionListHeader.isHidden = true
            internalCollectionView.frame = CGRect(
                x: 0,
                y: 144,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20)
            )
            sections =  [
                CardsTwoColumnGridFlowSectionLayout(),
                CardsOneColumnListFlowSectionLayout()
            ]
        }
        
        self.cards = cards
        snapshot.deleteAllItems()

        snapshot.appendSections([.cards])
        snapshot.appendItems(cards, toSection: .cards)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    private var cards: [CollectionCardViewCellModel] = []

    // MARK: Private

    private lazy var sections: [SectionLayout] = [
        CardsTwoColumnGridFlowSectionLayout(),
        CardsOneColumnListFlowSectionLayout()
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

extension CollectionDetailsViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GainyAnalytics.logEvent("ticker_pressed", params: ["collectionID": self.collectionID, "tickerSymbol" : cards[indexPath.row].rawTicker.symbol, "tickerName" : cards[indexPath.row].rawTicker.name])
        onCardPressed?(cards[indexPath.row].rawTicker)
    }
}

extension CollectionDetailsViewCell: CollectionHorizontalViewDelegate {
    func stocksViewModeChanged(view: CollectionHorizontalView, isGrid: Bool) {
        if isGrid && sections.first! is CardsTwoColumnGridFlowSectionLayout  {return}
        if !isGrid && sections.first! is CardsOneColumnListFlowSectionLayout {return}
        
        if isGrid {
            collectionListHeader.isHidden = true
            internalCollectionView.frame = CGRect(
                x: 0,
                y: 144,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20)
            )
            //stocks_view_changed
            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID": self.collectionID, "view" : "grid"])
        } else if (!isGrid && sections.first! is CardsTwoColumnGridFlowSectionLayout) {
            collectionListHeader.isHidden = false
            internalCollectionView.frame = CGRect(
                x: 0,
                y: 144 + 36,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20) - 36
            )
            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID": self.collectionID, "view" : "list"])
        }
        
        sections.swapAt(0, 1)
        internalCollectionView.reloadData()        
    }
    
    func stockSortPressed(view: CollectionHorizontalView) {
        onSortingPressed?()
    }
}
