//
//  BuyingPowerCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 22.11.2022.
//

import Foundation
import UIKit

final class BuyingPowerCell: HoldingRangeableCell {
    
    @IBOutlet private weak var buyPowerTtl: UILabel!
    @IBOutlet private weak var buyPowerLbl: UILabel!
    
    func configureWithPrice(title: String, amount: Float) {
        buyPowerTtl.text = title
        buyPowerLbl.text = amount.priceUnchecked
    }
    
    func configureWith(title: String, amount: Int) {
        buyPowerTtl.text = title
        buyPowerLbl.text = "\(amount)"
    }
}

