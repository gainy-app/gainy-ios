//
//  HomeArticlesTableViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.02.2022.
//

import UIKit

final class HomeArticlesTableViewCell: UITableViewCell {
    
    @IBOutlet private var cornerView: CornerView! {
        didSet {
            cornerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
            cornerView.layer.shadowOpacity = 1
            cornerView.layer.shadowOffset = CGSize.init(width: 0, height: 4)
            cornerView.layer.shadowRadius = 10
            cornerView?.clipsToBounds = false
        }
    }
    
}
