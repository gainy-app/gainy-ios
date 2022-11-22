//
//  UIView+Extensions.swift
//  GainyCommon
//
//  Created by Евгений Таран on 18.11.22.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
