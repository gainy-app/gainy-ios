//
//  CurrentPositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 10.11.22.
//

import UIKit

class CurrentPositionCell: UICollectionViewCell {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    
    @IBAction func closeDidTap(_ sender: UIButton) {
        
    }
    
    func configureCell(with model: CurrentPositionCellModel) {
        
    }
}
