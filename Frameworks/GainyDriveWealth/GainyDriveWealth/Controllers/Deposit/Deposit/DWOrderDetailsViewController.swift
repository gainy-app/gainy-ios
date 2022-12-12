//
//  DWOrderDetailsViewController.swift
//  GainyDriveWealth
//
//  Created by Anton Gubarenko on 05.10.2022.
//

import UIKit
import GainyCommon

public struct DWHistoryTag {
    let name: String
    
    func colorForTag() -> String? {
        switch name {
        case "buy".uppercased(), "deposit".uppercased(), "Withdraw".uppercased(), "sell".uppercased():
            return "38CF92"
        case "ttf".uppercased(), "ticker".uppercased():
            return "6C5DD3"
        case "pending".uppercased():
            return "FCB224"
        case "canceled".uppercased():
            return "3A4448"
        case "error".uppercased():
            return "F95664"
        default:
            return nil
        }
    }
}

public final class DWOrderDetailsViewController: DWBaseViewController {
    
    public var amount: Double = 0.0
    public var collectionId: Int = 0
    public var name: String = ""
    
    public var tags: [DWHistoryTag] = []
    
    public enum Mode {
        case original, sell
    }
    
    public var mode: Mode = .original
    
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
    
    public override func viewWillAppear(_ animated: Bool) {
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
                
        switch mode {
        case .original:
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            amountLbl.text = amount.price
            break
        case .sell:
            titleLbl.text = "You’ve sold \(abs(amount).price) in \(name)"
            amountLbl.text = abs(amount).price
            break
        }
        accountLbl.text = userProfile.selectedFundingAccount?.name ?? ""
        
        showNetworkLoader()
        Task {
            let accountNumber = await userProfile.getProfileStatus()
            await MainActor.run {
                kycNumberLbl.text = accountNumber?.accountNo
                hideLoader()
            }
        }
    }
    
    //MARK: - Actions
    
    @IBAction func safeAsPDFAction(_ sender: Any) {
        coordinator?.navController.dismiss(animated: true)
    }
}
