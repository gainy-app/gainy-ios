import UIKit
import SkeletonView
import Combine
import PureLayout
import Deviice

enum CollectionDetailsHeaderViewState: Int, Codable {
    
    case grid
    case list
    case chart
    
    
    static func heightForState(state: CollectionDetailsHeaderViewState) -> Int {
        
        switch state {
        case .grid: return 146 - 16
        case .list: return 173 - 16
        case .chart: return 422 - 16
        }
    }
}

final class CollectionDetailsHeaderView: UICollectionReusableView {
    
    public var onSortingPressed: (() -> Void)?
    public var onSettingsPressed: (() -> Void)?
    public var onChartModeButtonPressed: ((Bool) -> Void)?
    public var onTableListModeButtonPressed: ((Bool) -> Void)?
    
    public var onChartTickerButtonPressed: (() -> Void)?
    public var onChartCategoryButtonPressed: (() -> Void)?
    public var onChartInterestButtonPressed: (() -> Void)?
    
    private var ttfTickersLabel: UILabel = UILabel.newAutoLayout()
    private var chartModeButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var tableListModeButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var settingsViews: [UIView] = []
    private var sortLbl: UILabel?
    private var settingsButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var sortByButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartView: UIView? = nil
    private var loadingView: UIActivityIndicatorView? = nil
    private var listTitlesContainerView: UIView? = nil
    
    private var chartTickerButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartCategoryButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartInterestButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartButtons: [UIView] = []
    private var mode: CollectionSettings.PieChartMode = .categories
    private var marketDataToShow: [MarketDataField]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let fixedSpace = (frame.width - 36 * 2) / 16.0
//        var prevView: UIView? = nil
//        for i in 0 ..< 15 {
//            
//            let view = UIView.newAutoLayout()
//            view.layer.cornerRadius = 1.0
//            view.layer.masksToBounds = true
//            view.backgroundColor = UIColor.init(hexString: "#B1BDC8")
//            self.addSubview(view)
//            view.autoSetDimensions(to: CGSize.init(width: 2, height: 2))
//            view.autoPinEdge(toSuperviewEdge: .top, withInset: 24.0)
//            if i == 0 {
//                view.autoPinEdge(toSuperviewEdge: .left, withInset: 36.0)
//            } else if let prevView = prevView {
//                view.autoPinEdge(.left, to: .right, of: prevView, withOffset: fixedSpace)
//            }
//            prevView = view
//        }
//        
        ttfTickersLabel.font = UIFont.proDisplaySemibold(20.0)
        ttfTickersLabel.textColor = UIColor.init(hexString: "#09141F")
        ttfTickersLabel.numberOfLines = 1
        ttfTickersLabel.lineBreakMode = .byTruncatingTail
        ttfTickersLabel.textAlignment = .left
        ttfTickersLabel.minimumScaleFactor = 0.1
        ttfTickersLabel.adjustsFontSizeToFitWidth = true
        ttfTickersLabel.isSkeletonable = true
        ttfTickersLabel.skeletonCornerRadius = 6
        ttfTickersLabel.linesCornerRadius = 6
        ttfTickersLabel.text = "TTF Details"
        self.addSubview(ttfTickersLabel)
        
