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
        contentView.addSubview(tickersLoadIndicator)
        tickersLoadIndicator.center = internalCollectionView.center
        
        let recurLock = NSRecursiveLock()
        
        dataSource = UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>(
            collectionView: internalCollectionView
        ) { [weak self] collectionView, indexPath, modelItem -> UICollectionViewCell? in
            let cell = self?.sections[indexPath.section].configureCell(
                collectionView: collectionView,
                indexPath: indexPath,
                viewModel: modelItem,
                position: indexPath.row
            )
            
            //Loading tickers data!
            recurLock.lock()
            if let model = modelItem as? CollectionCardViewCellModel, !(self?.isLoadingTickers ?? false) {
                
                if !TickerLiveStorage.shared.haveSymbol(model.tickerSymbol) {
                    self?.isLoadingTickers = true
                    dprint("Fetching dt started \(model.tickerSymbol)")
                    TickersLiveFetcher.shared.getSymbolsData(self?.cards.dropFirst(indexPath.row).prefix(Constants.CollectionDetails.tickersPreloadCount).compactMap({$0.tickerSymbol}) ?? []) {
                        dprint("Fetching dt ended \(model.tickerSymbol)")
                        
                        guard let self = self else {return}
                        self.isLoadingTickers = false
                        if var snapshot = self.dataSource?.snapshot() {
                            if snapshot.itemIdentifiers.count > 0 {
                                let ids =  self.internalCollectionView.indexPathsForVisibleItems.compactMap({$0.row}).compactMap({snapshot.itemIdentifiers[$0]})
                                snapshot.reloadItems(ids)
                            }
                            self.dataSource?.apply(snapshot, animatingDifferences: true)
                        }
                    }
                } else {
                    self?.isLoadingTickers = false
                }
            }
            recurLock.unlock()
            
            return cell
        }
        
        initViewModels()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    private var isLoadingTickers: Bool = false {
        didSet {
            if isLoadingTickers {
                tickersLoadIndicator.startAnimating()
                internalCollectionView.isScrollEnabled = false
                internalCollectionView.isUserInteractionEnabled = false
                internalCollectionView.alpha = 0.3
                internalCollectionView.setContentOffset(internalCollectionView.contentOffset, animated: false)
            } else {
                tickersLoadIndicator.stopAnimating()
                internalCollectionView.isScrollEnabled = true
                internalCollectionView.isUserInteractionEnabled = true
                internalCollectionView.alpha = 1.0
            }
        }
    }
    
    // MARK: Properties
    
    var viewModel: CollectionCardViewCellModel?
    
    var onCardPressed: ((RemoteTickerDetails) -> Void)?
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
                CardsOneColumnListFlowSectionLayout(collectionID: collectionID),
                CardsTwoColumnGridFlowSectionLayout(collectionID: collectionID)
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
                CardsTwoColumnGridFlowSectionLayout(collectionID: collectionID),
                CardsOneColumnListFlowSectionLayout(collectionID: collectionID)
            ]
        }
        
        collectionHorizontalView.updateChargeLbl(settings.sorting.title)
        self.cards = cards
        sortSections()
    }
    private var cards: [CollectionCardViewCellModel] = []
    
    func sortSections() {
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(self.collectionID)
        collectionHorizontalView.updateChargeLbl(settings.sorting.title)
        
        collectionListHeader.updateMetrics(settings.marketDataToShow.prefix(5).map(\.shortTitle))
        self.cards = self.cards.sorted(by: { lhs, rhs in
            settings.sorting.sortFunc(isAsc: settings.ascending, lhs, rhs)
        })
        snapshot.deleteAllItems()
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {[weak self] in
            guard var snapshot = self?.snapshot else {return}
            snapshot.appendSections([.cards])
            snapshot.appendItems(self?.cards ?? [], toSection: .cards)
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    // MARK: Private
    
    private lazy var sections: [SectionLayout] = [
        CardsTwoColumnGridFlowSectionLayout(collectionID: collectionID),
        CardsOneColumnListFlowSectionLayout(collectionID: collectionID)
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
    
    private lazy var tickersLoadIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.tintColor = UIColor(named: "mainText")
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private func initViewModels() {}
}

extension CollectionDetailsViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GainyAnalytics.logEvent("ticker_pressed", params: ["collectionID": self.collectionID,
                                                           "tickerSymbol" : cards[indexPath.row].rawTicker.symbol,
                                                           "tickerName" : cards[indexPath.row].rawTicker.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
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
            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID" : self.collectionID, "view" : "grid", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        } else if (!isGrid && sections.first! is CardsTwoColumnGridFlowSectionLayout) {
            collectionListHeader.isHidden = false
            internalCollectionView.frame = CGRect(
                x: 0,
                y: 144 + 36,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20) - 36
            )
            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID": self.collectionID, "view" : "list", "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        }
        
        sections.swapAt(0, 1)
        internalCollectionView.reloadData()
    }
    
    func stockSortPressed(view: CollectionHorizontalView) {
        onSortingPressed?()
    }
}
