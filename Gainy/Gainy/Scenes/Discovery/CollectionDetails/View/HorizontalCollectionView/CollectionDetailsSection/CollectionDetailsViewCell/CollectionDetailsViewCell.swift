import UIKit
import SkeletonView

private enum CollectionDetailsSection: Int, CaseIterable {
    case cards
}

final class CollectionDetailsFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CollectionDetailsViewCell: UICollectionViewCell {
    // MARK: Lifecycle
    
    override init(frame _: CGRect) {
        super.init(frame: .zero)
        
        isSkeletonable = true
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
        
        internalCollectionView.addSubview(refreshControl)
        internalCollectionView.alwaysBounceVertical = true
        
        internalCollectionView.register(CollectionCardCell.self)
        internalCollectionView.register(UINib(nibName: "CollectionListCardCell", bundle: nil), forCellWithReuseIdentifier: CollectionListCardCell.cellIdentifier)
        
        internalCollectionView.register(CollectionDetailsFooterView.self,
                                        forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                        withReuseIdentifier: "CollectionDetailsFooterView")
        
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
            TickerLiveStorage.shared.clearAllExpiredLiveData()
            
            if let model = modelItem as? CollectionCardViewCellModel, model.tickerCompanyName.hasPrefix(Constants.CollectionDetails.demoNamePrefix) {
                cell?.showAnimatedGradientSkeleton()
                return cell
            }
            //Loading tickers data!
            recurLock.lock()
            if let model = modelItem as? CollectionCardViewCellModel, !(self?.isLoadingTickers ?? false) {
                
                let dispatchGroup = DispatchGroup()
                var loadingItems: Int  = 0
                let hasSymbol = TickerLiveStorage.shared.haveSymbol(model.tickerSymbol)
                let isLoadingSymbol = self?.loadingSymbolArray.contains(where: { item in
                    item == model.tickerSymbol
                }) ?? false
                let needLoadSymbol = !hasSymbol && !isLoadingSymbol
                if needLoadSymbol {
                    loadingItems += 1
                    self?.loadingSymbolArray.append(model.tickerSymbol)
                    if collectionView.visibleCells.count == 0 {
                        cell?.showAnimatedGradientSkeleton()
                    } else {
                        self?.isLoadingTickers = true
                    }
                    dprint("Fetching dt started \(model.tickerSymbol)")
                    dispatchGroup.enter()
                    TickersLiveFetcher.shared.getSymbolsData(self?.cards.dropFirst(indexPath.row).prefix(Constants.CollectionDetails.tickersPreloadCount).compactMap({$0.tickerSymbol}) ?? []) {
                        self?.loadingSymbolArray.removeAll(where: { item in
                            item == model.tickerSymbol
                        })
                        dispatchGroup.leave()
                        dprint("Fetching dt ended \(model.tickerSymbol)")
                    }
                }
                
                if loadingItems > 0 {
                dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                    dprint("Fetching ended \(model.tickerSymbol)")
                    guard let self = self else {return}
                    
                    self.isLoadingTickers = false
                    
                    if var snapshot = self.dataSource?.snapshot() {
                        if snapshot.itemIdentifiers.count > 0 {
                            let ids =  self.internalCollectionView.indexPathsForVisibleItems.compactMap({$0.row}).compactMap({snapshot.itemIdentifiers[$0]})
                            snapshot.reloadItems(ids)
                        }
                        self.dataSource?.apply(snapshot, animatingDifferences: true)
                    }
                })
                } else {
                    cell?.hideSkeleton()
                }
            } else {
                cell?.showAnimatedGradientSkeleton()
            }
            recurLock.unlock()
            
            if indexPath.row == (self?.cards.count ?? 0) - 1 && self?.cards.count ?? 0 != (self?.stocksCount ?? 0) {
                //isLoadingTickers = true
                
            }

            return cell
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            switch kind {
            case UICollectionView.elementKindSectionFooter:
                
                guard let self = self else { return UICollectionReusableView() }
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionDetailsFooterView", for: indexPath)
                footer.addSubview(self.loadMoreActivityIndicatorView)
                self.loadMoreActivityIndicatorView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 64)
                self.loadMoreActivityIndicatorView.startAnimating()
                return footer
                
            default:
                return nil
            }
        }
        
        initViewModels()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCompare: Bool = false {
        didSet {
            collectionHorizontalView.isCompare = isCompare
        }
    }
    
    // MARK: Internal
    
    @MainActor
    private var isLoadingTickers: Bool = false {
        didSet {
            if isLoadingTickers {
                for cell in internalCollectionView.visibleCells {
                    if let rightCell = cell as? CollectionCardCell {
                        rightCell.showAnimatedGradientSkeleton()
                    }
                    if let rightCell = cell as? CollectionListCardCell {
                        rightCell.showAnimatedGradientSkeleton()
                    }
                }
                
//                internalCollectionView.isScrollEnabled = false
                internalCollectionView.isUserInteractionEnabled = false
                internalCollectionView.setContentOffset(internalCollectionView.contentOffset, animated: false)
            } else {
                for cell in internalCollectionView.visibleCells {
                    if let rightCell = cell as? CollectionCardCell {
                        rightCell.hideSkeleton()
                    }
                    if let rightCell = cell as? CollectionListCardCell {
                        rightCell.hideSkeleton()
                    }
                }
//                internalCollectionView.isScrollEnabled = true
                internalCollectionView.isUserInteractionEnabled = true
            }
        }
    }
    
    // MARK: Properties
    
    var viewModel: CollectionCardViewCellModel?
    
    var onCardPressed: ((RemoteTickerDetails) -> Void)?
    var onSortingPressed: (() -> Void)?
    var onAddStockPressed: (() -> Void)?
    var onSettingsPressed: (((RemoteTickerDetails)) -> Void)?
    var onNewCardsLoaded: ((([CollectionCardViewCellModel])) -> Void)?
    
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
    private var stocksCount: Int = 0
    
    private var loadingSymbolArray: Array<String> = Array()
    private var loadingMatchScoreArray: Array<String> = Array()
    
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
        self.stocksCount = Int(stocksAmount) ?? 0
        collectionHorizontalView.tag = collectionId
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
        
        collectionHorizontalView.updateChargeLbl(settings.sortingText())
        self.cards = cards
        sortSections()
    }
    private(set) var cards: [CollectionCardViewCellModel] = []
    
    private func loadMoreTickers() {
        
        if (self.collectionID == -1) {
            return
        }
        
        self.isLoadingMoreTickers = true
        
        DispatchQueue.global(qos:.utility).async {
            CollectionsManager.shared.loadMoreTickersLoading(collectionID: self.collectionID, offset: self.cards.count) { tickerDetails in
                runOnMain {
                    
                    var tickers = tickerDetails.compactMap { item in
                        item.rawTicker
                    }
                    let curSymbols = self.cards.compactMap({$0.tickerSymbol})
                    tickers.removeAll(where: {curSymbols.contains($0.symbol ?? "")})
                    self.addRemoteStocks(tickers)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
                        self?.isLoadingMoreTickers = false
                    }
                }
            }
        }
    }
    
    func addRemoteStocks(_ stocks: [RemoteTickerDetails]) {
        
        let cardsDTO = stocks.compactMap({CollectionDetailsDTOMapper.mapTickerDetails($0)}).compactMap({CollectionDetailsViewModelMapper.map($0)})
        cards.append(contentsOf: cardsDTO)
        onNewCardsLoaded?(cardsDTO)
        if var snap = dataSource?.snapshot() {
            snap.appendItems(cardsDTO, toSection: .cards)
            dataSource?.apply(snap, animatingDifferences: false)
        }
    }
    
    func sortSections(_ completion: (() -> Void)? = nil) {
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(self.collectionID)
        collectionHorizontalView.updateChargeLbl(settings.sortingText())
        
        collectionListHeader.updateMetrics(settings.marketDataToShow)
        self.cards = self.cards.sorted(by: { lhs, rhs in
            settings.sortingValue().sortFunc(isAsc: settings.ascending, lhs, rhs)
        })
        snapshot.deleteAllItems()
        dataSource?.apply(snapshot, animatingDifferences: false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {[weak self] in
            guard var snapshot = self?.snapshot else {return}
            snapshot.appendSections([.cards])
            snapshot.appendItems(self?.cards ?? [], toSection: .cards)
            self?.dataSource?.apply(snapshot, animatingDifferences: true)
            completion?()
        }
    }
    
    // MARK: Private
    
    private lazy var sections: [SectionLayout] = [
        CardsTwoColumnGridFlowSectionLayout(collectionID: collectionID),
        CardsOneColumnListFlowSectionLayout(collectionID: collectionID)
    ]
    
    private var dataSource: UICollectionViewDiffableDataSource<CollectionDetailsSection, AnyHashable>?
    private var snapshot = NSDiffableDataSourceSnapshot<CollectionDetailsSection, AnyHashable>()
    private var isLoadingMoreTickers: Bool = false
    private var internalCollectionView: UICollectionView!
    private lazy var refreshControl: LottieRefreshControl = {
        let control = LottieRefreshControl()
        control.layer.zPosition = -1
        control.clipsToBounds = true
        control.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return control
    } ()
    
    private lazy var loadMoreActivityIndicatorView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        return spinner
    } ()
    
    private lazy var customLayout: UICollectionViewLayout = {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, env -> NSCollectionLayoutSection? in
            self?.sections[sectionIndex].layoutSection(within: env)
        }
        return layout
    }()
    
    private func initViewModels() {}
    
    private func finishRefreshWithSorting(cards: [CollectionCardViewCellModel]) {
        runOnMain {
            
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(self.collectionID)
            self.collectionHorizontalView.updateChargeLbl(settings.sortingText())
            self.collectionListHeader.updateMetrics(settings.marketDataToShow)
            self.cards = cards.sorted(by: { lhs, rhs in
                settings.sortingValue().sortFunc(isAsc: settings.ascending, lhs, rhs)
            })
            
            self.snapshot.deleteAllItems()
            self.dataSource?.apply(self.snapshot, animatingDifferences: false)
            self.cards.removeAll()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {[weak self] in
                guard var snapshot = self?.snapshot else {return}
                snapshot.appendSections([.cards])
                snapshot.appendItems(cards, toSection: .cards)
                self?.dataSource?.apply(snapshot, animatingDifferences: true)
                self?.isLoadingTickers = false
            }
        }
    }
    
    func refreshData() {
        
        refreshControl.endRefreshing()
        self.isLoadingTickers = true
        
        if self.collectionID == -1 {
            CollectionsManager.shared.watchlistCollectionsLoading { models in
                if let cards = models.first?.cards {
                    self.finishRefreshWithSorting(cards: cards)
                }
            }
            return
        }
        
        DispatchQueue.global(qos:.utility).async {
            CollectionsManager.shared.loadNewCollectionDetails(self.collectionID) { remoteTickers in
                runOnMain {
                    let tickers = remoteTickers.compactMap { item in
                        item.rawTicker
                    }
                    let cards = tickers.compactMap({CollectionDetailsDTOMapper.mapTickerDetails($0)}).compactMap({CollectionDetailsViewModelMapper.map($0)})
                    self.finishRefreshWithSorting(cards: cards)
                }
            }
        }
    }
    
    @objc func refresh(_ sender:AnyObject) {
        
        self.refreshData()
    }
}

