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
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var buyingPowerValue: UILabel!
    @IBOutlet weak var withdrawValue: UILabel!
    @IBOutlet weak var pendingValue: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadState()
    }
    
    private func loadState() {
        if let kycData = UserProfileManager.shared.kycStatus {
            titleLbl.text = "Buying power\n\(kycData.buyingPower?.priceUnchecked ?? "")"
            buyingPowerValue.text = kycData.buyingPower?.priceUnchecked ?? "-"
            withdrawValue.text = kycData.withdrawableCash?.priceUnchecked ?? "-"
            pendingValue.text = kycData.pendingCash?.priceUnchecked ?? "-"
        } else {
            titleLbl.text = "Buying power\n"
            buyingPowerValue.text = "-"
            withdrawValue.text = "-"
            pendingValue.text = "-"
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
    }
    
}
