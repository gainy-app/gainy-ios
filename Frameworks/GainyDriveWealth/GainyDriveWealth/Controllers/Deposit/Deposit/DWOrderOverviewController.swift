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
    
    private func loadState() {
        initDateLbl.text = dateFormatter.string(from: Date()).uppercased()
        amountLbl.text = "$" + (amountFormatter.string(from: NSNumber(value: amount)) ?? "-")
        
        titleLbl.text = "Order Overview"
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
                        coordinator?.showOrderSpaceDone(amount: amount, collectionId: collectionId, name: name)
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
                        coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .buy)
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
                        coordinator?.showOrderOverview(amount: amount, collectionId: collectionId, name: name, mode: .sell)
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
