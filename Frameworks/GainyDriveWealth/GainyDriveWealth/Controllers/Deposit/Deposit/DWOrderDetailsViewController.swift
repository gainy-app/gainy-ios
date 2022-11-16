//
//  DWOrderDetailsViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon

final class DWOrderDetailsViewController: DWBaseViewController {
    
    var amount: Double = 0.0
    var collectionId: Int = 0
    var name: String = ""
    
    enum Mode {
        case original, sell
    }
    
    var mode: Mode = .original
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Done", color: UIColor.white, state: .normal)
        }
    }
    @IBOutlet private var labels: [UILabel]! {
        didSet {
            labels.forEach({$0.font = .proDisplaySemibold(16)})
        }
    }
    @IBOutlet private weak var initDateLbl: UILabel!
    @IBOutlet private weak var availDateLbl: UILabel!
    @IBOutlet private weak var statusLbl: UILabel!
    @IBOutlet private weak var amountLbl: UILabel!
    @IBOutlet private weak var bottomLbl: UILabel! {
        didSet {
            bottomLbl.font = .proDisplayRegular(14)
        }
    }
    @IBOutlet private weak var accountLbl: UILabel!
    @IBOutlet private weak var kycNumberLbl: UILabel!
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadState()
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.dateFormat = "MMM dd, yyyy"
        return dt
    }()
    
    lazy var amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private func loadState() {
        initDateLbl.text = dateFormatter.string(from: Date()).uppercased()
        amountLbl.text = amount.price
        if mode == .original {
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
        } else {
            titleLbl.text = "You’ve sold \(amount.price) in \(name)"
        }
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        
        showNetworkLoader()
        Task {
            let accountNumber = await userProfile.getProfileStatus()
            await MainActor.run {
                kycNumberLbl.text = accountNumber?.accountNo
            }
            await MainActor.run {
                kycNumberLbl.text = ""
                hideLoader()
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func safeAsPDFAction(_ sender: Any) {
        coordinator?.navController.dismiss(animated: true)
    }
}
