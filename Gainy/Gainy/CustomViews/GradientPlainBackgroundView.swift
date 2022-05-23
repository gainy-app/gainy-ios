//
//  GradientPlainBackgroundView.swift
//  Gainy
//
//  Created by Anton Gubarenko on 23.05.2022.
//

import UIKit

@IBDesignable class GradientPlainBackgroundView: UIView {
    // implement cgcolorgradient in the next section
    @IBInspectable var startColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient; gradientLayer.locations = locations }
    }
    
    @IBInspectable var endColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient; gradientLayer.locations = locations }
    }

    @IBInspectable var startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0) {
        didSet { gradientLayer.startPoint = startPoint; gradientLayer.locations = locations }
    }
    
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet { gradientLayer.endPoint = endPoint; gradientLayer.locations = locations }
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
}

extension GradientPlainBackgroundView {
    // For this implementation, both colors are required to display
    // a gradient. You may want to extend cgColorGradient to support
    // other use cases, like gradients with three or more colors.
    internal var cgColorGradient: [CGColor]? {
        guard let startColor = startColor, let endColor = endColor else {
            return nil
        }
        
        return [startColor.cgColor, endColor.cgColor]
    }
    
    internal var locations: [NSNumber]? {
        return [NSNumber(0.0), NSNumber(1.0)]
    }
}
