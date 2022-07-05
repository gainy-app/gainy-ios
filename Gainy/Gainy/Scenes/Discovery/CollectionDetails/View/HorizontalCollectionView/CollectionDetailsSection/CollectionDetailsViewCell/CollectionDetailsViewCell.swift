import UIKit
import SkeletonView
import Combine
import PureLayout
import Deviice
import OneSignal
import FirebaseAuth

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
        collectionView = DetectableCollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(refreshControl)
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(CollectionDetailsTitleCell.self)
        collectionView.register(CollectionDetailsGainCell.self)
        collectionView.register(CollectionDetailsChartCell.self)
        collectionView.register(CollectionDetailsAboutCell.self)
        collectionView.register(CollectionDetailsRecommendedCell.self)
        
        collectionView.register(CollectionCardCell.self)
        collectionView.register(CollectionListCardCell.self)
        collectionView.register(CollectionChartCardCell.self)
        
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
        collectionView.contentInset = .init(top: 0, left: 0, bottom: 65, right: 0)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.clipsToBounds = false
        contentView.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        collectionView.isSkeletonable = true
        collectionView.skeletonCornerRadius = 6.0
        initViewModels()
        
        if RemoteConfigManager.shared.isInvestBtnVisible {
            contentView.addSubview(collectionInvestButtonView)
            collectionInvestButtonView.autoPinEdge(toSuperviewEdge: .bottom)
            self.investButtonHeightLayoutConstraint = collectionInvestButtonView.autoSetDimension(.height, toSize: 96.0)
            collectionInvestButtonView.autoPinEdge(toSuperviewEdge: .left)
            collectionInvestButtonView.autoPinEdge(toSuperviewEdge: .right)
            
            collectionInvestButtonView.investButtonPressed = {
                
                GainyAnalytics.logEvent("invest_pressed", params: ["user_id" : Auth.auth().currentUser?.uid ?? "anonymous", "collection_id" : self.viewModel.id])
                self.investButtonPressed?()
            }
            
//            let blurView = BlurEffectView()
//            contentView.addSubview(blurView)
//
//            let blurWhiteView = UIView()
//            blurWhiteView.backgroundColor = .white.withAlphaComponent(0.3)
//            contentView.addSubview(blurWhiteView)
//
//            blurView.autoPinEdge(toSuperviewEdge: .leading)
//            blurView.autoPinEdge(toSuperviewEdge: .bottom)
//            blurView.autoPinEdge(toSuperviewEdge: .trailing)
//            blurView.autoMatch(.height, to: .height, of: collectionInvestButtonView)
//
//            blurWhiteView.autoPinEdge(toSuperviewEdge: .leading)
//            blurWhiteView.autoPinEdge(toSuperviewEdge: .bottom)
//            blurWhiteView.autoPinEdge(toSuperviewEdge: .trailing)
//            blurWhiteView.autoMatch(.height, to: .height, of: collectionInvestButtonView)
            
            //contentView.bringSubviewToFront(blurView)
            //contentView.bringSubviewToFront(blurWhiteView)
            contentView.bringSubviewToFront(collectionInvestButtonView)
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCompare: Bool = false {
        didSet {
            //collectionHorizontalView.isCompare = isCompare
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: Internal
    
    private var refreshingTickers: Bool = false
    private var headerView: CollectionDetailsHeaderView? = nil
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
    var investButtonHeightLayoutConstraint: NSLayoutConstraint? = nil
    
    var onCardPressed: ((RemoteTickerDetails) -> Void)?
    var onSortingPressed: (() -> Void)?
    var onAddStockPressed: (() -> Void)?
    var onSettingsPressed: (((RemoteTickerDetails)) -> Void)?
    var onNewCardsLoaded: ((([CollectionCardViewCellModel])) -> Void)?
    var onRefreshedCardsLoaded: ((([CollectionCardViewCellModel])) -> Void)?
    var onPurhaseShow: (() -> Void)?
    var investButtonPressed: (() -> Void)?
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
        
        collectionInvestButtonView.configureWith(name: viewModel.name, imageName: viewModel.image, imageUrl: viewModel.imageUrl, collectionId: viewModel.id)
        
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
            guard !Constants.CollectionDetails.loadingCellIDs.contains(viewModel.id) else {return}
            CollectionsManager.shared.populateTTFCard(uniqID: viewModel.uniqID) {[weak self] uniqID, topCharts, pieData, tags in
                if uniqID == self?.viewModel.uniqID {
                    self?.pieChartData = pieData
                    self?.updateCharts(topCharts)
                    self?.viewModel.addTags(tags)
                    self?.hideSkeleton()
                    self?.viewModel.isDataLoaded = true
                    self?.collectionView.reloadData()
                }
            }
        }
        // Load all data
        // hideSkeleton()
    }
    
    @MainActor
    fileprivate func updateCharts(_ topCharts: [[ChartNormalized]]) {
        topChart.isLoading = false
        
        let mainChart = topCharts.first!
        let medianChart = topCharts.last!
        
        let (main, median) = normalizeCharts(mainChart, medianChart)
        
        let topChartData = ChartData(points: main, period: viewModel.chartRange)
        var medianData: ChartData!
        if let firstMedian: Float = median.first?.val, let firstMain: Float = main.first?.val {
            var pcts: [Float] = []
            for val in median.compactMap({$0.val}) {
                let cur = val / firstMedian
                pcts.append(firstMain * cur)
            }
            medianData = ChartData(points: pcts)
        } else {
            medianData = ChartData(points: median, period: viewModel.chartRange)
        }
        //let medianData = ChartData(points: median, period: viewModel.chartRange)
        
        //let topChart = ChartData(points: [15, 20,12,30])
        //let medianData = ChartData(points: [15, 20,12,30].shuffled())
        //print("\(topChartData.onlyPoints().min()) \(topChartData.onlyPoints().max())")
        //print("\(medianData.onlyPoints().min()) \(medianData.onlyPoints().max())")
        
        topChart.min = Double(min(medianData.onlyPoints().min() ?? 0.0, topChartData.onlyPoints().min() ?? 0.0))
        topChart.max = Double(max(medianData.onlyPoints().max() ?? 0.0, topChartData.onlyPoints().max() ?? 0.0))
        if medianData.onlyPoints().isEmpty {
            topChart.min = topChartData.onlyPoints().min() ?? 0.0
            topChart.max = topChartData.onlyPoints().max() ?? 0.0
        }
        topChart.lastDayPrice = viewModel.lastDayPrice
        
        if viewModel.lastDayPrice != 0.0 && viewModel.chartRange == .d1 {
            topChart.min = min(Double(topChart.min ?? 0.0), Double(viewModel.lastDayPrice))
            topChart.max = max(Double(topChart.max ?? 0.0), Double(viewModel.lastDayPrice))
        }
        topChart.dayGrow = viewModel.dailyGrow
        topChart.chartData = topChartData
        topChart.sypChartData = medianData
        topChart.spGrow = Float(medianData.startEndDiff)
    }
    
    
    private(set) var cards: [CollectionCardViewCellModel] = []
    private var pieChartData: [GetTtfPieChartQuery.Data.CollectionPiechart] = []
    
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
            self.collectionView.reloadData()
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
    private(set) var collectionView: DetectableCollectionView!
    private lazy var refreshControl: LottieRefreshControl = {
        let control = LottieRefreshControl()
        control.layer.zPosition = -1
        control.clipsToBounds = true
        control.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        return control
    } ()
    weak private var blockHeader: TTFBlockView? {
        didSet {
            if let blockHeader = blockHeader {
                collectionView.headerView = blockHeader
            }
        }
    }
    
    lazy var collectionInvestButtonView: CollectionInvestButtonView = {
        let view = CollectionInvestButtonView()
        view.backgroundColor = .clear
        view.investButtonPressed = {
            
        }
        return view
    }()
    
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
            let indesSet = IndexSet.init(integer: CollectionDetailsSection.cards.rawValue)
            self.collectionView.reloadSections(indesSet)
            self.headerView?.updateChargeLbl(settings.sortingText())
        }
    }
    
    func refreshData(_ completion: (() -> Void)? = nil) {
        
        //        refreshControl.endRefreshing()
        //        if self.refreshingTickers {
        //            completion?()
        //            return
        //        }
        
        //        self.refreshingTickers = true
        
        if viewModel?.id == -1 {
            CollectionsManager.shared.watchlistCollectionsLoading {[weak self] models in
                if let cards = models.first?.cards {
                    self?.finishRefreshWithSorting(cards: cards) {
                        //                        self?.refreshingTickers = false
                        self?.refreshControl.endRefreshing()
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
                    self.refreshControl.endRefreshing()
                    self.finishRefreshWithSorting(cards: cards) {
                        //                        self.refreshingTickers = false
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
    private let chartHeight: CGFloat = 256 + 90.0
    private var topChart: TTFChartViewModel = TTFChartViewModel.init(spGrow: 0.0, dayGrow: 0.0, chartData: .init(points: [0.0]), sypChartData: .init(points: [15, 20, 25, 10]), isSPPVisible: false)
    private lazy var chartHosting: CustomHostingController<TTFScatterChartView> = {
        var rootView = TTFScatterChartView(viewModel: topChart,
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
        
//        if let gainsCell = collectionView.cellForItem(at: .init(row: 0, section: CollectionDetailsSection.gain.rawValue)) as? CollectionDetailsGainCell {
//            gainsCell.isMedianVisible = false
//        }
        
        viewModel.chartRange = range
        //topChart.isSPPVisible = false
        topChart.isLoading = true
        Task {
            let topCharts = await CollectionsManager.shared.loadChartsForRange(uniqID: viewModel.uniqID,  range: range)
            updateCharts(topCharts)
            await MainActor.run {
                let indesSet = IndexSet.init(integer: CollectionDetailsSection.gain.rawValue)
                self.collectionView.reloadSections(indesSet)
            }
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
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            if settings.pieChartSelected {
                switch settings.pieChartMode {
                case .tickers:
                    return self.pieChartData.filter { item in
                        item.entityType == "ticker"
                    }.count
                case .categories:
                    return self.pieChartData.filter { item in
                        item.entityType == "category"
                    }.count
                case .interests:
                    return self.pieChartData.filter { item in
                        item.entityType == "interest"
                    }.count
                }
            } else {
                return self.cards.count
            }
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
            cell.isSkeletonable = collectionView.isSkeletonable
            if collectionView.sk.isSkeletonActive {
                cell.showAnimatedGradientSkeleton()
            } else {
                cell.hideSkeleton()
            }
            return cell
            
        case .gain:
            let cell: CollectionDetailsGainCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsGainCell.cellIdentifier, for: indexPath) as! CollectionDetailsGainCell
            if viewModel.id == Constants.CollectionDetails.watchlistCollectionID {
                cell.configureAsWatchlist(tickersCount: viewModel.stocksAmount)
            } else {
                cell.configureWith(tickersCount: viewModel.stocksAmount, viewModel: viewModel, topChart: topChart)
                cell.isMedianVisible = topChart.isSPPVisible
            }
            cell.delegate = self
            cell.isSkeletonable = collectionView.isSkeletonable
            if collectionView.sk.isSkeletonActive {
                cell.showAnimatedGradientSkeleton()
            } else {
                cell.hideSkeleton()
            }
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
            chartHosting.view.fillRemoteBack()
            cell.isSkeletonable = collectionView.isSkeletonable
            if collectionView.sk.isSkeletonActive {
                cell.showAnimatedGradientSkeleton()
            } else {
                cell.hideSkeleton()
            }
            return cell
            
        case .about:
            let cell: CollectionDetailsAboutCell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionDetailsAboutCell.cellIdentifier, for: indexPath) as! CollectionDetailsAboutCell
            cell.configureWith(detail: viewModel.description)
            cell.isSkeletonable = collectionView.isSkeletonable
            if collectionView.sk.isSkeletonActive {
                cell.showAnimatedGradientSkeleton()
            } else {
                cell.hideSkeleton()
            }
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
            cell.isSkeletonable = collectionView.isSkeletonable
            if collectionView.sk.isSkeletonActive {
                cell.showAnimatedGradientSkeleton()
            } else {
                cell.hideSkeleton()
                SubscriptionManager.shared.getSubscription({[weak self] type in
                    if type == .free {
                        if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                            cell.removeBlur()
                        } else {
                            cell.addBlur()
                        }
                    } else {
                        cell.removeBlur()
                    }
                })
            }
            cell.clipsToBounds = false
            cell.contentView.clipsToBounds = false
            return cell
            
        case .cards:
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            if settings.pieChartSelected {
                return self.chartCardCellForItemAtIndexPath(indexPath: indexPath)
            } else {
                if settings.viewMode == .grid {
                    return self.gridCellForItemAtIndexPath(indexPath: indexPath)
                } else {
                    return self.listCellForItemAtIndexPath(indexPath: indexPath)
                }
            }
        }
    }
    
    func chartCardCellForItemAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionChartCardCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionChartCardCell.cellIdentifier, for: indexPath) as! CollectionChartCardCell
        let chartData = self.currentChartData()
        guard indexPath.row < chartData.count else {
            return cell
        }
        
        cell.configureWithChartData(data: chartData[indexPath.row], index: indexPath.row)
        
        SubscriptionManager.shared.getSubscription({[weak self] type in
            if type == .free {
                if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                    cell.removeBlur()
                } else {
                    cell.addBlur()
                }
            } else {
                cell.removeBlur()
            }
        })
        return cell
    }
    
    func listCellForItemAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionListCardCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionListCardCell.cellIdentifier, for: indexPath) as! CollectionListCardCell
        guard indexPath.row < self.cards.count else {
            return cell
        }
        let model = self.cards[indexPath.row]
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
        let markers = settings.marketDataToShow.prefix(4)
        var vals: [String] = []
        for marker in markers {
            switch marker {
            case .matchScore:
                vals.append("\(model.matchScore)")
            case .sharesOutstanding:
                vals.append(model.sharesOutstanding)
            case .shortPercentOutstanding:
                vals.append(model.shortPercentOutstanding)
            case .avgVolume90d:
                vals.append(model.avgVolume90d)
            case .sharesFloat:
                vals.append(model.sharesFloat)
            case .shortRatio:
                vals.append(model.shortRatio)
            case .beta:
                vals.append(model.beta)
            case .impliedVolatility:
                vals.append(model.impliedVolatility)
            case .revenueGrowthFwd:
                vals.append(model.revenueGrowthFwd)
            case .ebitdaGrowthYoy:
                vals.append(model.ebitdaGrowthYoy)
            case .epsGrowthYoy:
                vals.append(model.epsGrowthYoy)
            case .epsGrowthFwd:
                vals.append(model.epsGrowthFwd)
            case .address:
                vals.append(model.address)
            case .marketCapitalization:
                vals.append(model.marketCapitalization)
            case .enterpriseValueToSales:
                vals.append(model.enterpriseValueToSales)
            case .priceToEarningsTtm:
                vals.append(model.priceToEarningsTtm)
            case .priceToSalesTtm:
                vals.append(model.priceToSalesTtm)
            case .priceToBookValue:
                vals.append(model.priceToBookValue)
            case .enterpriseValueToEbitda:
                vals.append(model.enterpriseValueToEbitda)
            case .priceChange1m:
                vals.append(model.priceChange1m)
            case .priceChange3m:
                vals.append(model.priceChange3m)
            case .priceChange1y:
                vals.append(model.priceChange1y)
            case .dividendYield:
                vals.append(model.dividendYield)
            case .dividendsPerShare:
                vals.append(model.dividendsPerShare)
            case .dividendPayoutRatio:
                vals.append(model.dividendPayoutRatio)
            case .yearsOfConsecutiveDividendGrowth:
                vals.append(model.yearsOfConsecutiveDividendGrowth)
            case .dividendFrequency:
                vals.append(model.dividendFrequency)
            case .epsActual:
                vals.append(model.epsActual)
            case .epsEstimate:
                vals.append(model.epsEstimate)
            case .beatenQuarterlyEpsEstimationCountTtm:
                vals.append(model.beatenQuarterlyEpsEstimationCountTtm)
            case .epsSurprise:
                vals.append(model.epsSurprise)
            case .revenueEstimateAvg0y:
                vals.append(model.revenueEstimateAvg0y)
            case .revenueActual:
                vals.append(model.revenueActual)
            case .revenueTtm:
                vals.append(model.revenueTtm)
            case .revenuePerShareTtm:
                vals.append(model.revenuePerShareTtm)
            case .roi:
                vals.append(model.roi)
            case .netIncome:
                vals.append(model.netIncome)
            case .assetCashAndEquivalents:
                vals.append(model.assetCashAndEquivalents)
            case .roa:
                vals.append(model.roa)
            case .totalAssets:
                vals.append(model.totalAssets)
            case .ebitda:
                vals.append(model.ebitda)
            case .profitMargin:
                vals.append(model.profitMargin)
            case .netDebt:
                vals.append(model.netDebt)
            case .avgVolume10d:
                vals.append(model.avgVolume10d)
            case .revenueGrowthYoy:
                vals.append(model.revenueGrowthYoy)
            case .exchangeName:
                vals.append(model.exchangeName)
            }
        }
        
        cell.configureWith(companyName: model.tickerCompanyName,
                           tickerSymbol: model.tickerSymbol,
                           tickerPercentChange: model.priceChangeToday > 0.0 ? " +" + model.priceChangeToday.percentRaw : model.priceChangeToday.percentRaw,
                           tickerPrice: model.currentPrice > 0.0 ? model.currentPrice.cleanTwoDecimal: "0.00",
                           markerHeaders:  markers.map(\.shortTitle),
                           markerMetrics: vals,
                           matchScore: "\(model.matchScore)")
        SubscriptionManager.shared.getSubscription({[weak self] type in
            if type == .free {
                if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                    cell.removeBlur()
                } else {
                    cell.addBlur()
                }
            } else {
                cell.removeBlur()
            }
        })
        return cell
    }
    
    func gridCellForItemAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CollectionCardCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCardCell.cellIdentifier, for: indexPath) as! CollectionCardCell
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
        
        //Loading tickers data!
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
        SubscriptionManager.shared.getSubscription({[weak self] type in
            if type == .free {
                if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                    cell.removeBlur()
                    cell.layer.shadowOpacity = 1.0
                } else {
                    cell.addBlur(top: -8, bottom: -8, left: indexPath.row % 2 == 0 ? -20 : -10, right: indexPath.row % 2 != 0 ? -20 : -10)
                    cell.layer.shadowOpacity = 0.0
                }
            } else {
                cell.removeBlur()
                cell.layer.shadowOpacity = 1.0
            }
        })
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionDetailsHeaderView.reuseIdentifier, for: indexPath) as! CollectionDetailsHeaderView
            
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            var state = CollectionDetailsHeaderViewState.grid
            if settings.pieChartSelected {
                SubscriptionManager.shared.getSubscription({[weak self] type in
                    if type == .free {
                        if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                            state = CollectionDetailsHeaderViewState.chart
                        } else {
                            state = CollectionDetailsHeaderViewState.list
                        }
                    } else {
                        state = CollectionDetailsHeaderViewState.chart
                    }
                })
            } else {
                if settings.viewMode == .grid {
                    state = CollectionDetailsHeaderViewState.grid
                } else {
                    state = CollectionDetailsHeaderViewState.list
                }
            }
            
            headerView.configureWithPieChartData(pieChartData: self.currentChartData(), mode: settings.pieChartMode)
            headerView.configureWithState(state: state)
            headerView.updateChargeLbl(settings.sortingText())
            headerView.updateMetrics(settings.marketDataToShow)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                headerView.setNeedsLayout()
                headerView.layoutIfNeeded()
            })
            
            headerView.onSettingsPressed = {
                guard self.cards.count > 0 else {
                    return
                }
                self.onSettingsPressed?(self.cards[0].rawTicker)
                GainyAnalytics.logEvent("settings_pressed", params: ["collectionID" : self.viewModel?.id ?? -1])
            }
            
            headerView.onSortingPressed = {
                self.onSortingPressed?()
            }
            
            headerView.onChartModeButtonPressed = { showChart in
                GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID" : self.viewModel?.id ?? -1, "view" : "chart"])
                CollectionsDetailsSettingsManager.shared.changePieChartSelectedForId(self.viewModel?.id ?? -1, pieChartSelected: showChart)
                self.collectionView.reloadData()
            }
            
            headerView.onTableListModeButtonPressed = { showList in
                GainyAnalytics.logEvent("stocks_view_changed", params: ["collectionID" : self.viewModel?.id ?? -1, "view" : showList ? "list" : "grid"])
                let viewMode = showList ? CollectionSettings.ViewMode.list : .grid
                CollectionsDetailsSettingsManager.shared.changeViewModeForId(self.viewModel?.id ?? -1, viewMode: viewMode)
                self.collectionView.reloadData()
            }
            
            headerView.onChartTickerButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(self.viewModel?.id ?? -1, pieChartMode: .tickers)
                self.collectionView.reloadData()
            }
            
            headerView.onChartCategoryButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(self.viewModel?.id ?? -1, pieChartMode: .categories)
                self.collectionView.reloadData()
            }
            
            headerView.onChartInterestButtonPressed = {
                CollectionsDetailsSettingsManager.shared.changePieChartModeForId(self.viewModel?.id ?? -1, pieChartMode: .interests)
                self.collectionView.reloadData()
            }
            
            self.headerView = headerView
            SubscriptionManager.shared.getSubscription({[weak self] type in
                if type == .free {
                    if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                        headerView.removeBlur()
                        headerView.removeBlockView()
                    } else {
                        headerView.addBlur(top: 0)
                        self?.blockHeader = headerView.addBlockView(delegate: self)
                    }
                } else {
                    headerView.removeBlur()
                    headerView.removeBlockView()
                }
            })
            headerView.clipsToBounds = false
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
    
    func currentChartData() -> [GetTtfPieChartQuery.Data.CollectionPiechart] {
        
        let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
        var chartData: [GetTtfPieChartQuery.Data.CollectionPiechart] = []
        if settings.pieChartSelected {
            if settings.pieChartMode == .categories {
                chartData = self.pieChartData.filter { data in
                    data.entityType == "category"
                }
            } else if settings.pieChartMode == .interests {
                chartData = self.pieChartData.filter { data in
                    data.entityType == "interest"
                }
            } else if settings.pieChartMode == .tickers {
                chartData = self.pieChartData.filter { data in
                    data.entityType == "ticker"
                }
            }
        }
        
        chartData = chartData.sorted(by: { itemLeft, itemRight in
            itemLeft.weight ?? 0.0 > itemRight.weight ?? 0.0
        })
        
        return chartData
    }
}

