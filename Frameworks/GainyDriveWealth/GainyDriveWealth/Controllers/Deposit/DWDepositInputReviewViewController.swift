//
//  DWDepositInputReviewViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 19.09.2022.
//

import UIKit
import GainyCommon

final class DWDepositInputReviewViewController: DWBaseViewController {
        
    
    var amount: Double = 0.0
    var mode: DWDepositMode = .deposit
    
    @IBOutlet private weak var titleLbl: UILabel! {
        didSet {
            titleLbl.font = UIFont.proDisplaySemibold(24)
        }
    }
    
    @IBOutlet private weak var nextBtn: GainyButton! {
        didSet {
            nextBtn.configureWithTitle(title: "Transfer", color: UIColor.white, state: .normal)
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
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gainyNavigationBar.configureWithItems(items: [.close, .back])
        self.gainyNavigationBar.backActionHandler = {[weak self] sender in
            self?.coordinator?.pop()
        }
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
        availDateLbl.text = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()).uppercased()
        amountLbl.text = "$" + (amountFormatter.string(from: NSNumber(value: amount)) ?? "-")
        
        switch mode {
        case .deposit:
            titleLbl.text = "Deposit Overview"
        case .withdraw:
            titleLbl.text = "Withdraw Overview"
        case .invest:
            titleLbl.text = "Order Overview"
        }
    }
    
    //MARK: - Actions
    
    @IBAction func transferAction(_ sender: Any) {
        switch mode {
        case .deposit:
            coordinator?.showDepositDone(amount:  amount)
            break
        case .withdraw:
            coordinator?.showWithdrawDone(amount:  amount)
            break
        case .invest:
            break
        }
    }
}
