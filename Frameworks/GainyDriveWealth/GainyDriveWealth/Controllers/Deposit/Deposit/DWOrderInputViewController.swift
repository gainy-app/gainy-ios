//
//  DWOrderInputViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon
import Combine

enum DWOrderInputMode {
    case invest, buy, sell
}

public enum DWOrderProductMode: String {
    case ttf, stock, etf
}

final class DWOrderInputViewController: DWBaseViewController {
    
    var collectionId: Int = 0
    var symbol: String = ""
    var name : String = ""
    
    var mode: DWOrderInputMode = .invest
    var type: DWOrderProductMode = .ttf
    private var amount = Amount()
    
    var availableAmount: Double = 0.0
    
    //MARK: - Outlets
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    
    @IBOutlet private weak var subTitleLbl: UILabel! {
        didSet {
            subTitleLbl.font = UIFont.proDisplaySemibold(16)
        }
    }
    
    @IBOutlet private weak var amountFlv: UITextField! {
        didSet {
            amountFlv.font = .proDisplayBold(48)
            amountFlv.isEnabled = false
        }
    }
    
    @IBOutlet private weak var padView: GainyPadView! {
        didSet {
            padView.delegate = self
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Invest", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Invest", color: UIColor.white, state: .disabled)
            validateAmount()
        }
    }
    @IBOutlet private weak var sellAllView: UIStackView!
    @IBOutlet private weak var sellAllBtn: GainyButton! {
        didSet {
            sellAllBtn.layer.borderWidth = 0.0
            sellAllBtn.setTitle("Deposit", for: .normal)
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.publisher(for: Notification.Name.init("dwBalanceUpdatedNotification"))
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self else {return}
                self.loadState()
                
                if !(self.coordinator?.childCoordinators.isEmpty ?? true) {
                    self.coordinator?.navController.dismiss(animated: true)
                    self.coordinator?.removeChildCoordinators()
                }
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadState()
    }
    
    private var localKyc: GainyKYCStatus? {
        didSet {
            if let localKyc {
                switch mode {
                case .invest:
                    subTitleLbl.text = "Buying power \((localKyc.buyingPower ?? 0.0).round(to: 2).priceUnchecked)"
                case .buy:
                    subTitleLbl.text = "Available \((localKyc.buyingPower ?? 0.0).round(to: 2).priceUnchecked)"
                case .sell:
                    subTitleLbl.text = "Available \(availableAmount.round(to: 2).priceUnchecked)"
                }
            } else {
                subTitleLbl.text = "No funds to invest"
            }
        }
    }
    
    private func loadState() {
        amountFlv.text = "$"
        
        switch mode {
        case .invest:
            titleLbl.text = "How much would you like to invest?"
            nextBtn.configureWithTitle(title: "Invest", color: UIColor.white, state: .normal)
            GainyAnalytics.logEvent("dw_invest_s", params: ["type" : type.rawValue])
            closeMessage = "Are you sure want to stop invest?"
            sellAllView.isHidden = false
            sellAllBtn.setTitleColor(UIColor(hexString: "#0062FF")!, for: .normal)
            sellAllBtn.backgroundColor = UIColor.init(hexString: "#E7EAEE")
            sellAllBtn.shouldUpdateBG = false
        case .buy:
            titleLbl.text = "How much would you like to buy?"
            nextBtn.configureWithTitle(title: "Buy", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Buy", color: UIColor.white, state: .disabled)
            GainyAnalytics.logEvent("dw_buy_s", params: ["type" : type.rawValue])
            closeMessage = "Are you sure want to stop buying?"
            sellAllView.isHidden = false
            sellAllBtn.setTitleColor(UIColor(hexString: "#0062FF")!, for: .normal)
            sellAllBtn.backgroundColor = UIColor.init(hexString: "#E7EAEE")
            sellAllBtn.shouldUpdateBG = false
        case .sell:
            sellAllView.isHidden = false
            titleLbl.text = "How much would you like to sell?"
            nextBtn.configureWithTitle(title: "Sell", color: UIColor.white, state: .normal)
            nextBtn.configureWithTitle(title: "Sell", color: UIColor.white, state: .disabled)
            GainyAnalytics.logEvent("dw_sell_s", params: ["type" : type.rawValue])
            closeMessage = "Are you sure want to stop selling?"
            sellAllBtn.configureWithTitle(title: "Sell all", color: UIColor.white, state: .normal)
            sellAllBtn.configureWithTitle(title: "Sell all", color: UIColor(hexString: "#0062FF")!, state: .disabled)
            sellAllBtn.isEnabled = true
        }
        
        showNetworkLoader()
        Task {
            localKyc = await userProfile.getProfileStatus()
            hideLoader()
        }
    }
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
    
    //MARK: - Actions
    
    @IBAction func reviewAction(_ sender: Any) {
        proceedToPayment()
    }
    
    @IBAction func sellAllAction(_ sender: Any) {
        if mode == .sell {
            if type == .ttf {
                coordinator?.showOrderOverview(amount: availableAmount, collectionId: collectionId, name: name, mode: .sell, type: type, sellAll: true)
                GainyAnalytics.logEventAMP("sell_e", params: ["amount" : availableAmount, "collectionID" : collectionId, "tickerSymbol" : "none", "productType" : "ttf", "isSellAll" : true])
            } else {
                coordinator?.showStockOrderOverview(amount: availableAmount, symbol: symbol, name: name, mode: .sell, type: type, sellAll: true)
                GainyAnalytics.logEventAMP("sell_e", params: ["amount" : availableAmount, "collectionID" : "none", "tickerSymbol" : symbol, "productType" : "stock", "isSellAll" : true])
            }
        } else {
            //Deposit?!
            let buyingPower = Double(localKyc?.buyingPower ?? 0.0).round(to: 2)
            if let amount = amount.val {
                let dif: Double = abs(amount - buyingPower)
                coordinator?.start(.depositAmount(value: dif.rounded(.up)))
            } else {
                coordinator?.start(.depositAmount(value: 0.0))
            }
            GainyAnalytics.logEventAMP("deposit_s", params: ["location" : "invest"])            
            AnalyticsKeysHelper.shared.fundingAccountSource = "deposit_screen"
        }
    }
    
    ///  Payment validation
    private func proceedToPayment() {
        
        let buyingPower = Double(localKyc?.buyingPower ?? 0.0).round(to: 2)
        
        guard var amount = amount.val else  {
            showAlert(message: "Amount must not be empty")
            return
        }
        if mode != .sell {
            guard amount >= minInvestAmount else {
                showAlert(message: "Amount must be greater than or equal to $\(minInvestAmount)")
                return
            }
        }
        
        if mode == .invest || mode == .buy {
            guard buyingPower > 0.0 else {
                showAlert(message: "Not enough balance to \(mode == .invest ? "invest" : "buy"). Deposit amount to fill the requirements.")
                return
            }
            guard abs(buyingPower - amount) < 0.001 || buyingPower >= amount  else {
                showAlert(message: "Not enough balance to \(mode == .invest ? "invest" : "buy"). Deposit amount to fill the requirements.")
                return
            }
        } else {
            guard amount <= availableAmount else {
                showAlert(message: "You can't sell more than you have...")
                return
            }
        }
        
        //Move all if matches
        if abs(buyingPower - amount) < 0.001 {
            amount = Double(localKyc?.buyingPower ?? 0.0)
        }
        
        if type == .ttf {
            switch mode {
            case .invest:
                coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .invest, type: type)
                GainyAnalytics.logEventAMP("invest_e", params: ["amount" : amount, "collectionID" : collectionId, "tickerSymbol" : "none", "productType" : type.rawValue])
            case .buy:
                coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .buy, type: type)
                GainyAnalytics.logEventAMP("buy_e", params: ["amount" : amount, "collectionID" : collectionId, "tickerSymbol" : "none", "productType" : type.rawValue])
                break
            case .sell:
                coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .sell, type: type)
                GainyAnalytics.logEventAMP("sell_e", params: ["amount" : amount, "collectionID" : collectionId, "tickerSymbol" : "none", "productType" : type.rawValue, "isSellAll" : false])
                break
            }
        } else {
            switch mode {
            case .invest:
                coordinator?.showStockOrderOverview(amount: amount, symbol: symbol, name: name, mode: .invest, type: type)
                GainyAnalytics.logEventAMP("invest_e", params: ["amount" : amount, "collectionID" : "none", "tickerSymbol" : symbol, "productType" : type.rawValue])
            case .buy:
                coordinator?.showStockOrderOverview(amount: amount, symbol: symbol, name: name, mode: .buy, type: type)
                GainyAnalytics.logEventAMP("buy_e", params: ["amount" : amount, "collectionID" : "none", "tickerSymbol" : symbol, "productType" : type.rawValue])
                break
            case .sell:
                coordinator?.showStockOrderOverview(amount: amount, symbol: symbol, name: name, mode: .sell, type: type)
                GainyAnalytics.logEventAMP("sell_e", params: ["amount" : amount, "collectionID" : "none", "tickerSymbol" : symbol, "productType" : type.rawValue, "isSellAll" : false])
                break
            }
        }
    }
}

