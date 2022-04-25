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
    fileprivate var lastOffset: CGFloat = 0.0
    var cancellables = Set<AnyCancellable>()
    
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
    
    //Replace to inner model
    private var viewModel: CollectionDetailViewCellModel!
    
    private var loadingSymbolArray: Array<String> = Array()
    private var loadingMatchScoreArray: Array<String> = Array()
    
    func configureWith(viewModel: CollectionDetailViewCellModel
    ) {
        self.viewModel = viewModel
        self.cards = viewModel.cards
        sortSections()
        
        NotificationCenter.default.publisher(for: Notification.Name.didUpdateWatchlist).sink { _ in
        } receiveValue: { notification in
            if Constants.CollectionDetails.watchlistCollectionID == viewModel.id {
                self.refreshData {
                    
                }
            }
        }.store(in: &cancellables)
        if Constants.CollectionDetails.watchlistCollectionID != viewModel.id {
            guard !viewModel.isDataLoaded else {return}
            showGradientSkeleton()
            CollectionsManager.shared.populateTTFCard(uniqID: viewModel.uniqID) {[weak self] topCharts, pieData, tags in
                self?.updateCharts(topCharts)
                self?.viewModel.addTags(tags)
                self?.hideSkeleton()
                self?.viewModel.isDataLoaded = true
                self?.collectionView.reloadItems(at: [IndexPath.init(row: 0, section: CollectionDetailsSection.recommended.rawValue),
                                                      IndexPath.init(row: 0, section: CollectionDetailsSection.gain.rawValue)])
            }
        }
        // Load all data
        // hideSkeleton()
    }
    
    @MainActor
    fileprivate func updateCharts(_ topCharts: [[ChartNormalized]]) {
        
        viewModel.topChart.isLoading = false
        
        let mainChart = topCharts.first!
        let medianChart = topCharts.last!
        
        let (main, median) = normalizeCharts(mainChart, medianChart)
        
        let topChart = ChartData(points: main, period: .d1)
        let medianData = ChartData(points: median, period: .d1)
        
        //let topChart = ChartData(points: [15, 20,12,30])
        //let medianData = ChartData(points: [15, 20,12,30].shuffled())
        
        viewModel.topChart.chartData = topChart
        viewModel.topChart.sypChartData = medianData
        viewModel.topChart.spGrow = Float(medianData.startEndDiff)
    }
    
    
    private(set) var cards: [CollectionCardViewCellModel] = []
    
    private func loadMoreTickers() {
        
        if (viewModel?.id == Constants.CollectionDetails.watchlistCollectionID) {
            return
        }
        if (self.isLoadingMoreTickers) {
            return
        }
        
        self.isLoadingMoreTickers = true
        
        DispatchQueue.global(qos:.utility).async {
            CollectionsManager.shared.loadMoreTickersLoading(collectionID: self.viewModel.id, offset: self.cards.count) { tickerDetails in
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
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel.id)
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
            
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
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
        
        if viewModel?.id == -1 {
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
            CollectionsManager.shared.loadNewCollectionDetails(self.viewModel.id) { remoteTickers in
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
    
    //MARK: - Chart
    private let chartHeight: CGFloat = 256
    private lazy var chartHosting: CustomHostingController<TTFScatterChartView> = {
        var rootView = TTFScatterChartView(viewModel: viewModel.topChart,
                                           delegate: chartDelegate)
        let chartHosting = CustomHostingController(shouldShowNavigationBar: false, rootView: rootView)
        chartHosting.view.tag = TickerDetailsDataSource.hostingTag
        return chartHosting
    }()
    
    private lazy var chartDelegate: TTFScatterChartDelegate = {
        let delegateObject =  TTFScatterChartDelegate()
        delegateObject.delegate = self
        return delegateObject
    }()
    
    func loadChartForRange(_ range: ScatterChartView.ChartPeriod) {
        viewModel.chartRange = range
        viewModel.topChart.isLoading = true
        Task {
            let topCharts = await CollectionsManager.shared.loadChartsForRange(uniqID: viewModel.uniqID,  range: range)
            updateCharts(topCharts)
        }
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
            
            cell.configureWith(companyName: viewModel.name)
            return cell
            
        case .gain:
            let cell: CollectionDetailsGainCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsGainCell.cellIdentifier, for: indexPath) as! CollectionDetailsGainCell
            if viewModel.id == Constants.CollectionDetails.watchlistCollectionID {
                cell.configureAsWatchlist(tickersCount: viewModel.stocksAmount)
            } else {
                cell.configureWith(tickersCount: viewModel.stocksAmount, viewModel: viewModel)
            }
            cell.delegate = self
            return cell
            
        case .chart:
            let cell: CollectionDetailsChartCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsChartCell.cellIdentifier, for: indexPath) as! CollectionDetailsChartCell
            if cell.addSwiftUIIfPossible(chartHosting.view) {
                chartHosting.view.autoSetDimension(.height, toSize: chartHeight)
                chartHosting.view.autoPinEdge(.leading, to: .leading, of: cell.contentView)
                chartHosting.view.autoPinEdge(.bottom, to: .bottom, of: cell.contentView, withOffset: 0)
                chartHosting.view.autoPinEdge(.trailing, to: .trailing, of: cell.contentView)
            }
            chartHosting.view.clipsToBounds = false
            return cell
            
        case .about:
            let cell: CollectionDetailsAboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsAboutCell.cellIdentifier, for: indexPath) as! CollectionDetailsAboutCell
            cell.configureWith(detail: viewModel.description)
            return cell
            
        case .recommended:
            let cell: CollectionDetailsRecommendedCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsRecommendedCell.cellIdentifier, for: indexPath) as!CollectionDetailsRecommendedCell
            cell.configureWith(matchData: viewModel.matchScore, tags: viewModel.combinedTags)
            
            
            NotificationCenter.default.publisher(for: NotificationManager.tickerScrollNotification).sink { _ in
            } receiveValue: { notif in
                if let transform = notif.userInfo?["transform"] as? CGAffineTransform {
                    cell.setTransform(transform)
                }
            }.store(in: &cancellables)
            return cell
            
        case .cards:
            let cell: CollectionCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCardCell.cellIdentifier, for: indexPath) as! CollectionCardCell
            guard indexPath.row < self.cards.count else {
                return cell
            }
            let model = self.cards[indexPath.row]
            cell.tag = viewModel.id
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
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionDetailsHeaderView.reuseIdentifier, for: indexPath) as! CollectionDetailsHeaderView
            result = headerView
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionDetailsFooterView", for: indexPath)
            footer.addSubview(self.loadMoreActivityIndicatorView)
            self.loadMoreActivityIndicatorView.frame = CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 64)
            self.loadMoreActivityIndicatorView.startAnimating()
            return footer
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
}

