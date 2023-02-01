//
//  HoldingPieChartCollectionHeaderView.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/9/22.
//

import UIKit
import SkeletonView
import Combine
import PureLayout
import Deviice

final class HoldingPieChartCollectionHeaderView: UICollectionReusableView {
    
    public var onSortingPressed: (() -> Void)?
    public var onSettingsPressed: (() -> Void)?
    public var onPlusPressed: (() -> Void)?
    
    public var onChartTickerButtonPressed: (() -> Void)?
    public var onChartCategoryButtonPressed: (() -> Void)?
    public var onChartInterestButtonPressed: (() -> Void)?
    public var onChartSecurityTypeButtonPressed: (() -> Void)?

    private var emptyLabel: UILabel?
    private var sortLbl: UILabel?
    private var settingsLbl: UILabel?
    private var sortByButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var settingsButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var plusButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var buttonsView: UIView?
    private var chartView: UIView? = nil
    private var loadingView: UIActivityIndicatorView? = nil
    
    private var chartTickerButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartCategoryButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartInterestButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartSecurityTypeButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartButtons: [UIView] = []
    private var mode: PieChartMode = .categories
//    private var marketDataToShow: [MarketDataField]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        chartTickerButton.backgroundColor = mode == .tickers ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#FFFFFF")
        chartTickerButton.titleLabel?.textColor = mode == .tickers ? UIColor.white : UIColor.init(hexString: "#131313")
        chartTickerButton.isUserInteractionEnabled = mode == .tickers ? false : true
        
        chartCategoryButton.backgroundColor = mode == .categories ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#FFFFFF")
        chartCategoryButton.titleLabel?.textColor = mode == .categories ? UIColor.white : UIColor.init(hexString: "#131313")
        chartCategoryButton.isUserInteractionEnabled = mode == .categories ? false : true
        
        chartInterestButton.backgroundColor = mode == .interests ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#FFFFFF")
        chartInterestButton.titleLabel?.textColor = mode == .interests ? UIColor.white : UIColor.init(hexString: "#131313")
        chartInterestButton.isUserInteractionEnabled = mode == .interests ? false : true
        
        chartSecurityTypeButton.backgroundColor = mode == .securityType ? UIColor.init(hexString: "#131313") : UIColor.init(hexString: "#FFFFFF")
        chartSecurityTypeButton.titleLabel?.textColor = mode == .securityType ? UIColor.white : UIColor.init(hexString: "#131313")
        chartSecurityTypeButton.isUserInteractionEnabled = mode == .securityType ? false : true
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
    
    private func setupChartButtons(mode: PieChartMode) {
        
        for button in chartButtons {
            button.removeFromSuperview()
        }
        chartButtons = []
        let allButtonsSize = 246.0
        let interItemOffset = 6.0
        let edgeOffset = (self.frame.width - allButtonsSize - interItemOffset * 3.0) / 2.0
        let topInset = 32.0
        self.addSubview(chartSecurityTypeButton)
        chartSecurityTypeButton.autoSetDimensions(to: CGSize.init(width: 55.0, height: 24.0))
        chartSecurityTypeButton.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
        chartSecurityTypeButton.autoPinEdge(toSuperviewEdge: .left, withInset: edgeOffset)
        chartSecurityTypeButton.addTarget(self,
                         action: #selector(chartSecurityTypeButtonTapped(_:)),
                         for: .touchUpInside)
        chartSecurityTypeButton.layer.cornerRadius = 8.0
        chartSecurityTypeButton.layer.masksToBounds = true
        chartSecurityTypeButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        chartSecurityTypeButton.setTitle("Classes", for: .normal)
        
        self.addSubview(chartTickerButton)
        chartTickerButton.autoSetDimensions(to: CGSize.init(width: 53.0, height: 24.0))
        chartTickerButton.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
        chartTickerButton.autoPinEdge(.left, to: .right, of: chartSecurityTypeButton, withOffset: interItemOffset)
        chartTickerButton.addTarget(self,
                         action: #selector(chartTickerButtonTapped(_:)),
                         for: .touchUpInside)
        chartTickerButton.layer.cornerRadius = 8.0
        chartTickerButton.layer.masksToBounds = true
        chartTickerButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        chartTickerButton.setTitle("Assets", for: .normal)
        
        self.addSubview(chartCategoryButton)
        chartCategoryButton.autoSetDimensions(to: CGSize.init(width: 75.0, height: 24.0))
        chartCategoryButton.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
        chartCategoryButton.autoPinEdge(.left, to: .right, of: chartTickerButton, withOffset: interItemOffset)
        chartCategoryButton.addTarget(self,
                         action: #selector(chartCategoryButtonTapped(_:)),
                         for: .touchUpInside)
        chartCategoryButton.layer.cornerRadius = 8.0
        chartCategoryButton.layer.masksToBounds = true
        chartCategoryButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        chartCategoryButton.setTitle("Categories", for: .normal)
        
        self.addSubview(chartInterestButton)
        chartInterestButton.autoSetDimensions(to: CGSize.init(width: 63.0, height: 24.0))
        chartInterestButton.autoPinEdge(toSuperviewEdge: .top, withInset: topInset)
        chartInterestButton.autoPinEdge(.left, to: .right, of: chartCategoryButton, withOffset: interItemOffset)
        chartInterestButton.addTarget(self,
                         action: #selector(chartInterestButtonTapped(_:)),
                         for: .touchUpInside)
        chartInterestButton.layer.cornerRadius = 8.0
        chartInterestButton.layer.masksToBounds = true
        chartInterestButton.titleLabel?.font = UIFont.proDisplaySemibold(12.0)
        chartInterestButton.setTitle("Interests", for: .normal)
        
        chartButtons = [chartSecurityTypeButton, chartTickerButton, chartCategoryButton, chartInterestButton]
        
        self.mode = mode
    }
    
