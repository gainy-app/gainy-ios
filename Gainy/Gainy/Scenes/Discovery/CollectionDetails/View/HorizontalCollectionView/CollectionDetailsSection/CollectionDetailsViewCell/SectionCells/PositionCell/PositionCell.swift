//
//  PositionCell.swift
//  Gainy
//
//  Created by Евгений Таран on 15.11.22.
//

import UIKit

final class PositionCell: UICollectionViewCell {
    @IBOutlet private weak var todayReturnLabel: UILabel!
    @IBOutlet private weak var todayReturnValueLabel: UILabel!
    
    @IBOutlet private weak var totalReturnLabel: UILabel!
    @IBOutlet private weak var totalReturnValueLabel: UILabel!
    
    @IBOutlet private weak var ttfValueLabel: UILabel!
    
    @IBOutlet private weak var progressView: PlainCircularProgressBar!
    @IBOutlet private weak var progressLabel: UILabel!
    
    
}
