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
    
    
    
}

extension UITableViewCell {
    func addSwiftUIIfPossible(_ view: UIView, viewTag: Int = TickerDetailsDataSource.hostingTag, oldTag: Int = -1) -> Bool {
        if oldTag != -1 {
            subviews.filter({$0.tag == oldTag}).forEach({$0.removeFromSuperview()})
        }
        guard !subviews.contains(where: {$0.tag == viewTag}) else {
            return false
        }
        addSubview(view)
        return true
    }
}
