//
//  HoldingChartTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 16.11.2021.
//

import Foundation
import UIKit

protocol HoldingNeedReconnectPlaidTableViewCellDelegate: AnyObject {
    func onConnectButtonTapped()
    func onCloseButtonTapped()
}

final class HoldingNeedReconnectPlaidTableViewCell: HoldingRangeableCell {
    
    weak var delegate: HoldingNeedReconnectPlaidTableViewCellDelegate?
    
    @IBOutlet private weak var connectButton: ResponsiveButton! {
        didSet {
            connectButton.setImage(UIImage(named: "connectButton"), for: .normal)
            connectButton.tintColor = UIColor.init(hexString: "#25EA5C")
            connectButton.setTitle("", for: .normal)
        }
    }
    @IBOutlet private weak var closeButton: ResponsiveButton! {
        didSet {
        
            closeButton.setImage(UIImage(named: "closeHoldingGreen"), for: .normal)
            closeButton.tintColor = UIColor.init(hexString: "#25EA5C")
            closeButton.setTitle("", for: .normal)
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var cornerView: UIView! {
        didSet {
            cornerView.layer.cornerRadius = 16.0
            cornerView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            cornerView.clipsToBounds = true
        }
    }
    
    //MARK: - Actions
    
    @IBAction func connectButtonAction() {
        delegate?.onConnectButtonTapped()
    }
    
    @IBAction func closeButtonAction() {
        delegate?.onCloseButtonTapped()
    }
}
