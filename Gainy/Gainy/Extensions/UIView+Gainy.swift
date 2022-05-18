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
    
        func addDashedBorder() {
            let color = UIColor(hexString: "#B1BDC8")!.cgColor
            
            let shapeLayer:CAShapeLayer = CAShapeLayer()
            let frameSize = self.frame.size
            let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
            
            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = color
            shapeLayer.lineWidth = 1
            shapeLayer.lineJoin = CAShapeLayerLineJoin.round
            shapeLayer.lineDashPattern = [1, 3]
            shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 16).cgPath
            self.layer.addSublayer(shapeLayer)
        }
}
