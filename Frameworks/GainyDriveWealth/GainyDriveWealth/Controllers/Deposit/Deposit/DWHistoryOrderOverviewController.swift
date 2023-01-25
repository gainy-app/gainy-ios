//
//  DWHistoryOrderOverviewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 30.11.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

public enum DWHistoryOrderMode {
    case buy(history: GainyTradingHistory), sell(history: GainyTradingHistory), other(history: GainyTradingHistory)
}

final class DWHistoryOrderOverviewController: DWBaseViewController {
            
    var amount: Double = 0.0
    var name: String = ""
        
    var mode: DWHistoryOrderMode = .other(history: GainyTradingHistory.init())
    var type : DWOrderProductMode = .ttf
    
    @IBOutlet private weak var orderLbl: UILabel! {
        didSet {
            orderLbl.font = UIFont.compactRoundedSemibold(14)
            orderLbl.setKern()
        }
    }
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    @IBOutlet private var labels: [UILabel]! {
        didSet {
            labels.forEach({$0.font = .proDisplaySemibold(16)})
        }
    }
    @IBOutlet private weak var initDateLbl: UILabel!
    @IBOutlet private weak var statusLbl: UILabel!
    @IBOutlet private weak var feeLbl: UILabel!
    @IBOutlet private weak var amountLbl: UILabel!
    @IBOutlet private weak var compositionLbl: UILabel! {
        didSet {
            compositionLbl.font = UIFont.proDisplaySemibold(20)
        }
    }
    @IBOutlet private weak var stockTableHeight: NSLayoutConstraint!
    @IBOutlet private weak var stocksTable: UITableView! {
        didSet {
            stocksTable.dataSource = self
        }
    }
    @IBOutlet private weak var accountLbl: UILabel!
    
    @IBOutlet private weak var kycAccountLbl: UILabel!
    private enum TopMargin: CGFloat {
        case main = 64.0
        case history = 80.0
    }
    
    @IBOutlet private weak var mainStackTopMargin: NSLayoutConstraint!
    @IBOutlet private weak var tagsStack: UIStackView!
    
    @IBOutlet weak var cancelBtn: GainyButton! {
        didSet {
            cancelBtn.configureWithTitle(title: "Cancel order", color: UIColor.white, state: .normal)
        }
    }
    @IBOutlet weak var cancelView: UIView!
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadState()
        if navigationController?.viewControllers.count ?? 0 > 1 {
            self.gainyNavigationBar.configureWithItems(items: [.back])
        } else {
            self.gainyNavigationBar.configureWithItems(items: [.close])
        }
        self.gainyNavigationBar.backActionHandler = {[weak self] sender in
            self?.coordinator?.pop()
        }
        self.gainyNavigationBar.closeActionHandler = {[weak self] sender in
            self?.dismiss(animated: true)
        }
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private var stocks: [TTFStockCompositionData] = []
    private let cellHeight: CGFloat = 64.0
    
    private func loadState() {
        
        cancelView.isHidden = true
        amountLbl.text = abs(amount).price
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        switch mode {
        case .buy(let history):
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            labels[0].text = "Paid with"
            loadTags(tagsMap: history.tags ?? [:])
            if history.isTTF {
                kycAccountLbl.text = history.tradingCollectionVersion?.tradingAccount.accountNo ?? ""
            } else {
                kycAccountLbl.text = history.tradingOrder?.tradingAccount.accountNo ?? ""
            }
            
            initDateLbl.text = AppDateFormatter.shared.string(from: history.date, dateFormat: .hhmmMMMddyyyy).uppercased()
            loadWeights(history: history)
            checkCancel(history)
            compositionLbl.isHidden = history.isStock
            break
        case .sell(let history):
            titleLbl.text = "You’ve sold \(abs(amount).price) from \(name)"
            labels[0].text = "Paid with"
            loadTags(tagsMap: history.tags ?? [:])
            if history.isTTF {
                kycAccountLbl.text = history.tradingCollectionVersion?.tradingAccount.accountNo ?? ""
            } else {
                kycAccountLbl.text = history.tradingOrder?.tradingAccount.accountNo ?? ""
            }
            initDateLbl.text = AppDateFormatter.shared.string(from: history.date, dateFormat: .hhmmMMMddyyyy).uppercased()
            loadWeights(history: history)
            compositionLbl.text = "TTF Sell Composition"
            checkCancel(history)
            compositionLbl.isHidden = history.isStock
            break
        case .other(let history):
            titleLbl.text = "\(history.name ?? "")"
            labels[0].text = "Paid with"
            loadTags(tagsMap: history.tags ?? [:])
            kycAccountLbl.text = history.tradingMoneyFlow?.tradingAccount.accountNo ?? ""
            initDateLbl.text = AppDateFormatter.shared.string(from: history.date, dateFormat: .hhmmMMMddyyyy).uppercased()
            compositionLbl.isHidden = true
            checkCancel(history)
            break
        }
    }
    
