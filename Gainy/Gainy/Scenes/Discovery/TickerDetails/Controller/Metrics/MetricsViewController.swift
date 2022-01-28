//
//  MetricsViewController.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/17/21.
//

import UIKit
import Apollo

enum MetricsViewControllerSection: Int, CaseIterable, Hashable {
    case selected = 0, trading, growth, general, valuation, momentum, dividend, earnings, financials
}

protocol MetricsViewControllerDelegate: AnyObject {
    
    func didDismissMetricsViewController()
}

class MetricsViewController: BaseViewController {

    @IBOutlet private weak var titleLbl: UILabel! {
       didSet {
           titleLbl.setKern()
       }
   }
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var searchCollectionView: UICollectionView!
    
    private var footerViewHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint?
    
    var ticker: RemoteTicker? = nil
    var collectionID: Int? = nil
    private var maxSelectedElements: Int = 6
    
    public weak var delegate: MetricsViewControllerDelegate?
    public var selectedMarketDataFields: [MarketDataField] = []
    
    private var selectedSection: [TickerInfo.MarketData] = []
    private var tradingSection: [TickerInfo.MarketData] = []
    private var growthSection: [TickerInfo.MarketData] = []
    private var generalSection: [TickerInfo.MarketData] = []
    private var valuationSection: [TickerInfo.MarketData] = []
    private var momentumSection: [TickerInfo.MarketData] = []
    private var dividendSection: [TickerInfo.MarketData] = []
    private var earningsSection: [TickerInfo.MarketData] = []
    private var financialsSection: [TickerInfo.MarketData] = []
    
    private var allMetrics: [TickerInfo.MarketData] = []
    private var searchDataSourceMetrics: [TickerInfo.MarketData] = []
    
