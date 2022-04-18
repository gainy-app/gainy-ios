import UIKit
import SkeletonView
import Combine
import PureLayout


private enum CollectionDetailsSection: Int, CaseIterable {
    case title = 0
    case gain
    case chart
    case about
    case recommended
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
        
        layer.isOpaque = true
        backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout.init()
        collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(CollectionDetailsTitleCell.self)
        collectionView.register(CollectionDetailsGainCell.self)
        collectionView.register(CollectionDetailsChartCell.self)
        collectionView.register(CollectionDetailsAboutCell.self)
        collectionView.register(CollectionDetailsRecommendedCell.self)
        
        collectionView.register(CollectionCardCell.self)
        
        collectionView.register(UINib(nibName: "CollectionListCardCell", bundle: nil), forCellWithReuseIdentifier: CollectionListCardCell.cellIdentifier)
        
        collectionView.register(CollectionDetailsFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "CollectionDetailsFooterView")
        
        collectionView.register(CollectionDetailsHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "CollectionDetailsHeaderView")
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 111, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.clipsToBounds = false
        contentView.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        
        // TODO: Borysov - add headers/footers for the section
        //        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
        //            switch kind {
        //            case UICollectionView.elementKindSectionFooter:
        //
        //                guard let self = self else { return UICollectionReusableView() }
        //                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionDetailsFooterView", for: indexPath)
        //                footer.addSubview(self.loadMoreActivityIndicatorView)
        //                self.loadMoreActivityIndicatorView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 64)
        //                self.loadMoreActivityIndicatorView.startAnimating()
        //                return footer
        //
        //            default:
        //                return nil
        //            }
        //        }
        
        initViewModels()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCompare: Bool = false {
        didSet {
            //            collectionHorizontalView.isCompare = isCompare
        }
    }
    
    // MARK: Internal
    
    @MainActor
    private var isLoadingTickers: Bool = false {
        didSet {
            if isLoadingTickers {
                for cell in collectionView.visibleCells {
                    if let rightCell = cell as? CollectionCardCell {
                        rightCell.showAnimatedGradientSkeleton()
                    }
                    if let rightCell = cell as? CollectionListCardCell {
                        rightCell.showAnimatedGradientSkeleton()
                    }
                }
                collectionView.setContentOffset(collectionView.contentOffset, animated: false)
            } else {
                for cell in collectionView.visibleCells {
                    if let rightCell = cell as? CollectionCardCell {
                        rightCell.hideSkeleton()
                    }
                    if let rightCell = cell as? CollectionListCardCell {
                        rightCell.hideSkeleton()
                    }
                }
            }
        }
    }
    
    // MARK: Properties
    
    var model: CollectionCardViewCellModel?
    var cancellables = Set<AnyCancellable>()
    var collectionName: String? = nil
    
    var onCardPressed: ((RemoteTickerDetails) -> Void)?
    var onSortingPressed: (() -> Void)?
    var onAddStockPressed: (() -> Void)?
    var onSettingsPressed: (((RemoteTickerDetails)) -> Void)?
    var onNewCardsLoaded: ((([CollectionCardViewCellModel])) -> Void)?
    var onRefreshedCardsLoaded: ((([CollectionCardViewCellModel])) -> Void)?
    