    public func configureWithPieChartData(pieChartData: [PieChartData], mode: PieChartMode, loading: Bool) {

        let chartData = pieChartData.sorted(by: { itemLeft, itemRight in
            itemLeft.weight ?? 0.0 > itemRight.weight ?? 0.0
        })
        
        self.chartView?.removeFromSuperview()
        self.loadingView?.removeFromSuperview()
        self.sortByButton.removeFromSuperview()
        self.sortByButton = ResponsiveButton.newAutoLayout()
        self.settingsButton.removeFromSuperview()
        self.settingsButton = ResponsiveButton.newAutoLayout()
        self.plusButton.removeFromSuperview()
        self.plusButton = ResponsiveButton.newAutoLayout()
        self.buttonsView?.removeFromSuperview()
        self.sortLbl?.removeFromSuperview()
        self.sortLbl = nil
        self.settingsLbl?.removeFromSuperview()
        self.settingsLbl = nil
        self.emptyLabel?.removeFromSuperview()
        self.emptyLabel = nil
        
        self.setupChartButtons(mode: mode)
        
        if chartData.count == 0 {
            let noDataLabel = UILabel()
            noDataLabel.font = UIFont.compactRoundedMedium(18)
            noDataLabel.textColor = UIColor.black
            noDataLabel.numberOfLines = 1
            noDataLabel.textAlignment = .center
            self.addSubview(noDataLabel)
            noDataLabel.autoCenterInSuperview()
            noDataLabel.autoSetDimension(.height, toSize: 20.0)
            noDataLabel.isSkeletonable = false
            noDataLabel.text = loading ? "Loading data..." : "Not enough data"
            noDataLabel.sizeToFit()
            emptyLabel = noDataLabel
            if !loading {
                setupFilterButtons(aligmentView: noDataLabel)
            }
            return
        }
        
        let topInset = 16.0

        if chartData.count == 0 {
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
        
        let sumValue = chartData.map { item in
            item.absoluteValue ?? 0.0
        }.reduce(0, +)
        let sumChangeValue = chartData.map { item in
            item.absoluteDailyChange ?? 0.0
        }.reduce(0, +)
        let sumWeights = chartData.map { item in
            CGFloat((item.weight ?? 0.0) * 100.0)
        }.reduce(0, +)
        
        let relativeSumChange = ((sumValue / (sumValue - sumChangeValue)) - 1.0)
        
        let colors = UIColor.Gainy.pieChartColors
        var segments: [PieChartSegment] = []
        
        var index = 0
        let separatorValue = sumWeights / 360.0
        for element in chartData {
            let separatoeSegment = PieChartSegment(color: .white, value: separatorValue)
            segments.append(separatoeSegment)
            let color = (index <= 8 ? colors[index] : colors[9]) ?? UIColor.white
            let segment = PieChartSegment(color: color, value: CGFloat((element.weight ?? 0.0) * 100.0))
            segments.append(segment)
            index = index + 1
        }
        
        let pieChartView = PieChartView()
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        
        var size = UIScreen.main.bounds.width - 40 * 2
        pieChartView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        pieChartView.segments = segments
        self.addSubview(pieChartView)
        pieChartView.autoPinEdge(toSuperviewEdge: .top, withInset: 96.0)
        pieChartView.autoSetDimensions(to: CGSize.init(width: size, height: size))
        pieChartView.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let overlayView = UIView.newAutoLayout()
        overlayView.backgroundColor = UIColor(hexString: "#F7F8F9")
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
        middleContentView.autoSetDimension(.height, toSize: 72.0)
        
        
        var title = ""
        let count = chartData.count
        if mode == .categories {
            title = "\(count)" + (count > 1 ? " categories" : " category")
        } else if mode == .interests {
            title = "\(count)" + (count > 1 ? " interests" : " interest")
        } else if mode == .tickers {
            title = "\(count)" + (count > 1 ? " assets" : " asset")
        } else if mode == .securityType {
            title = "\(count)" + (count > 1 ? " classes" : " class")
        }
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.compactRoundedMedium(16)
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        middleContentView.addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .bottom)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoPinEdge(toSuperviewEdge: .right)
        titleLabel.autoSetDimension(.height, toSize: 17.0)
        titleLabel.isSkeletonable = true
        titleLabel.isHiddenWhenSkeletonIsActive = true
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let todayLabel = UILabel()
        todayLabel.font = UIFont.compactRoundedMedium(14)
        todayLabel.textColor = UIColor.init(hexString: "#B1BDC8")
        todayLabel.numberOfLines = 1
        todayLabel.textAlignment = .left
        middleContentView.addSubview(todayLabel)
        todayLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 33.0)
        todayLabel.autoPinEdge(toSuperviewEdge: .left)
        todayLabel.autoSetDimension(.height, toSize: 14.0)
        todayLabel.autoSetDimension(.width, toSize: 37.0)
        todayLabel.isSkeletonable = true
        todayLabel.isHiddenWhenSkeletonIsActive = true
        todayLabel.text = "Today"
        todayLabel.sizeToFit()
      
