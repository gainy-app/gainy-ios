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
    var symbol: String = ""
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
            nextBtn.configureWithTitle(title: "Placing order", color: UIColor.white, state: .disabled)
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
    
    private var stocks: [TTFStockCompositionData] = []
    private let cellHeight: CGFloat = 64.0
    
    private func loadState() {
        initDateLbl.text = AppDateFormatter.shared.string(from: Date(), dateFormat: .hhmmMMMddyyyy).uppercased()
        amountLbl.text = amount.price
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        
        if type == .ttf {
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
        } else {
            switch mode {
            case .invest:
                compositionLbl.text = ""
                closeMessage = "Are you sure want to stop investing?"
            case .buy:
                compositionLbl.text = ""
                closeMessage = "Are you sure want to stop buying?"
            case .sell:
                compositionLbl.text = ""
                closeMessage = "Are you sure want to stop selling?"
            }
            stockTableHeight.constant = 0.0
        }
        
        titleLbl.text = "Order Overview"
        if type == .ttf {
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
        } else {
            showNetworkLoader()
            Task {
                do {
                    let accountNumber = await userProfile.getProfileStatus()
                    await MainActor.run {
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
    }
    
    //MARK: - Actions
    
    @IBAction func transferAction(_ sender: UIButton) {
        showNetworkLoader()
        sender.isEnabled = false
       
        if type == .ttf {
            transferTTF(sender)
        } else {
            transferStock(sender)
        }
    }
    
    fileprivate func transferTTF(_ sender: UIButton) {
        sender.isEnabled = false
        Task {
            do {
                let res = try await dwAPI.reconfigureHolding(collectionId: collectionId, amountDelta: mode == .sell ? -amount : amount)
                await MainActor.run {
                    if mode == .sell {
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name, mode: .sell, type: type)
                        GainyAnalytics.logEvent("dw_sell_done", params: ["amount" : amount, "collectionId" : collectionId, "type" : type.rawValue])
                    } else {
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name, type: type)
                        if mode == .buy {
                            GainyAnalytics.logEvent("dw_buy_done", params: ["amount" : amount, "collectionId" : collectionId, "type" : type.rawValue])
                        } else {
                            GainyAnalytics.logEvent("dw_invest_done", params: ["amount" : amount, "collectionId" : collectionId, "type" : type.rawValue])
                        }
                    }
                    
                    NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["name" : name, "ttfId" : collectionId])
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
    }
    
    fileprivate func transferStock(_ sender: UIButton) {
        sender.isEnabled = false
        Task {
            do {
                let res = try await dwAPI.stockChangeFunds(symbol: symbol, delta: mode == .sell ? -amount : amount)
                await MainActor.run {
                    if mode == .sell {
                        coordinator?.showStockOrderSpaceDone(amount: amount, symbol: symbol, name: name, type: .stock)
                        GainyAnalytics.logEvent("dw_stock_sell_done", params: ["amount" : amount, "symbol" : symbol, "type" : type.rawValue])
                    } else {
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name, type: type)
                        if mode == .buy {
                            GainyAnalytics.logEvent("dw_stock_buy_done", params: ["amount" : amount, "symbol" : symbol, "type" : type.rawValue])
                        } else {
                            GainyAnalytics.logEvent("dw_stock_invest_done", params: ["amount" : amount, "symbol" : symbol, "type" : type.rawValue])
                        }
                    }
                    
                    NotificationCenter.default.post(name:Notification.Name.init("dwTTFBuySellNotification"), object: nil, userInfo: ["name" : name, "ttfId" : collectionId])
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
