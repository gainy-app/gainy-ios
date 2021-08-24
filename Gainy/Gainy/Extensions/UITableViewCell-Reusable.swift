//
//  UITableViewCell-Reusable.swift
//  Gainy
//
//  Created by Anton Gubarenko on 20.08.2021.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.cellIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let id = T.cellIdentifier
        let cell = dequeueReusableCell(withIdentifier: id, for: indexPath) as! T
        return cell
    }
}

extension UITableViewCell {
    class var cellIdentifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
    
    func moveAndHide() {
        contentView.transform = CGAffineTransform.init(translationX: 0, y: 72.0)
        contentView.alpha = 0.0
    }
    
    func moveAndShow() {
        UIView.animate(withDuration: 0.3, delay: 0.2, options: [.curveLinear, .allowUserInteraction], animations: {
            self.contentView.transform = .identity
            self.contentView.alpha = 1
        }, completion: nil)
        
    }
}
