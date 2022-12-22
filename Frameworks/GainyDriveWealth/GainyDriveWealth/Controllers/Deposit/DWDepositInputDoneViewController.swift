//
//  DWDepositInputDoneViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import UIKit
import GainyCommon
import GainyAPI

final class DWDepositInputDoneViewController: DWBaseViewController {
        
    
    var amount: Double = 0.0
    var mode: DWDepositMode = .deposit
    var tradingFlowId: Int = 0
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplayBold(32)
        }
    }
    
    @IBOutlet private weak var infoLbl: UILabel! {
        didSet {
            infoLbl.font = UIFont.proDisplayMedium(16)
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Done", color: UIColor.white, state: .normal)
        }
    }
    
    @IBOutlet private weak var detailsBtn: UIButton! {
        didSet {
            detailsBtn.titleLabel?.font = .proDisplayRegular(16)
            detailsBtn.layer.cornerRadius = 18.0
            detailsBtn.clipsToBounds = true
        }
    }
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadState()
        checkDetails()
    }
    
    private func loadState() {
        switch mode {
            case .deposit:
                titleLbl.text = "Congratulations! You’ve initiated a deposit"
                infoLbl.text = "We can’t wait to credit your $\(amount) deposit, but it won’t initiate until your investing application is approved.\n\nPlease make sure to have a balance of $\(amount) in your bank account until the transfer is complete to avoid any issues."
                GainyAnalytics.logEvent("dw_deposit_done", params: ["amount" : amount])
            case .withdraw:
                titleLbl.text = "Congratulations! You’ve initiated a withdrawal"
                infoLbl.text = "We can’t wait to perform your $\(amount) withdraw, but it won’t initiate until your investing application is approved.\n\nPlease make sure to have a balance of $\(amount) in your bank account until the transfer is complete to avoid any issues."
                GainyAnalytics.logEvent("dw_withdraw_done", params: ["amount" : amount])
        }
    }
    
    private var history: TradingHistoryFrag?
    
    private func checkDetails() {
        detailsBtn.isHidden = true
        showNetworkLoader()
        Task {
            do {
                history = try await dwAPI.getTradingMoneyByID(tradingMoneyID: tradingFlowId).first
                await MainActor.run {
                    detailsBtn.isHidden = false
                    hideLoader()
                }
            } catch {
                await MainActor.run {
                    detailsBtn.isHidden = true
                    hideLoader()
                }
            }
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func doneAction(_ sender: Any) {
        coordinator?.navController.dismiss(animated: true)
    }
    
    @IBAction func showDetailsAction(_ sender: Any) {
        if let history {
            coordinator?.showHistoryOrderDetails(amount: amount,
                                                 name: history.name ?? "",
                                                 mode: .other(history: history))
        }
    }
}