// MARK: UICollectionViewDelegate

extension CollectionDetailsViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SubscriptionManager.shared.getSubscription({[weak self] type in
            if type == .free {
                if SubscriptionManager.shared.storage.isViewedCollection(self?.viewModel.id ?? 0) {
                    cardTapLogic()
                }
            } else {
                cardTapLogic()
            }
        })
        
        func cardTapLogic() {
            guard indexPath.section == CollectionDetailsSection.cards.rawValue else {return}
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            
            var cardToOpen: RemoteTickerDetails? = nil
            if settings.pieChartSelected {
                if settings.pieChartMode != .tickers {
                    return
                }
                
                let chartData = self.currentChartData()
                if indexPath.row >= chartData.count {return}
                let data = chartData[indexPath.row]
                
                cardToOpen = cards.first { card in
                    guard let entityId = data.entityId else { return false }
                    return entityId == card.tickerSymbol
                }?.rawTicker
                
            } else {
                cardToOpen = cards[indexPath.row].rawTicker
            }
            
            guard let card = cardToOpen else { return }
            GainyAnalytics.logEvent("ticker_pressed", params: ["collectionID": viewModel.id,
                                                               "tickerSymbol" : card.symbol,
                                                               "tickerName" : card.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "CollectionDetails"])
            onCardPressed?(card)
        }
        
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
            let headerHeight = viewModel.name.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 24.0 - 71, font: UIFont(name: "SFProDisplay-Bold", size: 32)!)
            guard collectionView.tag != Constants.CollectionDetails.singleCollectionId else {
                let height = (60.0 - 28) + headerHeight
                return CGSize.init(width: width, height: height)
            }
            
            return CGSize.init(width: width, height: 154.0 + 24.0 + headerHeight + 32.0)
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
            
            let aboutTitleWithOffsets = 32.0
            let bottomOffset = 24.0 - 16.0
            let height = aboutTitleWithOffsets + viewModel.description.heightWithConstrainedWidth(width: UIScreen.main.bounds.width - 24.0 * 2.0, font: .proDisplayRegular(14.0)) + bottomOffset
            return CGSize.init(width: collectionView.frame.width, height: height)
            
        case .recommended:
            guard (viewModel.id != Constants.CollectionDetails.watchlistCollectionID) else {return .zero}
            let width = collectionView.frame.width
            
            //Tags
            var lines: Int = 1
            let tagHeight: CGFloat = 24.0
            let margin: CGFloat = 8.0
            
            let totalWidth: CGFloat = UIScreen.main.bounds.width - 32 * 2.0
            var xPos: CGFloat = 0.0
            var yPos: CGFloat = 0.0
            for (ind, tag) in viewModel.combinedTags.enumerated() {
                let width = (tag.url.isEmpty ? 8.0 : 26.0) + tag.name.uppercased().widthOfString(usingFont: UIFont.compactRoundedSemibold(12)) + margin
                if xPos + width + margin > totalWidth && ind != 0 {
                    xPos = 0.0
                    yPos = yPos + tagHeight + margin
                    lines += 1
                }
                xPos += width + margin
            }
            
            if viewModel.combinedTags.isEmpty {
                return CGSize.init(width: width, height: 144.0 + 32 + 32)
            } else {
                let calculatedHeight: CGFloat = (208.0 - 8.0) + tagHeight * CGFloat(max(1, lines)) +  margin * CGFloat(max(1, lines) - 1) + 8.0
                return CGSize.init(width: width, height: calculatedHeight)
            }
            
        case .cards:
            
            var width = 0.0
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            if settings.pieChartSelected {
                let height = settings.pieChartMode == .tickers ? 88.0 : 56.0
                width = collectionView.frame.width - 30
                return CGSize.init(width: width, height: height)
            } else {
                if settings.viewMode == .grid {
                    width = (UIScreen.main.bounds.width - 20.0 * 3.0) / 2.0
                    return CGSize.init(width: width, height: width)
                } else {
                    width = collectionView.frame.width - 30
                    return CGSize.init(width: width, height: 88.0)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGFloat(0.0)
        }
        
        if section == .cards {
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            if settings.pieChartSelected {
                return CGFloat(8.0)
            } else {
                if settings.viewMode == .grid {
                    return CGFloat(16.0)
                } else {
                    return CGFloat(8.0)
                }
            }
        }
        
        return CGFloat(0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGFloat(0.0)
        }
        
        if section == .cards {
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            if settings.pieChartSelected {
                return CGFloat(8.0)
            } else {
                if settings.viewMode == .grid {
                    return CGFloat(16.0)
                } else {
                    return CGFloat(8.0)
                }
            }
        }
        
        return CGFloat(0.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return UIEdgeInsets.zero
        }
        
        if section == .cards {
            return UIEdgeInsets.init(top: 8.0, left: 20.0, bottom: 0.0, right: 20.0)
        }
        
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGSize.zero
        }
        
        if section == .cards {
            
            var state = CollectionDetailsHeaderViewState.grid
            let settings = CollectionsDetailsSettingsManager.shared.getSettingByID(viewModel?.id ?? -1)
            if settings.pieChartSelected {
                state = CollectionDetailsHeaderViewState.chart
            } else {
                if settings.viewMode == .grid {
                    state = CollectionDetailsHeaderViewState.grid
                } else {
                    state = CollectionDetailsHeaderViewState.list
                }
            }
            
            return CGSize.init(width: collectionView.frame.width, height: CGFloat(CollectionDetailsHeaderViewState.heightForState(state: state)))
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard let section = CollectionDetailsSection.init(rawValue: section) else {
            return CGSize.zero
        }
        
        if section == .cards {
            return CGSize.init(width: collectionView.frame.width, height:60.0)
        }
        
        return CGSize.zero
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
        topChart.isSPPVisible = showMedian
        
        GainyAnalytics.logEvent("portfolio_chart_period_spp_pressed", params: [ "period" : viewModel.chartRange.rawValue, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "StockCard"])
    }
}

extension CollectionDetailsViewCell: TTFBlockViewDelegate {
    func unlockButtonTapped(showPurchase: Bool) {
        if showPurchase {
            GainyAnalytics.logDevEvent("purchase_details", params: ["collectionID" : viewModel.id])
            onPurhaseShow?()
        } else {
            GainyAnalytics.logDevEvent("unlock_details", params: ["collectionID" : viewModel.id])
            if SubscriptionManager.shared.storage.viewCollection(viewModel.id) {
                collectionView.reloadData()
            }
        }
    }
}