    /// Load TTF stock composition
    /// - Parameter history: history item
    private func loadWeights(history: GainyTradingHistory) {
        stocks.removeAll()
        if let weights = history.tradingCollectionVersion?.weights {
            for symbol in Array(weights.keys) {
                stocks.append(TTFStockCompositionData(symbol: symbol,
                                                      weight:Double(weights[symbol] as? String ?? "") ?? 0.0))
            }
        }
        stockTableHeight.constant = CGFloat(stocks.count) * cellHeight
        stocksTable.reloadData()
    }
    
    private func checkCancel(_ history: GainyTradingHistory) {
        if history.isCancellable {
            cancelView.isHidden = false
            stockTableHeight.constant = 0.0
            compositionLbl.text = ""
        }
    }
        
    
    private var tags: [Tags] = []
    private var stateTags: [Tags] = []
    
    /// Load tags from History
    /// - Parameter tagsMap: Tags from history.tags
    private func loadTags(tagsMap: [String: Any]) {
        let typeKeys = TradeTags.TypeKey.allCases.compactMap({$0.rawValue})
        let stateKeys = TradeTags.StateKey.allCases.compactMap({$0.rawValue})
        
        tagsStack.arrangedSubviews.forEach({
            tagsStack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        })
        tags.removeAll()
        stateTags.removeAll()
        
        for key in typeKeys {
            if let tag = tagsMap[key] as? Bool, tag == true, let tag = Tags(rawValue: key) {
                tags.append(tag)
            }
        }
        
        for key in stateKeys {
            if let tag = tagsMap[key] as? Bool, tag == true, let tag = Tags(rawValue: key) {
                stateTags.append(tag)
            }
        }
        updateStatus(tags: stateTags)
        
        if tags.isEmpty {
            mainStackTopMargin.constant = TopMargin.main.rawValue
        } else {
            mainStackTopMargin.constant = TopMargin.history.rawValue
            tags = tags.sorted()
            for tag in tags {
                let tagView = TagLabelView()
                tagView.tagText = tag.rawValue.uppercased()
                tagView.textColor = UIColor(hexString: tag.tagColor)
                tagsStack.addArrangedSubview(tagView)
            }
        }
        
    }
    
    private func updateStatus(tags: [Tags]) {
        if tags.contains(where: { $0 == .pending }) {
            statusLbl.text = "Pending"
            statusLbl.textColor = UIColor(hexString: "#FCB224")
            return
        }
        
        if tags.contains(where: { $0 == .cancelled }) {
            statusLbl.text = "Cancelled"
            statusLbl.textColor = UIColor(hexString: "#FCB224")
            return
        }
        
        if tags.contains(where: { $0 == .error }) {
            statusLbl.text = "Error"
            statusLbl.textColor = UIColor.Gainy.mainRed
            return
        }
        
        statusLbl.text = "Completed"
        statusLbl.textColor = UIColor(hexString: "#38CF92")
        
    }
    
    //MARK: - Actions
    
    @IBAction func cancelAction() {
        switch mode {
        case .buy(let history):
            handleHistoryItemCancel(history)
            break
        case .sell(let history):
            handleHistoryItemCancel(history)
            break
        case .other(let history):
            handleHistoryItemCancel(history)
            break
        }
    }
    
    private func handleHistoryItemCancel(_ history: GainyTradingHistory) {
        showNetworkLoader()
        if history.isTTF {
            GainyAnalytics.logEvent("dw_order_cancel", params: ["id" : history.tradingCollectionVersion?.id ?? -1, "type" : "ttf"])
            Task {
                let accountNumber = await dwAPI.cancelTTFOrder(versionID: history.tradingCollectionVersion?.id ?? -1)
                await MainActor.run {
                    userProfile.resetKycStatus()
                    NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["name" : name])
                    hideLoader()
                    closeView()
                }
            }
            return
        }
        
        if history.isStock {
            GainyAnalytics.logEvent("dw_order_cancel", params: ["id" : history.tradingOrder?.id ?? -1, "type" : "stock"])
            Task {
                let accountNumber = await dwAPI.cancelStockOrder(orderId: history.tradingOrder?.id ?? -1)
                await MainActor.run {
                    userProfile.resetKycStatus()
                    NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["name" : name])
                    hideLoader()
                    closeView()
                }
            }
            return
        }
    }
    
    fileprivate func closeView() {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            self.coordinator?.pop()
        } else {
            dismiss(animated: true)
        }
    }
}

extension DWHistoryOrderOverviewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DWOrderStockCompositionCell = tableView.dequeueReusableCell(withIdentifier: "DWOrderStockCompositionCell", for: indexPath) as! DWOrderStockCompositionCell
        cell.data = (abs(amount), stocks[indexPath.row])
        return cell
    }
}