extension DWOrderInputViewController: GainyPadViewDelegate {
    func deleteDigit(view: GainyPadView) {
        guard amountFlv.text!.count > 1 else {return}
        amount.deleteDigit()
        validateAmount()
    }
    
    func addDigit(digit: String, view: GainyPadView) {
        amount.addDigit(digit: digit)
        validateAmount()
    }
    
    func validateAmount() {
        nextBtn.isEnabled = amount.val != nil
        amountFlv.text = amount.valStr
        
        //Balance check for Buy
        guard mode == .invest || mode == .buy else {return}
        if let entered = amount.val {
            if Float(entered) > (localKyc?.buyingPower ?? 0.0).round(to: 2) {
                subTitleLbl.textColor = UIColor(hexString: "#F95664")
                nextBtn.isEnabled = false
                sellAllBtn.setTitleColor(UIColor.white, for: .normal)
                sellAllBtn.backgroundColor = UIColor.init(hexString: "#0062FF")
            } else {
                subTitleLbl.textColor = UIColor(hexString: "#B1BDC8")
                nextBtn.isEnabled = true
                sellAllBtn.setTitleColor(UIColor(hexString: "#0062FF")!, for: .normal)
                sellAllBtn.backgroundColor = UIColor.init(hexString: "#E7EAEE")
            }
        }
    }
}