    private var bottomView: MetricsBottomView? = nil
    private var isSearching: Bool = false
    private let itemWidth: CGFloat = (UIScreen.main.bounds.width - 16.0 * 2.0 - 10.0 * 2.0) / 3.0
    private let itemHeight: CGFloat = 96.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.Gainy.white
        if self.collectionID != nil {
            self.maxSelectedElements = 5
        }
        self.setUpSearchTextField()
        self.setUpColelctionView()
        self.setUpBottomView()
        self.setUpSearchColelctionView()
        self.fillDataSource()
    }

    
    @objc func textFieldClear() {
        isSearching = false
        searchTextField?.text = ""
        searchDataSourceMetrics.removeAll()
        searchTextField?.resignFirstResponder()
        UIView.animate(withDuration: 0.25) {
            self.bottomView?.alpha = 1.0
            self.collectionView.alpha = 1.0
            self.searchCollectionView.alpha = 0.0
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        let text = textField.text ?? ""
        if text.count > 0 {
            searchTextField?.clearButtonMode = .always
            searchTextField?.clearButtonMode = .whileEditing
        } else {
            searchTextField?.clearButtonMode = .never
        }
        
        searchDataSourceMetrics = allMetrics.filter({ item in
            return item.name.lowercased().contains(text.lowercased()) ||
            item.period.lowercased().contains(text.lowercased()) ||
            item.value.lowercased().contains(text.lowercased())
        })
        self.searchCollectionView.reloadData()
    }
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
        isSearching = true
        self.searchCollectionView.reloadData()
        GainyAnalytics.logEvent("metrics_search_started", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Metrics"])
        UIView.animate(withDuration: 0.25) {
            self.bottomView?.alpha = 0.0
            self.collectionView.alpha = 0.0
            self.searchCollectionView.alpha = 1.0
        }
    }
    
    @objc func textFieldEditingDidEnd(_ textField: UITextField) {
        isSearching = false
        self.textFieldClear()
        GainyAnalytics.logEvent("metrics_search_ended", params: ["sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "Metrics"])
    }
    
    private func setUpSearchTextField() {
        
        searchTextField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        searchTextField.textColor = UIColor(named: "mainText")
        searchTextField.layer.cornerRadius = 16
        searchTextField.isUserInteractionEnabled = true
        searchTextField.placeholder = "Search metrics"
        searchTextField.backgroundColor = UIColor(hexString: "F7F8F9", alpha: 1.0)
        searchTextField.layer.cornerRadius = 16.0
        searchTextField.clipsToBounds = true
        let searchIconContainerView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 14 + 24 + 6,
                height: 24
            )
        )
        
        let searchIconImageView = UIImageView(
            frame: CGRect(
                x: 14,
                y: 0,
                width: 24,
                height: 24
            )
        )
        
        searchIconContainerView.addSubview(searchIconImageView)
        
        searchIconImageView.contentMode = .center
        searchIconImageView.backgroundColor = UIColor.Gainy.lightBack
        searchIconImageView.image = UIImage(named: "search")
        
        searchTextField.leftView = searchIconContainerView
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .whileEditing
        searchTextField.backgroundColor = UIColor.Gainy.lightBack
        searchTextField.returnKeyType = .done
        
        let btnFrame = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24 + 12, height: 24))
        let clearBtn = UIButton(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 24,
                height: 24
            )
        )
        clearBtn.setImage(UIImage(named: "search_clear"), for: .normal)
        clearBtn.addTarget(self, action: #selector(textFieldClear), for: .touchUpInside)
        btnFrame.addSubview(clearBtn)
        searchTextField.rightView = btnFrame
        
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
        searchTextField.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchTextField.delegate = self
    }
    
    private func setUpColelctionView() {
        
        collectionView.isSkeletonable = true
        collectionView.register(UINib.init(nibName: "TickerDetailsMarketInnerViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier)
        
        self.collectionView.register(UINib.init(nibName: "MetricsFooterView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: MetricsFooterView.reuseIdentifier)
        
        self.collectionView.register(UINib.init(nibName: "MetricsHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MetricsHeaderView.reuseIdentifier)
        
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dragInteractionEnabled = true
        collectionView.allowsMultipleSelection = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
    
    private func setUpSearchColelctionView() {
        
        searchCollectionView.isSkeletonable = true
        searchCollectionView.register(UINib.init(nibName: "TickerDetailsMarketInnerViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier)
        searchCollectionView.register(UINib.init(nibName: "MetricsHeaderView", bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MetricsHeaderView.reuseIdentifier)
        searchCollectionView.backgroundColor = .clear
        searchCollectionView.showsVerticalScrollIndicator = false
        searchCollectionView.allowsMultipleSelection = true
        searchCollectionView.bounces = false
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.alpha = 0.0
    }
    
    private func setUpBottomView() {
        
        let bottomView = UINib(nibName:"MetricsBottomView",bundle:.main).instantiate(withOwner: nil, options: nil).first as! MetricsBottomView
        //bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(bottomView)
        
         
        bottomView.autoPinEdge(toSuperviewEdge: .leading)
        bottomView.autoPinEdge(toSuperviewEdge: .trailing)
        bottomView.autoPinEdge(toSuperviewSafeArea: .bottom)
        self.bottomView = bottomView
        self.bottomView?.delegate = self
        bottomView.alpha = 1.0
        
        self.bottomView?.setSaveButtonHidden(hidden: self.selectedSection.count < self.maxSelectedElements)
        let text = "Select \(self.maxSelectedElements) metrics please"
        self.bottomView?.setText(text: text)
        self.updateBottomViewPosition()
    }
    
    private func fillDataSource() {
        
        guard let ticker = self.ticker else {
            return
        }
        
        var tickerMetrics = UserProfileManager.shared.profileMetricsSettings.filter { item in
            item.collectionId == self.collectionID
        }
        
        tickerMetrics = tickerMetrics.sorted { left, right in
            left.order < right.order
        }
        
        for metric in MarketDataField.allCases {
            if metric == .address {
                print("stop")
            }
            let marketData: TickerInfo.MarketData? = metric.mapToMarketData(ticker: ticker)
            guard let marketData = marketData else {
                continue
            }
            
            if metric.rawValue >= MarketDataField.avgVolume10d.rawValue &&
               metric.rawValue <= MarketDataField.impliedVolatility.rawValue {                self.tradingSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.revenueGrowthYoy.rawValue &&
                      metric.rawValue <= MarketDataField.epsGrowthFwd.rawValue {
                self.growthSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.address.rawValue &&
                      metric.rawValue <= MarketDataField.exchangeName.rawValue {
                self.generalSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.marketCapitalization.rawValue &&
                      metric.rawValue <= MarketDataField.enterpriseValueToEbitda.rawValue {
                self.valuationSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.priceChange1m.rawValue &&
                      metric.rawValue <= MarketDataField.priceChange1y.rawValue {
                self.momentumSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.dividendYield.rawValue &&
                      metric.rawValue <= MarketDataField.dividendFrequency.rawValue {
                self.dividendSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.epsActual.rawValue &&
                      metric.rawValue <= MarketDataField.revenueActual.rawValue {
                self.earningsSection.append(marketData)
            } else if metric.rawValue >= MarketDataField.revenueTtm.rawValue &&
                      metric.rawValue <= MarketDataField.netDebt.rawValue {
                self.financialsSection.append(marketData)
                
            }
            
            if tickerMetrics.count == 0 {
                if MarketDataField.metricsOrder.contains(where: { item in
                    item == metric
                }) {
                    self.selectedSection.append(marketData)
                }
            }
            self.allMetrics.append(marketData)
        }
        
        if tickerMetrics.count > 0 {
            for tickerMetric in tickerMetrics {
                for metric in MarketDataField.allCases {
                    let marketData: TickerInfo.MarketData? = metric.mapToMarketData(ticker: ticker)
                    guard let marketData = marketData else {
                        continue
                    }
                    if tickerMetric.fieldName == metric.fieldName {
                        self.selectedSection.append(marketData)
                    }
                }
            }
        }
        
        self.collectionView.reloadData()
        self.bottomView?.setSaveButtonHidden(hidden: self.selectedSection.count < self.maxSelectedElements)
    }
    
    func updateBottomViewPosition() {
        
        self.bottomView?.setSaveButtonHidden(hidden: self.selectedSection.count < self.maxSelectedElements)
        let height = self.selectedSection.count < self.maxSelectedElements ? 30 : 101
        if self.footerViewHeightConstraint != nil {
            self.footerViewHeightConstraint?.constant = CGFloat(height)
        } else {
            self.footerViewHeightConstraint = self.bottomView?.autoSetDimension(.height, toSize: CGFloat(height))
        }
        self.collectionViewBottomConstraint?.constant = self.selectedSection.count < self.maxSelectedElements ? 45 : 0
        let bottomInset = self.selectedSection.count < self.maxSelectedElements ? 0 : 101
        self.collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: CGFloat(bottomInset), right: 0.0)
    }
}

extension MetricsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MetricsViewController: MetricsBottomViewDelegate {
    
    func metricsBottomViewDidTapSave(sender: Any) {
        
        guard self.selectedSection.count == self.maxSelectedElements else {
            return
        }
        
        let f1 = self.selectedSection[0].marketDataField.fieldName
        let f2 = self.selectedSection[1].marketDataField.fieldName
        let f3 = self.selectedSection[2].marketDataField.fieldName
        let f4 = self.selectedSection[3].marketDataField.fieldName
        let f5 = self.selectedSection[4].marketDataField.fieldName
        
        var f6 = ""
        if self.maxSelectedElements > 5 {
            f6 = self.selectedSection[5].marketDataField.fieldName
        }
    
        showNetworkLoader()
        if let collectionID = self.collectionID {
            UserProfileManager.shared.updateMetricsForCollection(collectionID, f1, f2, f3, f4, f5) { success in
                self.hideLoader()
                self.dismiss(animated: true) {
                    self.delegate?.didDismissMetricsViewController()
                }
            }
        } else {
            UserProfileManager.shared.updateMetricsForTicker(f1, f2, f3, f4, f5, f6) { success in
                self.hideLoader()
                self.dismiss(animated: true) {
                    self.delegate?.didDismissMetricsViewController()
                }
            }
        }
    }
}

extension MetricsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        
        let cell: TickerDetailsMarketInnerViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TickerDetailsMarketInnerViewCell.reuseIdentifier, for: indexPath) as! TickerDetailsMarketInnerViewCell
        cell.setButtonHidden(isHidden: true)
        cell.highlightSelection = true
        cell.isForceSelected = false
        
        var marketData: TickerInfo.MarketData? = nil
        if collectionView == self.searchCollectionView {
            marketData = self.searchDataSourceMetrics[indexPath.row]
            let selected = self.selectedSection.contains { item in
                item.name == marketData?.name
            }
            if selected {
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                cell.isSelected = true
            }
        } else {
            
            if let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) {
                switch metricSection {
                case .selected:
                    cell.highlightSelection = false
                    cell.isForceSelected = true
                    marketData = self.selectedSection[indexPath.row]
                case .trading:
                    marketData = self.tradingSection[indexPath.row]
                case .growth:
                    marketData = self.growthSection[indexPath.row]
                case .general:
                    marketData = self.generalSection[indexPath.row]
                case .valuation:
                    marketData = self.valuationSection[indexPath.row]
                case .momentum:
                    marketData = self.momentumSection[indexPath.row]
                case .dividend:
                    marketData = self.dividendSection[indexPath.row]
                case .earnings:
                    marketData = self.earningsSection[indexPath.row]
                case .financials:
                    marketData = self.financialsSection[indexPath.row]
                }
                
                let selected = self.selectedSection.contains { item in
                    item.name == marketData?.name
                }
                if metricSection != .selected && selected {
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                    cell.isSelected = true
                }
            }
        }
        cell.marketData = marketData
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if collectionView == self.searchCollectionView {
            return 1
        }
        return MetricsViewControllerSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.searchCollectionView {
            return self.searchDataSourceMetrics.count
        }
        
        if let metricSection = MetricsViewControllerSection.init(rawValue: section) {
            switch metricSection {
            case .selected:
                return self.selectedSection.count
            case .trading:
                return self.tradingSection.count
            case .growth:
                return self.growthSection.count
            case .general:
                return self.generalSection.count
            case .valuation:
                return self.valuationSection.count
            case .momentum:
                return self.momentumSection.count
            case .dividend:
                return self.dividendSection.count
            case .earnings:
                return self.earningsSection.count
            case .financials:
                return self.financialsSection.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(8.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return CGFloat(8.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.searchCollectionView {
            return UIEdgeInsets.init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        }
        
        if let metricSection = MetricsViewControllerSection.init(rawValue: section) {
            if metricSection != .selected && metricSection != .financials {
                return UIEdgeInsets.init(top: 0.0, left: 16.0, bottom: 32.0, right: 16.0)
            }
        }
        return UIEdgeInsets.init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if collectionView == self.searchCollectionView {
            return CGSize.init(width: collectionView.frame.size.width, height: 32.0)
        }
        
        if let metricSection = MetricsViewControllerSection.init(rawValue: section) {
            switch metricSection {
            case .selected:
                return CGSize.init(width: collectionView.frame.size.width, height: 32.0)
            case .trading:
                return CGSize.init(width: collectionView.frame.size.width, height: 80.0)
            case .growth:
                return CGSize.init(width: collectionView.frame.size.width, height: 60.0)
            case .general:
                return CGSize.init(width: collectionView.frame.size.width, height: 80.0)
            case .valuation:
                return CGSize.init(width: collectionView.frame.size.width, height: 80.0)
            case .momentum:
                return CGSize.init(width: collectionView.frame.size.width, height: 32.0)
            case .dividend:
                return CGSize.init(width: collectionView.frame.size.width, height: 80.0)
            case .earnings:
                return CGSize.init(width: collectionView.frame.size.width, height: 80.0)
            case .financials:
                return CGSize.init(width: collectionView.frame.size.width, height: 32.0)
            }
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        if collectionView == self.searchCollectionView {
            return CGSize.zero
        }
        
        if let metricSection = MetricsViewControllerSection.init(rawValue: section) {
            if metricSection == .selected {
                return CGSize.init(width: collectionView.frame.size.width, height: 102.0)
            }
        }
        return CGSize.zero
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var result: UICollectionReusableView = UICollectionReusableView.newAutoLayout()
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MetricsHeaderView.reuseIdentifier, for: indexPath) as! MetricsHeaderView
            
            if collectionView == self.searchCollectionView {
                headerView.titleLabel.text = "Search Results" // 32
                headerView.descriptionLabel.text = ""
                headerView.descriptionLabel.isHidden = true
                return headerView
            }
            
            if let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) {
                switch metricSection {
                case .selected:
                    headerView.titleLabel.text = "Selected" // 32
                    headerView.descriptionLabel.text = ""
                    headerView.descriptionLabel.isHidden = true
                case .trading:
                    headerView.titleLabel.text = "Trading" // 80
                    headerView.descriptionLabel.text = "Metrics that show trading activity over recent period\nof time."
                    headerView.descriptionLabel.isHidden = false
                case .growth:
                    headerView.titleLabel.text = "Growth" // 60
                    headerView.descriptionLabel.text = "Metrics that show how fast company grows."
                    headerView.descriptionLabel.isHidden = false
                case .general:
                    headerView.titleLabel.text = "General information" // 80
                    headerView.descriptionLabel.text = "Metrics that show basic information about a company\nor a coin."
                    headerView.descriptionLabel.isHidden = false
                case .valuation:
                    headerView.titleLabel.text = "Valuation" // 80
                    headerView.descriptionLabel.text = "Metrics that help to see how pricey the stock is based\non a multiplier. Usually, lower is better."
                    headerView.descriptionLabel.isHidden = false
                case .momentum:
                    headerView.titleLabel.text = "Momentum" // 32
                    headerView.descriptionLabel.text = ""
                    headerView.descriptionLabel.isHidden = true
                case .dividend:
                    headerView.titleLabel.text = "Dividends" // 80
                    headerView.descriptionLabel.text = "Dividend metrics are very important metrics for large\norganizations and stable organizations."
                    headerView.descriptionLabel.isHidden = false
                case .earnings:
                    headerView.titleLabel.text = "Earnings" // 80
                    headerView.descriptionLabel.text = "Metrics that show how successfully a company\nmade last earnings results. "
                    headerView.descriptionLabel.isHidden = false
                case .financials:
                    headerView.titleLabel.text = "Financials" // 32
                    headerView.descriptionLabel.text = ""
                    headerView.descriptionLabel.isHidden = true
                }
            }
            
            result = headerView
        case UICollectionView.elementKindSectionFooter:
            if collectionView == self.searchCollectionView {
                return result
            }
            if let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) {
                if metricSection == .selected {
                    let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MetricsFooterView.reuseIdentifier, for: indexPath) as! MetricsFooterView
                    footerView.textLabel.text = "To pin another Market Data metrics — select items\nbelow. You can pin only \(self.maxSelectedElements) items."
                    result = footerView
                }
            }
        default: fatalError("Unhandlad behaviour")
        }
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView == self.searchCollectionView {
            return true
        }
        
        if let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) {
            if metricSection == .selected {
                return false
            }
        }
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView == self.searchCollectionView {
            if self.selectedSection.count >= self.maxSelectedElements {
                return false
            }
            return true
        }
        
        if let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) {
            if metricSection == .selected {
                return false
            }
            
            if self.selectedSection.count >= self.maxSelectedElements {
                return false
            }
        }
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var marketData: TickerInfo.MarketData? = nil
        if collectionView == self.searchCollectionView {
            marketData = self.searchDataSourceMetrics[indexPath.row]
        } else {
            guard let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) else {
                return
            }
            switch metricSection {
            case .trading:
                marketData = self.tradingSection[indexPath.row]
            case .growth:
                marketData = self.growthSection[indexPath.row]
            case .general:
                marketData = self.generalSection[indexPath.row]
            case .valuation:
                marketData = self.valuationSection[indexPath.row]
            case .momentum:
                marketData = self.momentumSection[indexPath.row]
            case .dividend:
                marketData = self.dividendSection[indexPath.row]
            case .earnings:
                marketData = self.earningsSection[indexPath.row]
            case .financials:
                marketData = self.financialsSection[indexPath.row]
            default: break
            }
        }
        
        if let marketData = marketData {
            self.selectedSection.append(marketData)
            if isSearching {
                self.collectionView.reloadData()
            } else {
                self.collectionView.reloadSections(IndexSet.init(integer: 0))
            }
            
            GainyAnalytics.logEvent("metrics_settings_selected", params: ["name" : marketData.name, "field" : marketData.marketDataField.fieldName, "ec" : "MetricsViewController"])
        }
        self.bottomView?.setSaveButtonHidden(hidden: self.selectedSection.count < self.maxSelectedElements)
        self.updateBottomViewPosition()
        
        if self.selectedSection.count == self.maxSelectedElements && isSearching {
            self.textFieldClear()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        var marketData: TickerInfo.MarketData? = nil
        if collectionView == self.searchCollectionView {
            marketData = self.searchDataSourceMetrics[indexPath.row]
        } else {
            guard let metricSection = MetricsViewControllerSection.init(rawValue: indexPath.section) else {
                return
            }
            
            switch metricSection {
            case .trading:
                marketData = self.tradingSection[indexPath.row]
            case .growth:
                marketData = self.growthSection[indexPath.row]
            case .general:
                marketData = self.generalSection[indexPath.row]
            case .valuation:
                marketData = self.valuationSection[indexPath.row]
            case .momentum:
                marketData = self.momentumSection[indexPath.row]
            case .dividend:
                marketData = self.dividendSection[indexPath.row]
            case .earnings:
                marketData = self.earningsSection[indexPath.row]
            case .financials:
                marketData = self.financialsSection[indexPath.row]
            default: break
            }
        }
        
        if let marketData = marketData {
            self.selectedSection.removeAll { item in
                item.name == marketData.name
            }
            if isSearching {
                self.collectionView.reloadData()
                collectionView.reloadItems(at: [indexPath])
            } else {
                self.collectionView.reloadSections(IndexSet.init(integer: 0))
            }
        }
        self.bottomView?.setSaveButtonHidden(hidden: self.selectedSection.count < self.maxSelectedElements)
        self.updateBottomViewPosition()
//        GainyAnalytics.logEvent("personalization_deselect_interest", params: ["interest_id" : interest.id, "interest_name" : interest.name, "sn": String(describing: self).components(separatedBy: ".").last!, "ec" : "PersonalizationPickInterests"])
    }
}

extension MetricsViewController: UICollectionViewDragDelegate {
    func collectionView(
        _: UICollectionView,
        itemsForBeginning _: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        switch indexPath.section {
        case 0:
            let item = self.selectedSection[indexPath.row]
            // swiftlint:disable legacy_objc_type
            let itemProvider = NSItemProvider(object: item.name as NSString)
            // swiftlint:enable legacy_objc_type
            let dragItem = UIDragItem(itemProvider: itemProvider)

            return [dragItem]
        default:
            return []
        }
    }
    
    func collectionView(
        _: UICollectionView,
        dragSessionIsRestrictedToDraggingApplication _: UIDragSession
    ) -> Bool {
        true
    }
    
    func collectionView(
        _: UICollectionView,
        dragPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: itemWidth,
                height: itemHeight
            ),
            cornerRadius: 8
        )
        previewParams.visiblePath = path
        
        return previewParams
    }
}

extension MetricsViewController: UICollectionViewDropDelegate {
    func collectionView(_: UICollectionView,
                        performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        if coordinator.proposal.operation == .move {
            let draggedItems = coordinator.items
            guard let item = draggedItems.first, let sourceIndexPath = item.sourceIndexPath else {
                return
            }
            
            UIView.setAnimationsEnabled(false)
            collectionView.moveItem(at: sourceIndexPath, to: destinationIndexPath)
            coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            if sourceIndexPath.row < destinationIndexPath.row {
                for i in sourceIndexPath.row..<destinationIndexPath.row {
                    self.selectedSection.swapAt(i, i+1)
                }
            } else {
                for i in (destinationIndexPath.row..<sourceIndexPath.row).reversed() {
                    self.selectedSection.swapAt(i+1, i)
                }
            }
            collectionView.reloadSections(IndexSet.init(integer: 0))
            UIView.setAnimationsEnabled(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath _: IndexPath?) -> UICollectionViewDropProposal {
        let dragItemLocation = session.location(in: collectionView)
        var dragItemIndexPath: IndexPath?
        
        collectionView.performUsingPresentationValues {
            dragItemIndexPath = collectionView.indexPathForItem(at: dragItemLocation)
        }
        
        guard let destination = dragItemIndexPath else {
            return UICollectionViewDropProposal(
                operation: .cancel,
                intent: .unspecified
            )
        }
        
        guard destination.section == DiscoverCollectionsSection.yourCollections.rawValue else {
            return UICollectionViewDropProposal(
                operation: .cancel,
                intent: .unspecified
            )
        }
        
        return UICollectionViewDropProposal(
            operation: .move,
            intent: .insertAtDestinationIndexPath
        )
    }
    
    func collectionView(
        _: UICollectionView,
        dropPreviewParametersForItemAt _: IndexPath
    ) -> UIDragPreviewParameters? {
        let previewParams = UIDragPreviewParameters()
        
        let path = UIBezierPath(
            roundedRect: CGRect(
                x: 0,
                y: 0,
                width: itemWidth,
                height: itemHeight
            ),
            cornerRadius: 8
        )
        previewParams.visiblePath = path
        
        return previewParams
    }
}
