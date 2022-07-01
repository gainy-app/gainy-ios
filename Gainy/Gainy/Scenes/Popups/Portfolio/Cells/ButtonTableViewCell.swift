//
//  ButtonTableViewCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/29/21.
//

import UIKit

protocol ButtonTableViewCellDelegate: AnyObject {
    
    func disconnectButtonTouchUpInside(_ sender: ButtonTableViewCell)
    func connectButtonTouchUpInside(_ sender: ButtonTableViewCell)
}

final class ButtonTableViewCell: UITableViewCell {

    public weak var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var customTitleLabel: UILabel!
    
    @IBOutlet weak var dotsImageView: UIImageView!
    @IBOutlet weak var disconnectButton: BorderButton!
    @IBOutlet weak var connectButton: BorderButton!
    
    @IBAction func disconnectButtonTouchUpInside(_ sender: Any) {
        self.delegate?.disconnectButtonTouchUpInside(self)
    }
    
    @IBAction func connectButtonTouchUpInside(_ sender: Any) {
        self.delegate?.connectButtonTouchUpInside(self)
    }
    
    
    public override func prepareForReuse() {
        
        super.prepareForReuse()
        self.dotsImageView.isHidden = true
        self.customTitleLabel.text = ""
    }
}
