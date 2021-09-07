//
//  GradientBackgroundView.swift
//  Gainy
//
//  Created by Serhii Borysov on 8/28/21.
//

import UIKit


@IBDesignable class GradientBackgroundView: UIView {
    // implement cgcolorgradient in the next section
    @IBInspectable var startColor: UIColor? {
        didSet { gradientLayer.colors = cgColorGradient; gradientLayer.locations = locations }
    }

    @IBInspectable var middleColor: UIColor? {
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

    @IBInspectable var middleLocation: Double = Double(0.5) {
        didSet { gradientLayer.locations = locations }
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
}

extension GradientBackgroundView {
    // For this implementation, both colors are required to display
    // a gradient. You may want to extend cgColorGradient to support
    // other use cases, like gradients with three or more colors.
    internal var cgColorGradient: [CGColor]? {
        guard let startColor = startColor, let middleColor = middleColor, let endColor = endColor else {
            return nil
        }
        
        return [startColor.cgColor, middleColor.cgColor, endColor.cgColor]
    }
    
    internal var locations: [NSNumber]? {
        let midLocation = middleLocation
        return [NSNumber(0.0), NSNumber(floatLiteral: midLocation), NSNumber(1.0)]
    }
}