// MARK: UICollectionViewDelegate

extension CollectionDetailsViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section == CollectionDetailsSection.cards.rawValue else {return}
        GainyAnalytics.logEvent("ticker_pressed", params: ["collectionID": viewModel.id,
                                                           "tickerSymbol" : cards[indexPath.row].rawTicker.symbol,
                                                           "tickerName" : cards[indexPath.row].rawTicker.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
        onCardPressed?(cards[indexPath.row].rawTicker)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        
        guard UICollectionView.elementKindSectionFooter == elementKind else { return }
        if viewModel.stocksAmount == self.cards.count || viewModel.id == -1 {
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
            guard (viewModel.id != Constants.CollectionDetails.watchlistCollectionID) else {return .zero}
            let width = collectionView.frame.width
            return CGSize.init(width: width, height: 72.0)
            
        case .chart:
            guard (viewModel.id != Constants.CollectionDetails.watchlistCollectionID) else {return .zero}
            let width = collectionView.frame.width
            return CGSize.init(width: width, height: chartHeight)
            
        case .about:
            guard (viewModel.id != Constants.CollectionDetails.watchlistCollectionID) else {return .zero}
            guard viewModel.id != Constants.CollectionDetails.watchlistCollectionID else {
                return .zero
            }
            let width = collectionView.frame.width
            let aboutTitleWithOffsets = 32.0
            let bottomOffset = 24.0
            let height = aboutTitleWithOffsets + viewModel.description.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 24.0 * 2.0, font: .proDisplayRegular(14.0)) + bottomOffset
            return CGSize.init(width: collectionView.frame.width, height: height)
            
        case .recommended:
            guard (viewModel.id != Constants.CollectionDetails.watchlistCollectionID) else {return .zero}
            let width = collectionView.frame.width
            
            //Tags
            var lines: Int = 0
            let tagHeight: CGFloat = 24.0
            let margin: CGFloat = 8.0
            
            let totalWidth: CGFloat = UIScreen.main.bounds.width - 34 * 2.0
            var xPos: CGFloat = 0.0
            var yPos: CGFloat = 0.0
            for tag in viewModel.combinedTags {
                if xPos + width + margin > totalWidth{
                    xPos = 0.0
                    yPos = yPos + tagHeight + margin
                    lines += 1
                }
                xPos += width + margin
            }
            
            let calculatedHeight: CGFloat = 192 + tagHeight * CGFloat(lines) + margin * CGFloat(lines - 1)
            
            return CGSize.init(width: width, height: calculatedHeight)
            
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
            return CGSize.init(width: collectionView.frame.width, height: CGFloat(CollectionDetailsHeaderViewState.heightForState(state: .grid)))
        }
        
        return CGSize.zero
    }
}

extension CollectionDetailsViewCell: CollectionHorizontalViewDelegate {
    func stocksViewModeChanged(view: CollectionHorizontalView, isGrid: Bool) {
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

extension CollectionDetailsViewCell: TTFScatterChartViewDelegate {
    func chartPeriodChanged(period: ScatterChartView.ChartPeriod, viewModel: TTFChartViewModel) {
        self.loadChartForRange(period)
    }
}


extension CollectionDetailsViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let topOffset = scrollView.contentOffset.y
        if abs(lastOffset - topOffset) > 10 {
            lastOffset = topOffset
            let angle = -(topOffset * 0.5) * 2 * CGFloat(Double.pi / 180)
            NotificationCenter.default.post(name: NotificationManager.tickerScrollNotification, object: nil, userInfo: ["transform" : CGAffineTransform(rotationAngle: angle)])
        }
    }
}

extension CollectionDetailsViewCell: CollectionDetailsGainCellDelegate {
    func medianToggled(cell: CollectionDetailsGainCell, showMedian: Bool) {
        guard let viewModel = viewModel else {return}
        viewModel.topChart.isSPPVisible = showMedian
        
        GainyAnalytics.logEvent("portfolio_chart_period_spp_pressed", params: [ "period" : viewModel.chartRange.rawValue, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
    }
}
