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

extension UIView {

    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
