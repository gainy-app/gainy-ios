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
    let color: String
}

public final class DWOrderDetailsViewController: DWBaseViewController {
    
    public var amount: Double = 0.0
    public var collectionId: Int = 0
    public var name: String = ""
    
    public var tags: [DWHistoryTag] = []
    
    public enum Mode {
        case original, sell, history
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
    
    private enum TopMargin: CGFloat {
        case main = 64.0
        case history = 80.0
    }
    
    @IBOutlet private weak var mainStackTopMargin: NSLayoutConstraint!
    @IBOutlet private weak var tagsStack: UIStackView!
    
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
        amountLbl.text = amount.price
        
        #if DEBUG
        tags = [DWHistoryTag(name: "SELL", color: "#687379"), DWHistoryTag(name: "PENDING", color: "#FCB224")]
        #endif
        
        switch mode {
        case .original:
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            break
        case .sell:
            titleLbl.text = "You’ve sold \(amount.price) in \(name)"
            break
        case .history:
            titleLbl.text = "You’ve invested \(amount.price) in \(name)"
            labels[0].text = "Paid with"
            if tags.isEmpty {
                mainStackTopMargin.constant = TopMargin.main.rawValue
            } else {
                mainStackTopMargin.constant = TopMargin.history.rawValue
                for tag in tags {
                    let tagView = TagLabelView()
                    tagView.tagText = tag.name
                    tagView.textColor = UIColor(hexString: tag.color)
                    tagsStack.addArrangedSubview(tagView)
                }
            }
            bottomLbl.text = "Your order is pending\nand will be completed by 10:30 AM\nnext business day"
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
