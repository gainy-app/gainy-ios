//
//  DWOrderOverviewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon

final class DWOrderOverviewController: DWBaseViewController {
            
    var amount: Double = 0.0
    var collectionId: Int = 0
    var name: String = ""
    var mode: DWOrderInputMode = .invest
    var type: DWOrderProductMode = .ttf
    
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
        case .invest:
            compositionLbl.text = "TTF Purchase Composition"
            closeMessage = "Are you sure want to stop investing?"
        case .buy:
            compositionLbl.text = "TTF Purchase Composition"
            closeMessage = "Are you sure want to stop buying?"
        case .sell:
            compositionLbl.text = "TTF Sell Composition"
            closeMessage = "Are you sure want to stop selling?"
        }
        
        titleLbl.text = "Order Overview"
        showNetworkLoader()
        Task {
            do {
                stocks = try await dwAPI.getTTFCompositionWeights(collectionId: collectionId)
                let accountNumber = await userProfile.getProfileStatus()
                await MainActor.run {
                    stockTableHeight.constant = CGFloat(stocks.count) * cellHeight
                    stocksTable.reloadData()
                    kycAccountLbl.text = accountNumber?.accountNo
                    hideLoader()
                }
            } catch {
                await MainActor.run {
                    kycAccountLbl.text = ""
                    showAlert(message: "\(error.localizedDescription)")
                    hideLoader()
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func transferAction(_ sender: UIButton) {
        showNetworkLoader()
        sender.isEnabled = false
        switch mode {
        case .invest:
            sender.isEnabled = false
            Task {
                do {
                    let res = try await dwAPI.reconfigureHolding(collectionId: collectionId, amountDelta: amount)
                    await MainActor.run {
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name, type: type)
                        GainyAnalytics.logEvent("dw_invest_done", params: ["amount" : amount, "collectionId" : collectionId])
                        NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["ttfId" : collectionId])
                        userProfile.resetKycStatus()
                    }
                } catch {
                    await MainActor.run {
                        showAlert(message: "\(error.localizedDescription)")
                        hideLoader()
                    }
                }
                await MainActor.run {
                    sender.isEnabled = true
                    hideLoader()
                }
            }
        case .buy:
            
            sender.isEnabled = false
            Task {
                do {
                    let res = try await dwAPI.reconfigureHolding(collectionId: collectionId, amountDelta: amount)
                    await MainActor.run {
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name, type: type)
                        GainyAnalytics.logEvent("dw_buy_done", params: ["amount" : amount, "collectionId" : collectionId])
                        NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["ttfId" : collectionId])
                        userProfile.resetKycStatus()
                    }
                } catch {
                    await MainActor.run {
                        showAlert(message: "\(error.localizedDescription)")
                        hideLoader()
                    }
                }
                await MainActor.run {
                    sender.isEnabled = true
                    hideLoader()
                }
            }
            break
        case .sell:
            sender.isEnabled = false
            Task {
                do {
                    let res = try await dwAPI.reconfigureHolding(collectionId: collectionId, amountDelta: -amount)
                    await MainActor.run {
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name, mode: .sell, type: type)
                        GainyAnalytics.logEvent("dw_sell_done", params: ["amount" : amount, "collectionId" : collectionId])
                        NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["ttfId" : collectionId])
                        userProfile.resetKycStatus()
                    }
                } catch {
                    await MainActor.run {
                        showAlert(message: "\(error.localizedDescription)")
                        hideLoader()
                    }
                }
                await MainActor.run {
                    sender.isEnabled = true
                    hideLoader()
                }
            }
            break
        }
        
        
    }
}

extension DWOrderOverviewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DWOrderStockCompositionCell = tableView.dequeueReusableCell(withIdentifier: "DWOrderStockCompositionCell", for: indexPath) as! DWOrderStockCompositionCell
        cell.data = (amount, stocks[indexPath.row])
        return cell
    }
}
