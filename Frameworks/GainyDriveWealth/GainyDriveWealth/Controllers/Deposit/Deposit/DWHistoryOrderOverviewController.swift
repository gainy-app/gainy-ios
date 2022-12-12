//
//  DWHistoryOrderOverviewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 30.11.2022.
//

import UIKit
import GainyCommon
import SwiftHEXColors

final class DWHistoryOrderOverviewController: DWBaseViewController {
            
    var amount: Double = 0.0
    var collectionId: Int = 0
    var name: String = ""
    
    enum Mode {
        case buy(history: GainyTradingHistory), sell(history: GainyTradingHistory), other(history: GainyTradingHistory)
    }
    var mode: Mode = .other(history: GainyTradingHistory.init())
    
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
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadState()
        self.gainyNavigationBar.configureWithItems(items: [.close, .back])
        self.gainyNavigationBar.backActionHandler = {[weak self] sender in
            self?.coordinator?.pop()
        }
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "hh:mm, MMM dd, yyyy"
        return dt
    }()
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private var stocks: [TTFStockCompositionData] = []
    private let cellHeight: CGFloat = 64.0
    
    private func loadState() {
        
        amountLbl.text = amount.price
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        switch mode {
        case .buy(let history):
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            labels[0].text = "Paid with"
            loadTags(tagsMap: history.tags ?? [:])
            kycAccountLbl.text = history.tradingCollectionVersion?.tradingAccount.accountNo ?? ""
            initDateLbl.text = dateFormatter.string(from: history.date).uppercased()
            loadWeights(history: history)
            break
        case .sell(let history):
            titleLbl.text = "You’ve sold \(amount.price) from \(name)"
            labels[0].text = "Paid with"
            loadTags(tagsMap: history.tags ?? [:])
            kycAccountLbl.text = history.tradingCollectionVersion?.tradingAccount.accountNo ?? ""
            initDateLbl.text = dateFormatter.string(from: history.date).uppercased()
            loadWeights(history: history)
            break
        case .other(let history):
            titleLbl.text = "\(history.name ?? "")"
            labels[0].text = "Paid with"
            loadTags(tagsMap: history.tags ?? [:])
            kycAccountLbl.text = history.tradingMoneyFlow?.tradingAccount.accountNo ?? ""
            initDateLbl.text = dateFormatter.string(from: history.date).uppercased()
            compositionLbl.isHidden = true
            break
        }
    }
    
    private func loadWeights(history: GainyTradingHistory) {
        if let weights = history.tradingCollectionVersion?.weights {
            for symbol in Array(weights.keys) {
                stocks.append(TTFStockCompositionData(symbol: symbol,
                                                      weight:Double(weights[symbol] as? String ?? "") ?? 0.0))
            }
        }
        stockTableHeight.constant = CGFloat(stocks.count) * cellHeight
        stocksTable.reloadData()
    }
        
    
    private var tags: [DWHistoryTag] = []
    
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
        
        for key in typeKeys {
            if let tag = tagsMap[key] as? Bool, tag == true {
                tags.append(DWHistoryTag.init(name: key.uppercased()))
            }
        }
        
        for key in stateKeys {
            if let tag = tagsMap[key] as? Bool, tag == true {
                tags.append(DWHistoryTag.init(name: key.uppercased()))
            }
        }
        updateStatus(tags: tags)
        
        if tags.isEmpty {
            mainStackTopMargin.constant = TopMargin.main.rawValue
        } else {
            mainStackTopMargin.constant = TopMargin.history.rawValue
            for tag in tags {
                let tagView = TagLabelView()
                tagView.tagText = tag.name
                tagView.textColor = UIColor(hexString: tag.colorForTag() ?? "")
                tagsStack.addArrangedSubview(tagView)
            }
        }
    }
    
    private func updateStatus(tags: [DWHistoryTag]) {
        if tags.contains(where: {$0.name.lowercased() == "pending"}) {
            statusLbl.text = "Pending"
            statusLbl.textColor = UIColor(hexString: "#FCB224")
            return
        }
        
        if tags.contains(where: {$0.name.lowercased() == "cancelled"}) {
            statusLbl.text = "Cancelled"
            statusLbl.textColor = UIColor(hexString: "#FCB224")
            return
        }
        
        if tags.contains(where: {$0.name.lowercased() == "error"}) {
            statusLbl.text = "Error"
            statusLbl.textColor = UIColor.Gainy.mainRed
            return
        }
        
        statusLbl.text = "Completed"
        statusLbl.textColor = UIColor(hexString: "#38CF92")
        
    }
   
}

extension DWHistoryOrderOverviewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DWOrderStockCompositionCell = tableView.dequeueReusableCell(withIdentifier: "DWOrderStockCompositionCell", for: indexPath) as! DWOrderStockCompositionCell
        cell.data = (amount, stocks[indexPath.row])
        return cell
    }
}