extension CollectionDetailsViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        GainyAnalytics.logEvent("ticker_pressed", params: ["collectionID": self.collectionID,
                                                           "tickerSymbol" : cards[indexPath.row].rawTicker.symbol,
                                                           "tickerName" : cards[indexPath.row].rawTicker.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        onCardPressed?(cards[indexPath.row].rawTicker)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
    
        guard UICollectionView.elementKindSectionFooter == elementKind else { return }
        if self.stocksCount == self.cards.count || self.collectionID == -1 {
            self.loadMoreActivityIndicatorView.isHidden = true
        } else {
            if self.isLoadingMoreTickers {
                return
            }
            self.loadMoreActivityIndicatorView.isHidden = false
            self.loadMoreActivityIndicatorView.startAnimating()
            self.loadMoreTickers()
        }
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
            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID" : self.collectionID, "view" : "grid", "ec" : "CollectionDetails"])
        } else if (!isGrid && sections.first! is CardsTwoColumnGridFlowSectionLayout) {
            collectionListHeader.isHidden = false
            internalCollectionView.frame = CGRect(
                x: 0,
                y: 144 + 36,
                width: UIScreen.main.bounds.width - (8 + 4 + 4 + 8),
                height: UIScreen.main.bounds.height - (80 + 144 + 20) - 36
            )
            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID": self.collectionID, "view" : "list", "ec" : "CollectionDetails"])
        }
        
        sections.swapAt(0, 1)
        internalCollectionView.clipsToBounds = true
        internalCollectionView.reloadData()
    }
    
    
    func stockSortPressed(view: CollectionHorizontalView) {
        onSortingPressed?()
    }
    
    func comparePressed(view: CollectionHorizontalView) {
        onAddStockPressed?()
    }
    
    func settingsPressed(view: CollectionHorizontalView) {
        guard cards.count > 0 else {
            return
        }
        onSettingsPressed?(cards[0].rawTicker)
    }
}
