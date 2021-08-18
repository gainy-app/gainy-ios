//
//  UIView+Gainy.swift
//  Gainy
//
//  Created by Anton Gubarenko on 18.08.2021.
//

import UIKit

extension UIView {
    func create<T: UIView>(_ setup: (T)-> ()) -> T {
        let obj = T()
        setup(obj)
        return obj
    }
}
