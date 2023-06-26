//
//  HoldingPendingCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 25.06.2023.
//

import Foundation
import UIKit

final class HoldingPendingCell: HoldingRangeableCell {
    
    static let depositHeight: CGFloat = 224.0
    static let depositOrdersHeight: CGFloat = 176.0 + 12.0
    
    @IBOutlet private weak var pendingHeaderLbl: UILabel!
    @IBOutlet private weak var pendingAmountLbl: UILabel!
    @IBOutlet private weak var pendingFooterLbl: UILabel!
    
    func configureWithPendingDeposit(amount: Float) {
        pendingHeaderLbl.text = "Your funds should be credited to your\naccount within the next few days."
        pendingAmountLbl.text = amount.priceUnchecked
        pendingFooterLbl.text = "Meanwhile, feel free to place orders\nand we will execute them once the money\narrives."
        contentView.fillRemoteBack()
    }
    
    func configureWithPendingDepositAndOrder(amount: Float) {
        pendingHeaderLbl.text = "Your order has been received"
        pendingAmountLbl.text = amount.priceUnchecked
        pendingFooterLbl.text = "Once we receive your deposit, we will\ninitiate the execution of your order."
        contentView.fillRemoteBack()
    }
}