    // TODO: Borysov - Remove this
    var shortCollection: RemoteShortCollectionDetails? = nil {
        didSet {
            if shortCollection != nil {

            }
        }
    }
    
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
        self.collectionName = collectionName
        self.stocksCount = Int(stocksAmount) ?? 0
        self.cards = cards
        sortSections()
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateWatchlist).sink { _ in
        } receiveValue: { notification in
            if Constants.CollectionDetails.watchlistCollectionID == collectionId {
                self.refreshData {
                    
                }
            }
        }.store(in: &cancellables)
    }
    private(set) var cards: [CollectionCardViewCellModel] = []
    
    private func loadMoreTickers() {
        
        if (self.collectionID == Constants.CollectionDetails.watchlistCollectionID) {
            return
        }
        if (self.isLoadingMoreTickers) {
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
                    self.addRemoteStocks(tickers) {
                        self.isLoadingMoreTickers = false
                    }
                }
            }
        }
    }
    
    func addRemoteStocks(_ stocks: [RemoteTickerDetails], _ completed: (() -> Void)? = nil) {
        
        runOnMain {
            let cardsDTO = stocks.compactMap({CollectionDetailsDTOMapper.mapTickerDetails($0)}).compactMap({CollectionDetailsViewModelMapper.map($0)})
            cards.append(contentsOf: cardsDTO)
            onNewCardsLoaded?(cardsDTO)
            completed?()
        }
    }
    
    func sortSections(_ completion: (() -> Void)? = nil) {
        runOnMain {
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(self.collectionID)
            self.cards = self.cards.sorted(by: { lhs, rhs in
                settings.sortingValue().sortFunc(isAsc: settings.ascending, lhs, rhs)
            })
            self.collectionView.reloadData()
            completion?()
        }
    }
    
    // MARK: Private
    
    private var isLoadingMoreTickers: Bool = false
    private var collectionView: UICollectionView!
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
    
    private func initViewModels() {}
    
    private func finishRefreshWithSorting(cards: [CollectionCardViewCellModel], _ completion: (() -> Void)? = nil) {
        runOnMain {
            
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(self.collectionID)
            self.cards = cards.sorted(by: { lhs, rhs in
                settings.sortingValue().sortFunc(isAsc: settings.ascending, lhs, rhs)
            })
            self.onRefreshedCardsLoaded?(self.cards)
        }
    }
    
    func refreshData(_ completion: (() -> Void)? = nil) {
        
        refreshControl.endRefreshing()
        if self.isLoadingTickers {
            completion?()
            return
        }
        
        self.isLoadingTickers = true
        
        if self.collectionID == -1 {
            CollectionsManager.shared.watchlistCollectionsLoading {[weak self] models in
                if let cards = models.first?.cards {
                    self?.finishRefreshWithSorting(cards: cards) {
                        completion?()
                    }
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
                    self.finishRefreshWithSorting(cards: cards) {
                        completion?()
                    }
                }
            }
        }
    }
    
    @objc func refresh(_ sender:AnyObject) {
        
        self.refreshData()
    }
}

// MARK: UICollectionViewDataSource

extension CollectionDetailsViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return 0
        }
        switch section {
        case .title:
            return 1
        case .gain:
            return 1
        case .chart:
            return 1
        case .about:
            return 1
        case .recommended:
            return 1
        case .cards:
            return self.cards.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return CollectionDetailsSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let section = CollectionDetailsSection.init(rawValue: indexPath.section) else {
            fatalError("invalid section in 'CollectionDetailsViewCell'")
        }
        
        switch section {
        case .title:
            let cell: CollectionDetailsTitleCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsTitleCell.cellIdentifier, for: indexPath) as! CollectionDetailsTitleCell

            cell.configureWith(companyName: self.collectionName ?? "")
            return cell
            
        case .gain:
            let cell: CollectionDetailsGainCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsGainCell.cellIdentifier, for: indexPath) as! CollectionDetailsGainCell
            cell.configureWith(tickersCount: self.stocksCount, todaysGain: " +25.05%")
            return cell
            
        case .chart:
            let cell: CollectionDetailsChartCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsChartCell.cellIdentifier, for: indexPath) as! CollectionDetailsChartCell
            return cell
            
        case .about:
            let cell: CollectionDetailsAboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsAboutCell.cellIdentifier, for: indexPath) as! CollectionDetailsAboutCell
            return cell
            
        case .recommended:
            let cell: CollectionDetailsRecommendedCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsRecommendedCell.cellIdentifier, for: indexPath) as!CollectionDetailsRecommendedCell
            return cell
            
        case .cards:
            let cell: CollectionCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCardCell.cellIdentifier, for: indexPath) as! CollectionCardCell
            guard indexPath.row < self.cards.count else {
                return cell
            }
            let model = self.cards[indexPath.row]
            cell.tag = collectionID
            cell.configureWith(
                companyName: model.tickerCompanyName,
                tickerSymbol: model.tickerSymbol,
                tickerPercentChange: model.priceChangeToday > 0.0 ? " +" + model.priceChangeToday.percentRaw : model.priceChangeToday.percentRaw,
                tickerPrice:  model.currentPrice > 0.0 ? model.currentPrice.cleanTwoDecimal: "0.00",
                matchScore: "\(model.matchScore)"
            )
            TickerLiveStorage.shared.clearAllExpiredLiveData()
            
            if model.tickerCompanyName.hasPrefix(Constants.CollectionDetails.demoNamePrefix) {
                cell.showAnimatedGradientSkeleton()
                return cell
            } else {
                let isLoading = self.isLoadingTickers
                if isLoading == false {
                    cell.hideSkeleton()
                }
            }
