//
//  BuyingPowerDetailsViewController.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.11.2022.
//

import Foundation

final class BuyingPowerDetailsViewController: BaseViewController {
    
    var coordinator: MainCoordinator?
    
    //MARK: - Outlets
    @IBOutlet private weak var titleLbl: UILabel!
    
    @IBOutlet private weak var buyingPowerValue: UILabel!
    @IBOutlet private weak var withdrawValue: UILabel!
    @IBOutlet private weak var pendingTtl: UILabel!
    @IBOutlet private weak var pendingValue: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadState()
    }
    
    private func loadState() {
        if let kycData = UserProfileManager.shared.kycStatus {
            titleLbl.text = "Buying power\n\(kycData.buyingPower?.priceUnchecked ?? "")"
            buyingPowerValue.text = kycData.buyingPower?.priceUnchecked ?? "-"
            withdrawValue.text = kycData.withdrawableCash?.priceUnchecked ?? "-"
            if let pendingCache =
                kycData.pendingCash, pendingCache > 0.0 {
                pendingTtl.isHidden = false
                pendingValue.text = pendingCache.priceUnchecked
            } else {
                pendingTtl.isHidden = true
                pendingValue.text = ""
            }
        } else {
            titleLbl.text = "Buying power\n"
            buyingPowerValue.text = ""
            withdrawValue.text = ""
            pendingValue.text = ""
        }
    }
    
    //MARK: - Actions
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func withdrawAction(_ sender: UIButton) {
        coordinator?.dwShowWithdraw(from: self)
    }
    
    @IBAction func depositAction(_ sender: UIButton) {
        coordinator?.dwShowDeposit(from: self)
        GainyAnalytics.logEventAMP("deposit_s", params: ["source" : "buying_power"])
    }
    
}
