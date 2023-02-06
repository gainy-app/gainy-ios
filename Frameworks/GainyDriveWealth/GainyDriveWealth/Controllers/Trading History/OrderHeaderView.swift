//
//  OrderHeaderView.swift
//  Gainy
//
//  Created by Serhii Borysov on 9/3/21.
//

import UIKit
import Foundation
import GainyCommon

final class OrderHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .proDisplaySemibold(16)
        }
    }
    
}