        let arrowView = UIImageView()
        arrowView.isSkeletonable = true
        arrowView.isHiddenWhenSkeletonIsActive = true
        middleContentView.addSubview(arrowView)
        arrowView.autoSetDimensions(to: CGSize.init(width: 8, height: 8))
        arrowView.autoPinEdge(toSuperviewEdge: .top, withInset:36.0)
        arrowView.autoPinEdge(.left, to: .right, of: todayLabel, withOffset: 4.0)
        arrowView.image = relativeSumChange >= 0.0 ? UIImage(named: "arrow-up-green") : UIImage(named: "arrow-down-red")
        
        let totalChangeAbsoluteLabel = UILabel()
        totalChangeAbsoluteLabel.font = UIFont.compactRoundedSemibold(14)
        totalChangeAbsoluteLabel.numberOfLines = 1
        totalChangeAbsoluteLabel.lineBreakMode = .byTruncatingTail
        totalChangeAbsoluteLabel.textAlignment = .left
        totalChangeAbsoluteLabel.isSkeletonable = true
        totalChangeAbsoluteLabel.linesCornerRadius = 6
        middleContentView.addSubview(totalChangeAbsoluteLabel)
        totalChangeAbsoluteLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 33.0)
        totalChangeAbsoluteLabel.autoSetDimension(.height, toSize: 14.0)
        totalChangeAbsoluteLabel.autoPinEdge(.left, to: .right, of: arrowView, withOffset: 4.0)
        totalChangeAbsoluteLabel.text = (abs(sumChangeValue)).price
        totalChangeAbsoluteLabel.textColor = relativeSumChange >= 0.0
        ? UIColor.Gainy.mainGreen
        : UIColor.Gainy.mainRed
        totalChangeAbsoluteLabel.sizeToFit()
        
        let dotView: UIView = UIView.newAutoLayout()
        dotView.backgroundColor = UIColor.init(hexString: "#B1BDC8")
        dotView.layer.cornerRadius = 1.0
        dotView.layer.masksToBounds = true
        middleContentView.addSubview(dotView)
        dotView.autoPinEdge(toSuperviewEdge: .top, withInset: 39.0)
        dotView.autoSetDimensions(to: CGSize.init(width: 2, height: 2))
        dotView.autoPinEdge(.left, to: .right, of: totalChangeAbsoluteLabel, withOffset: 4.0)
        
        let totalChangeRelativeLabel = UILabel()
        totalChangeRelativeLabel.font = UIFont.compactRoundedSemibold(14)
        totalChangeRelativeLabel.numberOfLines = 1
        totalChangeRelativeLabel.lineBreakMode = .byTruncatingTail
        totalChangeRelativeLabel.textAlignment = .left
        totalChangeRelativeLabel.isSkeletonable = true
        totalChangeRelativeLabel.linesCornerRadius = 6
        middleContentView.addSubview(totalChangeRelativeLabel)
        totalChangeRelativeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 33.0)
        totalChangeRelativeLabel.autoSetDimension(.height, toSize: 14.0)
        totalChangeRelativeLabel.autoPinEdge(.left, to: .right, of: dotView, withOffset: 4.0)
        totalChangeRelativeLabel.autoPinEdge(toSuperviewEdge: .right)
        let valueString = abs((relativeSumChange * 100.0)).percentRaw
        totalChangeRelativeLabel.text = valueString
        totalChangeRelativeLabel.textColor = relativeSumChange >= 0.0
        ? UIColor.Gainy.mainGreen
        : UIColor.Gainy.mainRed
        totalChangeRelativeLabel.sizeToFit()
        
        
        let toalPriceAbsoluteValueLabel = UILabel()
        toalPriceAbsoluteValueLabel.font = UIFont.compactRoundedSemibold(21)
        toalPriceAbsoluteValueLabel.textColor = UIColor.black
        toalPriceAbsoluteValueLabel.numberOfLines = 1
        toalPriceAbsoluteValueLabel.textAlignment = .center
        middleContentView.addSubview(toalPriceAbsoluteValueLabel)
        toalPriceAbsoluteValueLabel.autoPinEdge(toSuperviewEdge: .top)
        toalPriceAbsoluteValueLabel.autoPinEdge(toSuperviewEdge: .left)
        toalPriceAbsoluteValueLabel.autoPinEdge(toSuperviewEdge: .right)
        toalPriceAbsoluteValueLabel.autoSetDimension(.height, toSize: 21.0)
        toalPriceAbsoluteValueLabel.isSkeletonable = true
        toalPriceAbsoluteValueLabel.isHiddenWhenSkeletonIsActive = true
        toalPriceAbsoluteValueLabel.text = sumValue.priceRaw// "$ 156,228.50"
        toalPriceAbsoluteValueLabel.sizeToFit()
        
        setupFilterButtons(aligmentView: pieChartView)
    }
    
    private func setupFilterButtons(aligmentView: UIView) {
        let buttonsView = UIView.newAutoLayout()
        buttonsView.backgroundColor = UIColor.clear
        self.addSubview(buttonsView)
        buttonsView.autoSetDimension(.height, toSize: 24.0)
        buttonsView.autoPinEdge(.top, to: .bottom, of: aligmentView, withOffset: 32.0)
        buttonsView.autoAlignAxis(toSuperviewAxis: .vertical)
        buttonsView.autoSetDimension(.width, toSize: 10, relation: NSLayoutConstraint.Relation.greaterThanOrEqual)
        self.buttonsView = buttonsView
        
        
        settingsButton.layer.cornerRadius = 8.0
        settingsButton.layer.cornerCurve = .continuous
        settingsButton.backgroundColor = .black
        settingsButton.addTarget(self,action: #selector(settingsTapped), for: .touchUpInside)
        buttonsView.addSubview(settingsButton)
        settingsButton.autoPinEdge(toSuperviewEdge: .left)
        settingsButton.autoPinEdge(toSuperviewEdge: .top)
        settingsButton.autoPinEdge(toSuperviewEdge: .bottom)
        settingsButton.autoSetDimension(.height, toSize: 24.0)
        
        let slidersIconImageView = UIImageView.newAutoLayout()
        slidersIconImageView.image = UIImage(named: "sliders_white")
        settingsButton.addSubview(slidersIconImageView)
        slidersIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        slidersIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        slidersIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        
        let settingsByLabel = UILabel.newAutoLayout()
        settingsByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        settingsByLabel.textColor = .white
        settingsByLabel.numberOfLines = 1
        settingsByLabel.textAlignment = .center
        settingsByLabel.text = "View"
        settingsButton.addSubview(settingsByLabel)
        settingsByLabel.autoSetDimensions(to: CGSize.init(width: 25, height: 16))
        settingsByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        settingsByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        settingsByLabel.sizeToFit()
        
        let settingsLabel = UILabel.newAutoLayout()
        settingsLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        settingsLabel.textColor = .white
        settingsLabel.numberOfLines = 1
        settingsLabel.textAlignment = .center
        settingsLabel.text = "All data"
        settingsButton.addSubview(settingsLabel)
        settingsLabel.autoSetDimension(.height, toSize: 16)
        settingsLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 53.0)
        settingsLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)
        settingsLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8.0)
        
        settingsLabel.sizeToFit()
        settingsLbl = settingsLabel
        
        
        sortByButton.layer.cornerRadius = 8
        sortByButton.layer.cornerCurve = .continuous
        sortByButton.backgroundColor = .black
        sortByButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        buttonsView.addSubview(sortByButton)
        sortByButton.autoPinEdge(.left, to: .right, of: settingsButton, withOffset: 5.0)
        sortByButton.autoPinEdge(toSuperviewEdge: .top)
        sortByButton.autoPinEdge(toSuperviewEdge: .bottom)
        sortByButton.autoPinEdge(toSuperviewEdge: .right)
        sortByButton.autoSetDimension(.height, toSize: 24.0)

        let reorderIconImageView = UIImageView.newAutoLayout()
        reorderIconImageView.image = UIImage(named: "reorder_white")
        sortByButton.addSubview(reorderIconImageView)
        reorderIconImageView.autoSetDimensions(to: CGSize.init(width: 16, height: 16))
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8.0)
        reorderIconImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)

        let sortByLabel = UILabel.newAutoLayout()
        sortByLabel.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        sortByLabel.textColor = .white.withAlphaComponent(0.8)
        sortByLabel.numberOfLines = 1
        sortByLabel.textAlignment = .center
        sortByLabel.text = "Sort by"
        sortByButton.addSubview(sortByLabel)
        sortByLabel.autoSetDimensions(to: CGSize.init(width: 36, height: 16))
        sortByLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 26.0)
        sortByLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 4.0)

        let textLabel = UILabel.newAutoLayout()
        textLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        textLabel.textColor = .white
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
        
        updateFilterButtonTitle()
    }
    
    var isDemoProfile: Bool = false
    var profileToUse: Int? {
        if isDemoProfile {
            return Constants.Plaid.demoProfileID
        } else {
            return UserProfileManager.shared.profileID
        }
    }
    
    private func updateFilterButtonTitle() {
        
        guard let userID = profileToUse else {
            return
        }
        guard let settings = PortfolioSettingsManager.shared.getSettingByUserID(userID) else {
            return
        }
        
        let selectedInterests = settings.interests.filter { item in
            item.selected
        }
        let selectedCategories = settings.categories.filter { item in
            item.selected
        }
        let selectedSecurityTypes = settings.securityTypes.filter { item in
            item.selected
        }
        
        if settings.interests.count == selectedInterests.count && selectedCategories.count == settings.categories.count && settings.disabledAccounts.count == 0 {
            self.settingsLbl?.text = "All data"
            self.settingsLbl?.sizeToFit()
            return
        }
        
        let selectedSum = (selectedInterests.count) + (selectedCategories.count) + (selectedSecurityTypes.count) + settings.disabledAccounts.count
        self.settingsLbl?.text = selectedSum > 0 ? "Filter applied" : "All data"
        self.settingsLbl?.sizeToFit()
    }
    
    @objc
    private func sortTapped() {
        
        if let block = self.onSortingPressed {
            block()
        }
    }
    
    @objc
    private func settingsTapped() {
        
        if let block = self.onSettingsPressed {
            block()
        }
    }
    
    @objc
    private func plusTapped() {
        
        if let block = self.onPlusPressed {
            block()
        }
    }
    
    // MARK: Private
    
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
    private func chartSecurityTypeButtonTapped(_: UIButton) {
        self.onChartSecurityTypeButtonPressed?()
    }
}

