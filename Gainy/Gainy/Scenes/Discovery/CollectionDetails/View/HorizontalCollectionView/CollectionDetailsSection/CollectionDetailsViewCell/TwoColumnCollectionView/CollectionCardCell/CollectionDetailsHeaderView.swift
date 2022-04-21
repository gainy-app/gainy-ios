import UIKit
import SkeletonView
import Combine
import PureLayout

enum CollectionDetailsHeaderViewState: Int, Codable {
    
    case grid
    case list
    case chart
    
    static func heightForState(state: CollectionDetailsHeaderViewState) -> Int {
        
        switch state {
        case .grid: return 146
        case .list: return 173
        case .chart: return 482
        }
    }
}

final class CollectionDetailsHeaderView: UICollectionReusableView {
    
    private var ttfTickersLabel: UILabel = UILabel.newAutoLayout()
    private var chartModeButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var tableListModeButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var settingsViews: [UIView] = []
    private var sortLbl: UILabel?
    private var settingsButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var sortByButton: ResponsiveButton = ResponsiveButton.newAutoLayout()
    private var chartView: UIView? = nil
    private var listTitlesContainerView: UIView? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let fixedSpace = (frame.width - 36 * 2) / 16.0
        var prevView: UIView? = nil
        for i in 0 ..< 15 {
            
            let view = UIView.newAutoLayout()
            view.layer.cornerRadius = 1.0
            view.layer.masksToBounds = true
            view.backgroundColor = UIColor.init(hexString: "#B1BDC8")
            addSubview(view)
            view.autoSetDimensions(to: CGSize.init(width: 2, height: 2))
            view.autoPinEdge(toSuperviewEdge: .top, withInset: 24.0)
            if i == 0 {
                view.autoPinEdge(toSuperviewEdge: .left, withInset: 36.0)
            } else if let prevView = prevView {
                view.autoPinEdge(.left, to: .right, of: prevView, withOffset: fixedSpace)
            }
            prevView = view
        }
        
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
        ttfTickersLabel.text = "TTF Tickers"
        addSubview(ttfTickersLabel)
        
        ttfTickersLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 24.0)
        ttfTickersLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0)
        ttfTickersLabel.autoSetDimension(.height, toSize: 24.0)
        ttfTickersLabel.sizeToFit()
        
        chartModeButton.isSkeletonable = true
        chartModeButton.setImage(UIImage.init(named: "viewPieChart"), for: .normal)
        chartModeButton.setImage(UIImage.init(named: "viewList"), for: .selected)
        addSubview(chartModeButton)
        chartModeButton.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
        chartModeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        chartModeButton.autoPinEdge(toSuperviewEdge: .top, withInset: 50.0)
        chartModeButton.skeletonCornerRadius = 6
        chartModeButton.addTarget(self, action: #selector(chartModeButtonTapped), for: .touchUpInside)

        tableListModeButton.isSkeletonable = true
        tableListModeButton.setImage(UIImage.init(named: "viewTickersList"), for: .normal)
        tableListModeButton.setImage(UIImage.init(named: "viewTickersGridTable"), for: .selected)
        addSubview(tableListModeButton)
        tableListModeButton.autoSetDimensions(to: CGSize.init(width: 24, height: 24))
        tableListModeButton.autoPinEdge(toSuperviewEdge: .right, withInset: 24.0)
        tableListModeButton.autoPinEdge(.top, to: .bottom, of: chartModeButton, withOffset: 24.0)
        tableListModeButton.skeletonCornerRadius = 6
        tableListModeButton.addTarget(self, action: #selector(tableListModeButtonTapped), for: .touchUpInside)
        
        sortByButton.layer.cornerRadius = 12
        sortByButton.layer.cornerCurve = .continuous
        sortByButton.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        sortByButton.addTarget(self, action: #selector(sortTapped), for: .touchUpInside)
        addSubview(sortByButton)
        sortByButton.autoPinEdge(toSuperviewEdge: .left, withInset: 20.0)
        sortByButton.autoSetDimension(.height, toSize: 24.0)
        sortByButton.autoPinEdge(toSuperviewEdge: .top, withInset: 98.0)
        
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
        
        settingsButton.layer.cornerRadius = 12
        settingsButton.layer.cornerCurve = .continuous
        settingsButton.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        settingsButton.addTarget(self,action: #selector(settingsTapped), for: .touchUpInside)
        addSubview(settingsButton)
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
    }
    
    func updateChargeLbl(_ sort: String) {
        sortLbl?.text = sort
        sortLbl?.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithState(state: CollectionDetailsHeaderViewState) {
        
        switch state {
        case .grid:
            self.settingsButton.isHidden = true
            self.sortByButton.isHidden = false
            self.listTitlesContainerView?.isHidden = true
            self.chartView?.isHidden = true
        case .list:
            self.settingsButton.isHidden = false
            self.sortByButton.isHidden = false
            self.listTitlesContainerView?.isHidden = false
            self.chartView?.isHidden = true
        case .chart:
            self.settingsButton.isHidden = true
            self.sortByButton.isHidden = true
            self.listTitlesContainerView?.isHidden = true
            self.chartView?.isHidden = false
        }
    }
    
    @objc
    private func settingsTapped() {
        
        
    }
    
    @objc
    private func sortTapped() {
        
    }
    
    @objc
    private func chartModeButtonTapped() {
        
        self.chartModeButton.isSelected = !self.chartModeButton.isSelected
    }
    
    @objc
    private func tableListModeButtonTapped() {
        
        self.tableListModeButton.isSelected = !self.tableListModeButton.isSelected
    }
}
