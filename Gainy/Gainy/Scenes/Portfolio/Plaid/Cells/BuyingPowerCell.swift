//
//  BuyingPowerCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 22.11.2022.
//

import Foundation
import UIKit

final class BuyingPowerCell: HoldingRangeableCell {
    
    @IBOutlet private weak var buyPowerLbl: UILabel!
    
    var amount: Float = 0.0 {
        didSet {
            buyPowerLbl.text = amount.price
        }
    }
}