//            let recurLock = NSRecursiveLock()
//            //Loading tickers data!
//            recurLock.lock()
            if !self.isLoadingTickers {
                let dispatchGroup = DispatchGroup()
                var loadingItems: Int  = 0
                let hasSymbol = TickerLiveStorage.shared.haveSymbol(model.tickerSymbol)
                let isLoadingSymbol = self.loadingSymbolArray.contains(where: { item in
                    item == model.tickerSymbol
                })
                let needLoadSymbol = !hasSymbol && !isLoadingSymbol
                if needLoadSymbol {
                    loadingItems += 1
                    self.loadingSymbolArray.append(model.tickerSymbol)
                    self.isLoadingTickers = true
                    
                    dprint("Fetching dt started \(model.tickerSymbol)")
                    dispatchGroup.enter()
                    TickersLiveFetcher.shared.getSymbolsData(self.cards.dropFirst(indexPath.row).prefix(Constants.CollectionDetails.tickersPreloadCount).compactMap({$0.tickerSymbol}) ) {
                        self.loadingSymbolArray.removeAll(where: { item in
                            item == model.tickerSymbol
                        })
                        dispatchGroup.leave()
                        dprint("Fetching dt ended \(model.tickerSymbol)")
                    }
                }
                
                if loadingItems > 0 {
                    
                    dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                        
                        dprint("Fetching ended \(model.tickerSymbol)")
                        
                        
                        
                        self.collectionView.reloadData()
                        
                        cell.hideSkeleton()
                        self.isLoadingTickers = false
                        
                    })
                    
                    
                } else {
                    cell.hideSkeleton()
                }
            }
            
//            recurLock.unlock()
            
            return cell
        }
    }
}

// MARK: UICollectionViewDelegate

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

// MARK: UICollectionViewDelegateFlowLayout

extension CollectionDetailsViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        guard let section = CollectionDetailsSection.init(rawValue: indexPath.section) else {
            return CGSize.init(width: collectionView.frame.width, height: 0)
        }
        
        switch section {
        case .title:
            let width = collectionView.frame.width
            return CGSize.init(width: width, height: 74.0)
        case .gain:
            let width = collectionView.frame.width
            return CGSize.init(width: width, height: 72.0)
            
        case .chart:
            let width = collectionView.frame.width
            return CGSize.init(width: width, height: 240.0)
            
        case .about:
            let width = collectionView.frame.width
            let aboutTitleWithOffsets = 56.0
            let textLineHeight = 20.0
            
            // TODO: Make dynamic depends on text and state (expanded collapsed)
            let numberOfLines = 4.0
            //        let width = name?.sizeOfString(usingFont: UIFont.proDisplaySemibold(CGFloat(16.0))).width ?? 0.0
            let aboutTextSize = textLineHeight * numberOfLines
            
            let bottomOffset = 24.0
            let height = aboutTitleWithOffsets + aboutTextSize + bottomOffset
            return CGSize.init(width: width, height: height)
            
        case .recommended:
            let width = collectionView.frame.width
            let recommendedHeight = 152.0
            
            // TODO: Make dynamic depends on  tags for this company
            let tagsHeight = 112.0
            
            let height = recommendedHeight + tagsHeight
            return CGSize.init(width: width, height: height)
        
        case .cards:
            let size = collectionView.frame.width / 2 - 30
            return CGSize.init(width: size, height: size)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGFloat(0.0)
        }
        
        if section == .cards {
            return CGFloat(20.0)
        }
        
        return CGFloat(0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGFloat(0.0)
        }
        
        if section == .cards {
            return CGFloat(20.0)
        }
        
        return CGFloat(0.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return UIEdgeInsets.zero
        }
        
        if section == .cards {
            return UIEdgeInsets.init(top: 16.0, left: 20.0, bottom: 0.0, right: 20.0)
        }
        
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGSize.zero
        }
        
        if section == .cards {
            // TODO: Cards header
            return CGSize.init(width: collectionView.frame.size.width, height: 9.0)
        }
        
        return CGSize.zero
    }
}

extension CollectionDetailsViewCell: CollectionHorizontalViewDelegate {
    func stocksViewModeChanged(view: CollectionHorizontalView, isGrid: Bool) {

        //            //stocks_view_changed
        //            GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID" : self.collectionID, "view" : "grid", "ec" : "CollectionDetails"])
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
