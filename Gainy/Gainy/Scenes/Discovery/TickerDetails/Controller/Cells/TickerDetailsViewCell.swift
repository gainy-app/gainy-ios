//
//  TickerDetailsViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit
import SkeletonView

/// Base Ticker TableView cell
class TickerDetailsViewCell: UITableViewCell {
    
    var cellHeightChanged: ((CGFloat) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
    }
    
    var tickerInfo: TickerInfo? {
        didSet {
            updateFromTickerData()
        }
    }
    
    func updateFromTickerData() {
        
    }
    
    
    func addSwiftUIIfPossible(_ view: UIView) -> Bool {
        guard !subviews.contains(where: {$0.tag == TickerDetailsDataSource.hostingTag}) else {
            return false
        }
        addSubview(view)
        return true
    }
}
