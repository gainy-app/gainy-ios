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
            contentView.subviews.filter({$0.tag == oldTag}).forEach({$0.removeFromSuperview()})
        }
        guard !contentView.subviews.contains(where: {$0.tag == viewTag}) else {
            return false
        }
        view.isSkeletonable = false
        contentView.insertSubview(view, at: 0)
        return true
    }
}

extension UICollectionViewCell {
    func addSwiftUIIfPossible(_ view: UIView, viewTag: Int = TickerDetailsDataSource.hostingTag, oldTag: Int = -1) -> Bool {
        if oldTag != -1 {
            contentView.subviews.filter({$0.tag == oldTag}).forEach({$0.removeFromSuperview()})
        }
        guard !contentView.subviews.contains(where: {$0.tag == viewTag}) else {
            return false
        }
        view.isSkeletonable = false
        contentView.insertSubview(view, at: 0)
        return true
    }
}
