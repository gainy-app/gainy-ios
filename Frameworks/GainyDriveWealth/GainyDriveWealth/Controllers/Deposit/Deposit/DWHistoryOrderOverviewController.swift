//
//  DWHistoryOrderOverviewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 30.11.2022.
//

import UIKit
import GainyCommon

final class DWHistoryOrderOverviewController: DWBaseViewController {
            
    var amount: Double = 0.0
    var collectionId: Int = 0
    var name: String = ""
    
    enum Mode {
        case buy(tagsMap: [String : Any]), sell(tagsMap: [String : Any]), other(name: String)
    }
    var mode: Mode = .other(name: "")
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Place order", color: UIColor.white, state: .normal)
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
        initDateLbl.text = dateFormatter.string(from: Date()).uppercased()
        amountLbl.text = amount.price
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        
        switch mode {
        case .buy(let tagsMap):
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            labels[0].text = "Paid with"
            loadTags(tagsMap: tagsMap)
            break
        case .sell(let tagsMap):
            titleLbl.text = "You’ve sold \(amount.price) from \(name)"
            labels[0].text = "Paid with"
            loadTags(tagsMap: tagsMap)
            break
        case .other(let name):
            titleLbl.text = "\(name)"
            labels[0].text = "Paid with"
            break
        }
    }
    
    private var tags: [DWHistoryTag] = []
    
    /// Load tags from History
    /// - Parameter tagsMap: Tags from history.tags
    private func loadTags(tagsMap: [String: Any]) {
        let typeKeys = [
        "deposit",
        "withdraw",
        "fee",
        "buy",
        "sell"
        ]
        let stateKeys = [
        "pending",
        "error",
        "cancelled"
        ]
        
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

