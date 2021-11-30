//
//  SwitchTableViewCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/29/21.
//

import UIKit

protocol SwitchTableViewCellDelegate: AnyObject {
    
    func switchValueChanged(_ sender: SwitchTableViewCell)
}

final class SwitchTableViewCell: UITableViewCell {

    public weak var delegate: SwitchTableViewCellDelegate?
    
    @IBOutlet weak var customTitleLabel: UILabel!
    
    @IBOutlet weak var dotsImageView: UIImageView!
    @IBOutlet weak var valueSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        self.delegate?.switchValueChanged(self)
    }
    
    public override func prepareForReuse() {
        
        super.prepareForReuse()
        self.dotsImageView.isHidden = true
        self.customTitleLabel.text = ""
    }
}
