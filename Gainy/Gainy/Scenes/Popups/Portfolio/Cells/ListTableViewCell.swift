//
//  ListTableViewCell.swift
//  Gainy
//
//  Created by Serhii Borysov on 11/29/21.
//

import UIKit

final class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var customTitleLabel: UILabel!
    @IBOutlet weak var dotsImageView: UIImageView!
    
    public override func prepareForReuse() {
        
        super.prepareForReuse()
        self.dotsImageView.isHidden = true
        self.customTitleLabel.text = ""
    }
}