        let topInset = 16.0
        ttfTickersLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        ttfTickersLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0 - topInset)
        ttfTickersLabel.autoSetDimension(.height, toSize: 24.0)
        ttfTickersLabel.sizeToFit()
        
        chartModeButton.contentMode = .scaleAspectFit
        chartModeButton.isSkeletonable = true
        chartModeButton.setImage(UIImage.init(named: "viewPieChart"), for: .normal)
        chartModeButton.setImage(UIImage.init(named: "viewList"), for: .selected)
        self.addSubview(chartModeButton)
        chartModeButton.autoSetDimensions(to: CGSize.init(width: 24, height: 30))
        chartModeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        chartModeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0 - topInset)
        chartModeButton.skeletonCornerRadius = 6
        chartModeButton.addTarget(self, action: #selector(chartModeButtonTapped), for: .touchUpInside)

        tableListModeButton.isSkeletonable = true
        tableListModeButton.setImage(UIImage.init(named: "viewTickersList"), for: .normal)
        tableListModeButton.setImage(UIImage.init(named: "viewTickersGridTable"), for: .selected)
        self.addSubview(tableListModeButton)
        tableListModeButton.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
        tableListModeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        tableListModeButton.skeletonCornerRadius = 6
        tableListModeButton.addTarget(self, action: #selector(tableListModeButtonTapped), for: .touchUpInside)
        
        sortByButton.layer.cornerRadius = 8
        sortByButton.layer.cornerCurve = .continuous
        sortByButton.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        sortByButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        self.addSubview(sortByButton)
        sortByButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        sortByButton.autoSetDimension(.height, toSize: 24.0)
        sortByButton.autoPinEdge(toSuperviewEdge: .top, withInset: 98.0 - topInset)
        
        tableListModeButton.autoAlignAxis(.horizontal, toSameAxisOf: sortByButton)
        
        let reorderIconImageView = UIImageView.newAutoLayout()
        reorderIconImageView.image = UIImage(named: "reorder")
        sortByButton.addSubview(reorderIconImageView)
        reorderIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)

        
        let sortByLabel = UILabel.newAutoLayout()
        sortByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        sortByLabel.textColor = UIColor.init(hexString: "#687379")
        sortByLabel.numberOfLines = 1
        sortByLabel.textAlignment = .center
        sortByLabel.text = "Sort by"
        sortByButton.addSubview(sortByLabel)
        sortByLabel.autoSetDimensions(to: CGSize.init(width: 36, height: 16))
        sortByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        sortByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)


        let textLabel = UILabel.newAutoLayout()
        textLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        textLabel.textColor = UIColor.init(hexString: "#09141F")
        textLabel.numberOfLines = 1
        textLabel.textAlignment = .center
        textLabel.text = "View All"
        textLabel.minimumScaleFactor = 0.1
        sortLbl = textLabel
        sortByButton.addSubview(textLabel)
        
        textLabel.autoSetDimension(.height, toSize: 16)
        textLabel.autoPinEdge(.left, to: .right, of: sortByLabel, withOffset: 2.0)
        textLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        textLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        textLabel.sizeToFit()
        
        settingsButton.layer.cornerRadius = 8.0
        settingsButton.layer.cornerCurve = .continuous
        settingsButton.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        settingsButton.addTarget(self,action: #selector(settingsTapped), for: .touchUpInside)
        self.addSubview(settingsButton)
        settingsButton.autoAlignAxis(.horizontal, toSameAxisOf: sortByButton)
        settingsButton.autoPinEdge(.left, to: .right, of: sortByButton, withOffset: 8.0)
        settingsButton.autoSetDimension(.height, toSize: 24.0)
        
        
        let slidersIconImageView = UIImageView.newAutoLayout()
        slidersIconImageView.image = UIImage(named: "sliders")
        settingsButton.addSubview(slidersIconImageView)
        slidersIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        slidersIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        slidersIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)

        
        let settingsByLabel = UILabel.newAutoLayout()
        settingsByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        settingsByLabel.textColor = UIColor.init(hexString: "#09141F")
        settingsByLabel.numberOfLines = 1
        settingsByLabel.textAlignment = .center
        settingsByLabel.text = "Settings"
        settingsButton.addSubview(settingsByLabel)
        settingsByLabel.autoSetDimensions(to: CGSize.init(width: 42, height: 16))
        settingsByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        settingsByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        settingsByLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        
        settingsByLabel.sizeToFit()
        
        self.setupSettingViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        chartTickerButton.backgroundColor = mode == .tickers ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#F7F8F9")
        chartTickerButton.titleLabel?.textColor = mode == .tickers ? UIColor.white : UIColor.init(hexString: "#131313")
        chartTickerButton.isUserInteractionEnabled = mode == .tickers ? false : true
        
        chartCategoryButton.backgroundColor = mode == .categories ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#F7F8F9")
        chartCategoryButton.titleLabel?.textColor = mode == .categories ? UIColor.white : UIColor.init(hexString: "#131313")
        chartCategoryButton.isUserInteractionEnabled = mode == .categories ? false : true
        
        chartInterestButton.backgroundColor = mode == .interests ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#F7F8F9")
        chartInterestButton.titleLabel?.textColor = mode == .interests ? UIColor.white : UIColor.init(hexString: "#131313")
        chartInterestButton.isUserInteractionEnabled = mode == .interests ? false : true
    }
    
    func updateChargeLbl(_ sort: String) {
        sortLbl?.text = sort
        sortLbl?.sizeToFit()
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSettingViews() {
        backgroundColor = .white
        self.addSubview(tickerLbl)
        tickerLbl.autoSetDimensions(to: CGSize.init(width: 42, height: 24))
        tickerLbl.autoPinEdge(.left, to: .left, of: self, withOffset: 32)
        tickerLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -3)
        
        self.addSubview(firstMarketMarkerButton)
        firstMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        firstMarketMarkerButton.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        firstMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        self.addSubview(netLbl)
        netLbl.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        netLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -32)
        netLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        self.addSubview(secondMarketMarkerButton)
        secondMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        secondMarketMarkerButton.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -80)
        secondMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        self.addSubview(monthPriceLbl)
        monthPriceLbl.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        monthPriceLbl.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -80)
        monthPriceLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        self.addSubview(thirdMarketMarkerButton)
        thirdMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        thirdMarketMarkerButton.autoPinEdge(.right, to: .right, of: self, withOffset: -128)
        thirdMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        self.addSubview(capLbl)
        capLbl.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        capLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -128)
        capLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        self.addSubview(fourthMarketMarkerButton)
        fourthMarketMarkerButton.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        fourthMarketMarkerButton.autoPinEdge(.right, to: .right, of: self, withOffset: -176)
        fourthMarketMarkerButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        self.addSubview(peLbl)
        peLbl.autoSetDimensions(to: CGSize.init(width: 48, height: 24))
        peLbl.autoPinEdge(.right, to: .right, of: self, withOffset: -176)
        peLbl.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: 0)
        
        settingsViews = [tickerLbl, firstMarketMarkerButton, netLbl, secondMarketMarkerButton, monthPriceLbl, thirdMarketMarkerButton, capLbl, fourthMarketMarkerButton, peLbl]
    }
    
    private func setupChartButtons(mode: CollectionSettings.PieChartMode) {
        
        for button in chartButtons {
            button.removeFromSuperview()
        }
        chartButtons = []
        
        let topInset = 16.0
        
        self.addSubview(chartCategoryButton)
        chartCategoryButton.autoPinEdge(toSuperviewEdge: .top, withInset: 98.0 - topInset)
        chartCategoryButton.autoAlignAxis(toSuperviewAxis: .vertical)
        chartCategoryButton.autoSetDimensions(to: CGSize.init(width: 75.0, height: 24.0))
        chartCategoryButton.addTarget(self,
                         action: #selector(chartCategoryButtonTapped(_:)),
                         for: .touchUpInside)
        chartCategoryButton.layer.cornerRadius = 8.0
        chartCategoryButton.layer.masksToBounds = true
        chartCategoryButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        
        chartCategoryButton.setTitle("Categories", for: .normal)
        
        self.addSubview(chartTickerButton)
        chartTickerButton.autoPinEdge(toSuperviewEdge: .top, withInset: 98.0 - topInset)
        chartTickerButton.autoPinEdge(.right, to: .left, of: chartCategoryButton, withOffset: -8.0)
        chartTickerButton.autoSetDimensions(to: CGSize.init(width: 55.0, height: 24.0))
        chartTickerButton.addTarget(self,
                         action: #selector(chartTickerButtonTapped(_:)),
                         for: .touchUpInside)
        chartTickerButton.layer.cornerRadius = 8.0
        chartTickerButton.layer.masksToBounds = true
        chartTickerButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        
        chartTickerButton.setTitle("Tickers", for: .normal)
        
        self.addSubview(chartInterestButton)
        chartInterestButton.autoPinEdge(toSuperviewEdge: .top, withInset: 98.0 - topInset)
        chartInterestButton.autoPinEdge(.left, to: .right, of: chartCategoryButton, withOffset: 8.0)
        chartInterestButton.autoSetDimensions(to: CGSize.init(width: 63.0, height: 24.0))
        chartInterestButton.addTarget(self,
                         action: #selector(chartInterestButtonTapped(_:)),
                         for: .touchUpInside)
        chartInterestButton.layer.cornerRadius = 8.0
        chartInterestButton.layer.masksToBounds = true
        chartInterestButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        
        chartInterestButton.setTitle("Interests", for: .normal)
        
        chartButtons = [chartCategoryButton, chartTickerButton, chartInterestButton]
        self.mode = mode
    }
    
    public func configureWithPieChartData(pieChartData: [GetTtfPieChartQuery.Data.CollectionPiechart], mode: CollectionSettings.PieChartMode) {

        self.chartView?.removeFromSuperview()
        self.loadingView?.removeFromSuperview()
        let topInset = 16.0

        if pieChartData.count == 0 {
            let indicatorView = UIActivityIndicatorView.init(style: .medium)
            indicatorView.hidesWhenStopped = true
            self.addSubview(indicatorView)
            indicatorView.autoPinEdge(toSuperviewEdge: .top, withInset: 146.0 - topInset)
            let size = self.frame.size.width - 40 * 2
            indicatorView.autoSetDimensions(to: CGSize.init(width: size, height: size))
            indicatorView.autoPinEdge(toSuperviewEdge: .left, withInset: 40.0)
            indicatorView.startAnimating()
            self.loadingView = indicatorView
            return
        }
        
        let sumValue = pieChartData.map { item in
            item.absoluteValue ?? 0.0
        }.reduce(0, +)
        let sumChangeValue = pieChartData.map { item in
            item.absoluteDailyChange ?? 0.0
        }.reduce(0, +)
        let sumWeights = pieChartData.map { item in
            CGFloat((item.weight ?? 0.0) * 100.0)
        }.reduce(0, +)
        
        let relativeSumChange = ((sumValue / (sumValue - sumChangeValue)) - 1.0)
        
        let colors = UIColor.Gainy.pieChartColors
        var segments: [PieChartSegment] = []
        
        var index = 0
        let separatorValue = sumWeights / 360.0
        for element in pieChartData {
            let separatoeSegment = PieChartSegment(color: .white, value: separatorValue)
            segments.append(separatoeSegment)
            let color = (index <= 8 ? colors[index] : colors[9]) ?? UIColor.white
            let segment = PieChartSegment(color: color, value: CGFloat((element.weight ?? 0.0) * 100.0))
            segments.append(segment)
            index = index + 1
        }
        
        let pieChartView = PieChartView()
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        
        var size = 240
        pieChartView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        pieChartView.segments = segments
        self.addSubview(pieChartView)
        pieChartView.autoPinEdge(toSuperviewEdge: .top, withInset: 154.0 - topInset)
        pieChartView.autoSetDimensions(to: CGSize.init(width: size, height: size))
        pieChartView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let overlayView = UIView.newAutoLayout()
        overlayView.backgroundColor = self.backgroundColor
        pieChartView.addSubview(overlayView)
        size = size - 20
        overlayView.layer.masksToBounds = true
        overlayView.layer.cornerRadius = CGFloat(size / 2)
        overlayView.autoCenterInSuperview()
        overlayView.autoSetDimensions(to: CGSize.init(width: size, height: size))
        self.chartView = pieChartView
        
        let middleContentView = UIView.newAutoLayout()
        overlayView.addSubview(middleContentView)
        middleContentView.autoCenterInSuperview()
        middleContentView.autoSetDimension(.height, toSize: 40.0)
        
        
        var title = ""
        let count = pieChartData.count
        if mode == .categories {
            title = "\(count)" + (count > 1 ? " categories" : " category")
        } else if mode == .interests {
            title = "\(count)" + (count > 1 ? " interests" : " interest")
        } else if mode == .tickers {
            title = "\(count)" + (count > 1 ? " tickers" : " ticker")
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.compactRoundedMedium(16)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        middleContentView.addSubview(titleLabel)
//        if mode != .tickers {
            titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
//        } else {
//            titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
//        }
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoSetDimension(.height, toSize: 16.0)
        titleLabel.isSkeletonable = true
        titleLabel.isHiddenWhenSkeletonIsActive = true
        titleLabel.text = title
        titleLabel.sizeToFit()
        
//        if mode == .tickers {
//            let todayLabel = UILabel()
//            todayLabel.font = UIFont.compactRoundedMedium(14)
//            todayLabel.textColor = UIColor.init(hexString: "#B1BDC8")
//            todayLabel.numberOfLines = 1
//            todayLabel.textAlignment = .left
//            middleContentView.addSubview(todayLabel)
//            todayLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 1.0)
//            todayLabel.autoPinEdge(toSuperviewEdge: .left)
//            todayLabel.autoSetDimension(.height, toSize: 14.0)
//            todayLabel.autoSetDimension(.width, toSize: 37.0)
//            todayLabel.isSkeletonable = true
//            todayLabel.isHiddenWhenSkeletonIsActive = true
//            todayLabel.text = "Today"
//            todayLabel.sizeToFit()
//
//            let arrowView = UIImageView()
//            arrowView.isSkeletonable = true
//            arrowView.isHiddenWhenSkeletonIsActive = true
//            middleContentView.addSubview(arrowView)
//            arrowView.autoSetDimensions(to: CGSize.init(width: 8, height: 8))
//            arrowView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
//            arrowView.autoPinEdge(.left, to: .right, of: todayLabel, withOffset: 4.0)
//            arrowView.image = relativeSumChange >= 0.0 ? UIImage(named: "arrow-up-green") : UIImage(named: "arrow-down-red")
//
//            let totalChangeAbsoluteLabel = UILabel()
//            totalChangeAbsoluteLabel.font = UIFont.compactRoundedSemibold(14)
//            totalChangeAbsoluteLabel.numberOfLines = 1
//            totalChangeAbsoluteLabel.lineBreakMode = .byTruncatingTail
//            totalChangeAbsoluteLabel.textAlignment = .left
//            totalChangeAbsoluteLabel.isSkeletonable = true
//            totalChangeAbsoluteLabel.linesCornerRadius = 6
//            middleContentView.addSubview(totalChangeAbsoluteLabel)
//            totalChangeAbsoluteLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 1.0)
//            totalChangeAbsoluteLabel.autoSetDimension(.height, toSize: 14.0)
//            totalChangeAbsoluteLabel.autoPinEdge(.left, to: .right, of: arrowView, withOffset: 4.0)
//            totalChangeAbsoluteLabel.text = (abs(sumChangeValue)).price
//            totalChangeAbsoluteLabel.textColor = relativeSumChange >= 0.0
//            ? UIColor.Gainy.mainGreen
//            : UIColor.Gainy.mainRed
//            totalChangeAbsoluteLabel.sizeToFit()
//
//            let dotView: UIView = UIView.newAutoLayout()
//            dotView.backgroundColor = UIColor.init(hexString: "#B1BDC8")
//            dotView.layer.cornerRadius = 1.0
//            dotView.layer.masksToBounds = true
//            middleContentView.addSubview(dotView)
//            dotView.autoPinEdge(toSuperviewEdge: .top, withInset: 7.0)
//            dotView.autoSetDimensions(to: CGSize.init(width: 2, height: 2))
//            dotView.autoPinEdge(.left, to: .right, of: totalChangeAbsoluteLabel, withOffset: 4.0)
//
//            let totalChangeRelativeLabel = UILabel()
//            totalChangeRelativeLabel.font = UIFont.compactRoundedSemibold(14)
//            totalChangeRelativeLabel.numberOfLines = 1
//            totalChangeRelativeLabel.lineBreakMode = .byTruncatingTail
//            totalChangeRelativeLabel.textAlignment = .left
//            totalChangeRelativeLabel.isSkeletonable = true
//            totalChangeRelativeLabel.linesCornerRadius = 6
//            middleContentView.addSubview(totalChangeRelativeLabel)
//            totalChangeRelativeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 1.0)
//            totalChangeRelativeLabel.autoSetDimension(.height, toSize: 14.0)
//            totalChangeRelativeLabel.autoPinEdge(.left, to: .right, of: dotView, withOffset: 4.0)
//            totalChangeRelativeLabel.autoPinEdge(toSuperviewEdge: .right)
//            let valueString = abs((relativeSumChange * 100.0)).percentRaw
//            totalChangeRelativeLabel.text = valueString
//            totalChangeRelativeLabel.textColor = relativeSumChange >= 0.0
//            ? UIColor.Gainy.mainGreen
//            : UIColor.Gainy.mainRed
//            totalChangeRelativeLabel.sizeToFit()
//        }
        
        self.setupChartButtons(mode: mode)
    }
    
    func configureWithState(state: CollectionDetailsHeaderViewState) {
        
        switch state {
        case .grid:
            self.settingsButton.isHidden = true
            self.sortByButton.isHidden = false
            self.listTitlesContainerView?.isHidden = true
            self.chartView?.isHidden = true
            self.tableListModeButton.isSelected = false
            self.tableListModeButton.isHidden = false
            self.chartModeButton.isSelected = false
            self.loadingView?.isHidden = true
            for view in settingsViews {
                view.isHidden = true
            }
            for view in chartButtons {
                view.isHidden = true
            }
        case .list:
            self.settingsButton.isHidden = false
            self.sortByButton.isHidden = false
            self.listTitlesContainerView?.isHidden = false
            self.chartView?.isHidden = true
            self.tableListModeButton.isSelected = true
            self.tableListModeButton.isHidden = false
            self.chartModeButton.isSelected = false
            self.loadingView?.isHidden = true
            for view in settingsViews {
                view.isHidden = false
            }
            for view in chartButtons {
                view.isHidden = true
            }
        case .chart:
            self.settingsButton.isHidden = true
            self.sortByButton.isHidden = true
            self.tableListModeButton.isHidden = true
            self.listTitlesContainerView?.isHidden = true
            self.chartView?.isHidden = false
            self.loadingView?.isHidden = false
            self.chartModeButton.isSelected = true
            for view in settingsViews {
                view.isHidden = true
            }
            for view in chartButtons {
                view.isHidden = false
            }
        }
    }
    
    @objc
    private func settingsTapped() {
        
        if let block = self.onSettingsPressed {
            block()
        }
    }
    
    @objc
    private func sortTapped() {
        
        if let block = self.onSortingPressed {
            block()
        }
    }
    
    @objc
    private func chartModeButtonTapped() {
        
        self.chartModeButton.isSelected = !self.chartModeButton.isSelected
        if let block = self.onChartModeButtonPressed {
            block(self.chartModeButton.isSelected)
        }
    }
    
    @objc
    private func tableListModeButtonTapped() {
        
        self.tableListModeButton.isSelected = !self.tableListModeButton.isSelected
        if let block = self.onTableListModeButtonPressed {
            block(self.tableListModeButton.isSelected)
        }
    }
    
    // MARK: Private

    // MARK: Functions

    func updateMetrics(_ metrics: [MarketDataField]) {
        
        self.marketDataToShow = metrics
        let titles = metrics.prefix(4).map(\.shortTitle)
        let lbls = [peLbl, capLbl, monthPriceLbl, netLbl]
        
        if titles.first == Constants.CollectionDetails.matchScore {
            for (ind, val) in titles.reversed().enumerated() {
                lbls[ind].text = val.uppercased()
            }
        } else {
            for (ind, val) in titles.enumerated() {
                lbls[ind].text = val.uppercased()
            }
        }
    }
    
    @objc
    private func chartTickerButtonTapped(_: UIButton) {
        self.onChartTickerButtonPressed?()
    }
    
    @objc
    private func chartCategoryButtonTapped(_: UIButton) {
        self.onChartCategoryButtonPressed?()
    }
    
    @objc
    private func chartInterestButtonTapped(_: UIButton) {
        self.onChartInterestButtonPressed?()
    }
    
    @objc
    private func firstMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 3)
    }

    @objc
    private func secondMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 2)
    }

    @objc
    private func thirdMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 1)
    }
    
    @objc
    private func fourthMarketMarkerTapped(_: UIButton) {
        self.showExplanationForFieldAtIndex(index: 0)
    }
    
    private func showExplanationForFieldAtIndex(index: Int) {
        
        guard let marketDataToShow = self.marketDataToShow else {
            return
        }
        guard marketDataToShow.count >= 4 else {
            return
        }
        
        let marketData = marketDataToShow[index]
        
        let explanationVc = FeatureDescriptionViewController.init()
        explanationVc.configureWith(title: marketData.explanationTitle)
        explanationVc.configureWith(description: marketData.explanationDescription,
                                    linkString: marketData.explanationLinkString,
                                    link: marketData.explanationLink)
        FloatingPanelManager.shared.configureWithHeight(height: CGFloat(marketData.explanationHeight))
        FloatingPanelManager.shared.setupFloatingPanelWithViewController(viewController: explanationVc)
        FloatingPanelManager.shared.showFloatingPanel()
    }
    
    lazy var tickerLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .left
        label.text = "Stock\nTicker".uppercased()
        return label
    }()
    
    lazy var netLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Net Profit".uppercased()
        return label
    }()
    
    lazy var monthPriceLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Month to day".uppercased()
        return label
    }()
    
    lazy var capLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Market\ncap".uppercased()
        return label
    }()
    
    lazy var peLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.compactRoundedMedium(Deviice.current.size == .screen4Dot7Inches ? 6 : 9)
        label.textColor = UIColor(hexString: "B1BDC8")!
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "EV/S\n".uppercased()
        return label
    }()
    
    lazy var firstMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(firstMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var secondMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(secondMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var thirdMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(thirdMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
    
    lazy var fourthMarketMarkerButton: UIButton = {
        let button = UIButton()

        button.backgroundColor = UIColor.Gainy.white

        button.addTarget(self,
                         action: #selector(fourthMarketMarkerTapped(_:)),
                         for: .touchUpInside)

        return button
    }()
}
